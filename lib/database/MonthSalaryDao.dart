import 'package:finance/database/AppDatabase.dart';
import 'package:finance/model/Category.dart';
import 'package:finance/model/MonthSalary.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sembast/sembast.dart';

class MonthSalaryDao {

  static const String CATEGORY_STORE_NAME = 'salary';

  final _monthSalaryStore = intMapStoreFactory.store(CATEGORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(MonthSalary monthSalary) async{
    final finder = Finder(filter: Filter.equals("dateMilli", monthSalary.dateMilli));

    final recordSnapshot = await _monthSalaryStore.findFirst(await _db, finder: finder);

    if(recordSnapshot != null){
      await _monthSalaryStore.update(await _db, monthSalary.toMap(), finder: finder);
    }else{
      await _monthSalaryStore.add(await _db, monthSalary.toMap());
    }
  }

  Future clearWholeStore() async {
    await _monthSalaryStore.delete(await _db);
  }

  Future getSalaryByDate(int dateMilli) async {
    final finder = Finder(filter: Filter.custom((record) => Jiffy(Jiffy.unix(dateMilli).yMMM, 'yMMM').isSame(Jiffy.unix(record.value['dateMilli']))));

    final recordSnapshot = await _monthSalaryStore.findFirst(await _db, finder: finder);

    if(recordSnapshot == null){
      return null;
    }

    return MonthSalary.fromDb(recordSnapshot.value, recordSnapshot.key);
  }

  Future<List<MonthSalary>> getAllSalary() async {
    final finder = Finder(sortOrders: [
      SortOrder("dateMilli")
    ]);

    final recordSnapshot = await _monthSalaryStore.find(await _db, finder: finder);

    return recordSnapshot.map((e) {
      return MonthSalary.fromDb(e.value, e.key);
    }).toList();
  }


}