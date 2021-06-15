import 'package:finance/database/AppDatabase.dart';
import 'package:finance/database/MonthSalaryDao.dart';
import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/utils/Constants.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sembast/sembast.dart';

class SimpleRegisterDao {

  static const String CATEGORY_STORE_NAME = 'simpleregister';

  final _simpleRegister = intMapStoreFactory.store(CATEGORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(SimpleRegister simpleRegister) async {
    await _simpleRegister.add(await _db, simpleRegister.toMap());
  }

  Future clearWholeStore() async {
    await _simpleRegister.delete(await _db);
  }

  Future update(SimpleRegister simpleRegister) async{

    final finder = Finder(filter: Filter.byKey(simpleRegister.key));
    await _simpleRegister.update(
        await _db,
        simpleRegister.toMap(),
        finder: finder
    );
  }

  Future deleteCreditCard({id}) async {
    final filter = Filter.equals('idCategory', id);

    final finder = Finder(filter: filter);

    await _simpleRegister.delete(await _db, finder: finder);
  }

  Future delete(SimpleRegister simpleRegister) async {
    final finder = Finder(filter: Filter.byKey(simpleRegister.key));

    await _simpleRegister.delete(await _db, finder: finder);

  }

  //<Map<String, dynamic>>
  Future reduceIncomeAndExpenseSimpleRegister({required int selectedDateByMill, required int lastMonthByMill}) async {
    final filter = Filter.custom((record){
      final data = record.value;

      var selected = Jiffy.unix(selectedDateByMill);
      var firstInstallment = Jiffy.unix(data["firstInstallment"]);
      var lastInstallment = Jiffy.unix(data["lastInstallment"]);

      if(firstInstallment.isSameOrBefore(selected, Units.MONTH) && lastInstallment.isSameOrAfter(selected, Units.MONTH)){
        return true;
      }

      return false;
    });

    final finder = Finder(filter: filter);

    final recordSnapshot = await _simpleRegister.find(await _db, finder: finder);

    print(recordSnapshot.length);

    double income = 0.0;
    double expense = 0.0;

    recordSnapshot.forEach((element) {
      Map<String, dynamic> simpleRegisterMap = element.value;
      if(simpleRegisterMap['isIncome'] == Constants.INCOME){
        income += simpleRegisterMap['price'] / double.parse(simpleRegisterMap["installments"].toString());
      }else{
        expense += simpleRegisterMap['price'] / double.parse(simpleRegisterMap["installments"].toString());
      }
    });

    return {
      Constants.INCOME: income,
      Constants.EXPENSE: expense
    };
  }

  Future<List<SimpleRegister>> getAllSimpleRegisterByMonthLimit({required int selectedDateByMill}) async {
    final filter =  Filter.custom((record){
      final data = record.value;

      var selected = Jiffy.unix(selectedDateByMill);
      var firstInstallment = Jiffy.unix(data["firstInstallment"]);
      var lastInstallment = Jiffy.unix(data["lastInstallment"]);

      if(firstInstallment.isSameOrBefore(selected, Units.MONTH) && lastInstallment.isSameOrAfter(selected, Units.MONTH)){
        return true;
      }

      return false;
    });
    final finder = Finder(filter: filter, limit: Constants.QTY_SIMPLE_REGISTER, sortOrders: [SortOrder('createdAt', false)]);

    final recordSnapshot = await _simpleRegister.find(await _db, finder: finder);

    return recordSnapshot.map((e){

      return SimpleRegister.fromMapDb(e.value, e.key);
    }).toList();
  }

  Future<List<SimpleRegister>> reduceEachCards({required Map<String, dynamic> keys, required selectedDateByMill}) async {
    final filter =  Filter.custom((record){
      final data = record.value;

      if(keys[data["idCategory"]] == null){
        return false;
      }

      var selected = Jiffy.unix(selectedDateByMill);
      var firstInstallment = Jiffy.unix(data["firstInstallment"]);
      var lastInstallment = Jiffy.unix(data["lastInstallment"]);

      if(firstInstallment.isSameOrBefore(selected, Units.MONTH) && lastInstallment.isSameOrAfter(selected, Units.MONTH)){
        return true;
      }

      return false;
    });
    final finder = Finder(filter: filter);

    final recordSnapshot = await _simpleRegister.find(await _db, finder: finder);

    return recordSnapshot.map((e){

      return SimpleRegister.fromMapDb(e.value, e.key);
    }).toList();
  }

  Future reduceByMonth({required Jiffy firstMonth, required Jiffy lastMonth, required int selectedDate}) async {
    final filter = Filter.custom((record){
      final data = record.value;
      var firstInstallment = Jiffy.unix(data["firstInstallment"]);

      return firstInstallment.isBetween(firstMonth, lastMonth, Units.MONTH);
    });

    final finder = Finder(filter: filter);

    final recordSnapshot = await _simpleRegister.find(await _db, finder: finder);


    var reducerMapIncome = <String, dynamic>{

    };

    var reducerMapExpense = <String, dynamic>{

    };

    MonthSalaryDao monthSalaryDao = MonthSalaryDao();


    await Future.forEach([-2, -1, 0, 1, 2], (num) async {
      dynamic e = num;
      if(e < 0){
        Jiffy date = Jiffy.unix(selectedDate).subtract(months: e * -1);
        var result = await monthSalaryDao.getSalaryByDate(date.dateTime.millisecondsSinceEpoch);
        double salary = result != null ? result.salary : 0.0;
        reducerMapIncome[date.yMMM] = {"total": 0.0 + salary, "month": date.yMMM};
        reducerMapExpense[date.yMMM] = {"total": 0.0, "month": date.yMMM};
      }else if(e > 0){
        Jiffy date = Jiffy.unix(selectedDate).add(months: e);
        var result = await monthSalaryDao.getSalaryByDate(date.dateTime.millisecondsSinceEpoch);
        double salary = result != null ? result.salary : 0.0;
        reducerMapIncome[date.yMMM] = {"total": 0.0 + salary, "month": date.yMMM};
        reducerMapExpense[date.yMMM] = {"total": 0.0, "month": date.yMMM};
      }else{
        Jiffy date = Jiffy.unix(selectedDate);
        var result = await monthSalaryDao.getSalaryByDate(date.dateTime.millisecondsSinceEpoch);
        double salary = result != null ? result.salary : 0.0;
        reducerMapIncome[date.yMMM] = {"total": 0.0 + salary, "month": date.yMMM};
        reducerMapExpense[date.yMMM] = {"total": 0.0, "month": date.yMMM};
      }
    });

    reducerMapIncome.forEach((key, value) {
      var date = Jiffy(value["month"], 'yMMM');
      recordSnapshot.forEach((element) {
        Map<String, dynamic> simpleRegisterMap = element.value;
        var firstInstallment = Jiffy.unix(simpleRegisterMap["firstInstallment"]);
        var lastInstallment = Jiffy.unix(simpleRegisterMap["lastInstallment"]);

        if(firstInstallment.isSameOrBefore(date, Units.MONTH) && lastInstallment.isSameOrAfter(date, Units.MONTH)) {
          if (simpleRegisterMap['isIncome'] == Constants.INCOME) {
            reducerMapIncome[date.yMMM]["total"] =
                reducerMapIncome[date.yMMM]["total"] +
                    (simpleRegisterMap['price'] / double.parse(
                        simpleRegisterMap["installments"].toString()));
          } else {
            reducerMapExpense[date.yMMM]["total"] =
                reducerMapExpense[date.yMMM]["total"] +
                    (simpleRegisterMap['price'] / double.parse(
                        simpleRegisterMap["installments"].toString()));
          }
        }
      });
    });

    return {
      Constants.EXPENSE: reducerMapIncome,
      Constants.INCOME: reducerMapExpense
    };
  }

  Future getAllSimpleRegisterByMonth({required int selectedDate}) async {
    final filter = Filter.custom((record){
      final data = record.value;

      var selected = Jiffy.unix(selectedDate);
      var firstInstallment = Jiffy.unix(data["firstInstallment"]);
      var lastInstallment = Jiffy.unix(data["lastInstallment"]);

      if(firstInstallment.isSameOrBefore(selected, Units.MONTH) && lastInstallment.isSameOrAfter(selected, Units.MONTH)){
        return true;
      }

      return false;
    });

    final finder = Finder(filter: filter);

    final recordSnapshot = await _simpleRegister.find(await _db, finder: finder);

    print(recordSnapshot.length);

    return recordSnapshot.map((e){

      return SimpleRegister.fromMapDb(e.value, e.key);
    }).toList();
  }

  Future<List<SimpleRegister>> getRegistersById({id}) async {
    final filter = Filter.equals("idCategory", id);

    final finder = Finder(filter: filter, sortOrders: [SortOrder('createdAt')]);

    final recordSnapshot = await _simpleRegister.find(await _db, finder: finder);

    return recordSnapshot.map((e){

      return SimpleRegister.fromMapDb(e.value, e.key);
    }).toList();
  }

}