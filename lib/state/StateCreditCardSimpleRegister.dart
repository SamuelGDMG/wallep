import 'package:finance/model/MonthSalary.dart';
import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

class StateCreditCardSimpleRegister extends GetxController {

  String idCreditCard;

  var isEdit = false;

  bool isCredit;

  var simpleRegisterInitialData;

  var formKey = GlobalKey<FormState>();

  var controllerName = TextEditingController().obs;

  var controllerPrice = TextEditingController().obs;

  var controllerInstallments = TextEditingController().obs;

  var selectedDate = DateTime.now().millisecondsSinceEpoch.obs;

  var isIncome = "income".obs;

  StateCreditCardSimpleRegister({required this.idCreditCard, required this.isCredit, required this.simpleRegisterInitialData}){

    if(simpleRegisterInitialData != null){
      isEdit = true;
      SimpleRegister _simpleRegister = simpleRegisterInitialData;

      controllerName.value.text = _simpleRegister.name;
      controllerPrice.value.text = HelpFunctions.formatCurrency(name: 'currency'.tr, value: _simpleRegister.installment);
      controllerInstallments.value.text = _simpleRegister.installments.toString();
      isIncome.value = _simpleRegister.isIncome;

      selectedDate.value = _simpleRegister.firstInstallment;

      controllerPrice.refresh();
    }
  }

  Future addRegister() async {

    var uuid = Uuid();

    var date = DateTime.now();

    SimpleRegister simpleRegister = SimpleRegister(
        id: uuid.v4(),
        isIncome: isCredit ? Constants.EXPENSE : isIncome.value,
        installments: int.parse(installments),
        createdAt: date.millisecondsSinceEpoch,
        lastInstallment: lastInstallment(),
        idCategory: idCreditCard,
        name: controllerName.value.value.text,
        firstInstallment: MonthSalary.getDateByMonthAndYear(date: dateTime.millisecondsSinceEpoch)
    );

    simpleRegister.price = total;

    StateSystem stateSystem = Get.find();

    await stateSystem.insert(simpleRegister);

    await stateSystem.loadInitialData();
    Get.back();
  }

  Future updateRegister() async {
    SimpleRegister simpleRegister = SimpleRegister(
      key: simpleRegisterInitialData.key,
        id: simpleRegisterInitialData.id,
        isIncome: isCredit ? Constants.EXPENSE : isIncome.value,
        installments: int.parse(installments),
        createdAt: simpleRegisterInitialData.createdAt,
        lastInstallment: lastInstallment(),
        idCategory: idCreditCard,
        name: controllerName.value.value.text,
        firstInstallment: MonthSalary.getDateByMonthAndYear(date: dateTime.millisecondsSinceEpoch),
      check: simpleRegisterInitialData.check
    );

    simpleRegister.price = total;

    print(simpleRegister.toMap());

    StateSystem stateSystem = Get.find();

    await stateSystem.updateRegister(simpleRegister);

    await stateSystem.loadInitialData();
    Get.back();
  }

  Future validate() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();

      if(isEdit){
        await updateRegister();
      }else{
        await addRegister();
      }

    }
  }

  String get installments => controllerInstallments.value.value.text != '' && double.parse(controllerInstallments.value.value.text) > 0 ? controllerInstallments.value.value.text : '1';

  double get price => HelpFunctions.replaceMaskPrice(controllerPrice.value.value.text) != '' ? HelpFunctions.getPriceWithoutMask(controllerPrice.value.value.text) : 0.0;

  double get total => price * (double.parse(installments) > 0 ? double.parse(installments) : 1);

  void changeSelectedDate(DateRangePickerSelectionChangedArgs e) async {
    selectedDate.value = e.value.millisecondsSinceEpoch;
  }

  DateTime get dateTime => Jiffy.unix(selectedDate.value).dateTime;

  int lastInstallment(){
    final installmentsToNumber = int.parse(installments);

    var jiffyMonths = Jiffy.unix(dateTime.millisecondsSinceEpoch).add(months: installmentsToNumber - 1);

    return MonthSalary.getDateByMonthAndYear(date: jiffyMonths.dateTime.millisecondsSinceEpoch, day: jiffyMonths.daysInMonth);
  }

  void changeBox(val){
    isIncome.update((_) {
      isIncome.value = val;
    });
  }

}