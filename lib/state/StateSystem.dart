import 'package:finance/Dialogs/DialogRemoveCreditCard.dart';
import 'package:finance/database/CategoryDao.dart';
import 'package:finance/database/CreditCardDao.dart';
import 'package:finance/database/MonthSalaryDao.dart';
import 'package:finance/database/SimpleRegisterDao.dart';
import 'package:finance/model/CreditCard.dart';
import 'package:finance/model/MonthSalary.dart';
import 'package:finance/routes/app_pages.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/StorageUtil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StateSystem extends GetxController {

  CategoryDao categoryDao = CategoryDao();

  SimpleRegisterDao simpleRegisterDao = SimpleRegisterDao();

  CreditCardDao _creditCardDao = CreditCardDao();

  var showMoney = true.obs;

  var selectedDate = DateTime.now().millisecondsSinceEpoch.obs;

  var arrayDataSimpleRegister = [].obs;

  var arrayCreditCards = [].obs;

  var mapReduceCreditCards = {}.obs;

  var salary = 0.0.obs;

  var income = 0.0.obs;

  var expense = 0.0.obs;

  var dataSummaryChart = [[], []].obs;

  Future removeSimpleRegister(simpleRegister) async {
    await simpleRegisterDao.delete(simpleRegister);
    Get.back();
    loadInitialData();
  }

  Future removeCreditCard({required idCreditCard}) async {
    CreditCard creditCard = getCreditCard(idCreditCard);
    await simpleRegisterDao.deleteCreditCard(id: creditCard.id);
    await _creditCardDao.deleteCreditCard(creditCard);
    Get.back();
    Get.back();
  }

  Future getSalaryByDate() async {
    MonthSalaryDao monthSalaryDao = MonthSalaryDao();
    final responseSalary = await monthSalaryDao.getSalaryByDate(Jiffy.unix(selectedDate.value).dateTime.millisecondsSinceEpoch);

    if(responseSalary != null){
      salary.value = responseSalary.salary;
    }else{
      salary.value = 0.0;
    }
  }

  Future getFewSimpleRegister() async {
    final response = await simpleRegisterDao.getAllSimpleRegisterByMonthLimit(selectedDateByMill: selectedDateByMill);

    arrayDataSimpleRegister.value = response;
  }

  Future getExpenseAndIncome() async {
    final reduce = await simpleRegisterDao.reduceIncomeAndExpenseSimpleRegister(
        selectedDateByMill: selectedDateByMill,
        lastMonthByMill: lastMonthByMill
    );

    income.value = reduce[Constants.INCOME] + salary.value;
    expense.value = reduce[Constants.EXPENSE];
  }

  Future loadInitialData() async {

    await Future.wait([
      loadCreditCards(),
      getFewSimpleRegister(),
      getExpenseAndIncome(),
      getSalaryByDate(),
      loadSummaryChart()
    ]);

    update();

  }

  Future changeSelectedDate(DateRangePickerSelectionChangedArgs e) async {
    selectedDate.value = e.value.millisecondsSinceEpoch;

    await loadInitialData();
  }

  @override
  void onInit() async {

    final showIntro = StorageUtil.getBool('showIntro');

    if(showIntro != false){
      StorageUtil.putBool('showIntro', false);
    }

    await loadInitialData();

    super.onInit();
  }

  Future loadDataCrediCards() async {
    final response = await _creditCardDao.getAllSortedByName();

    arrayCreditCards.value = response;
  }

  Future loadCreditCards() async {

    final response = await _creditCardDao.getAllSortedByName();

    arrayCreditCards.value = response;

    if(response.length > 0){
      var keys = Map<String, dynamic>.fromIterable(response,
          key: (item) => item.id,
          value: (item) => 0.0
      );

      final reduceEachCard = await simpleRegisterDao.reduceEachCards(
          keys: keys,
          selectedDateByMill: selectedDate.value
      );

      reduceEachCard.forEach((element) {
        var val = element.price;
        if(element.installments > 1) {
          var diff = Jiffy.unix(selectedDate.value).diff(
              Jiffy.unix(element.firstInstallment), Units.MONTH);

          if (diff > 0) {
            var priceByInstall = element.price /
                double.parse(element.installments.toString());

            val = element.price - (priceByInstall * diff);
          }
        }

        keys["${element.idCategory}"] = keys[element.idCategory] + val;
        print(keys[element.idCategory] + val);
      });

      mapReduceCreditCards.value = keys;

    }

  }

  double getCreditCardExpenseById(idCreditCard){
    return mapReduceCreditCards[idCreditCard] != null ? mapReduceCreditCards[idCreditCard] : 0.0;
  }

  Future insert(simpleRegister) async {
    await simpleRegisterDao.insert(simpleRegister);
  }

  Future updateRegister(simpleRegister) async {
    await simpleRegisterDao.update(simpleRegister);
  }

  int get selectedDateByMill => MonthSalary.getDateByMonthAndYear(date: selectedDate.value);
  int get lastMonthByMill => MonthSalary.getDateByMonthAndYear(date: selectedDate.value, day: DateTime(2021, 2 + 1, 0).day);

  String get getSelectedDateAsYMMM => Jiffy.unix(selectedDate.value).yMMM;

  DateTime get getDateTimeSelected => Jiffy.unix(selectedDate.value).dateTime;

  Future loadSummaryChart() async {
    final firstMonth = Jiffy.unix(selectedDate.value).subtract(months: 3);
    final lastMonth = Jiffy.unix(selectedDate.value).add(months: 3);

    final teste = await simpleRegisterDao.reduceByMonth(firstMonth: firstMonth, lastMonth: lastMonth, selectedDate: selectedDate.value);

    List<dynamic> listExpense = [];
    List<dynamic> listIncome = [];

    teste.entries.forEach((element) {
      if(element.key == Constants.INCOME){
        element.value.entries.forEach((element){
          listIncome.add(element.value);
        });
      }else{
        element.value.entries.forEach((element){
          listExpense.add(element.value);
        });
      }
    });

    dataSummaryChart.value = [listExpense, listIncome];
  }

  CreditCard getCreditCard(id){
    return arrayCreditCards.firstWhere((element) => element.id == id);
  }

  double getPercentCreditCard({required CreditCard creditCard}) {
    final total = (((creditCard.creditLimit) + getCreditCardExpenseById(creditCard.id)) > 0 && creditCard.creditLimit > 0 ?
    ((100 * getCreditCardExpenseById(creditCard.id)) / (creditCard.creditLimit)) / 100 : 1.0);
    return total > 1.0 ? 1.0 : total;
  }

  double get totalBalanceInPercent => ((income.value) + salary.value - expense.value) > 0 ? ((100 * expense.value) / (income.value + salary.value)) / 100 : 1.0;

}