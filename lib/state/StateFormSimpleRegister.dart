import 'package:finance/database/SimpleRegisterDao.dart';
import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class StateFormSimpleRegister extends GetxController {

  SimpleRegisterDao simpleRegisterDao = SimpleRegisterDao();

  var formKey = GlobalKey<FormState>();

  //Constants.INCOME
  var isIncome = "income".obs;

  var controllerName = TextEditingController().obs;

  var controllerPrice = TextEditingController().obs;

  var controllerQty = TextEditingController().obs;

  var controllerInstallments = TextEditingController().obs;

  void changeBox(val){
    isIncome.update((_) {
      isIncome.value = val;
    });
  }

  Future addRegister() async {

    var uuid = Uuid();

    var date = DateTime.now();

    SimpleRegister simpleRegister = SimpleRegister(
      id: uuid.v4(),
      isIncome: isIncome.value,
      installments: controllerInstallments.value.value.text != "" ? int.parse(controllerInstallments.value.value.text) : 1,
      createdAt: date.millisecondsSinceEpoch,
      lastInstallment: date.millisecondsSinceEpoch,
      idCategory: "default",
      name: controllerName.value.value.text,
      firstInstallment: date.millisecondsSinceEpoch
    );

    final replaceMaskPrice = controllerPrice.value.value.text.replaceAll(RegExp('[^0-9]'), "");

    simpleRegister.price = replaceMaskPrice != "" ? double.parse(replaceMaskPrice) / 100 : 0.0;

    await simpleRegisterDao.insert(simpleRegister);

    StateSystem stateSystem = Get.find();

    await stateSystem.loadInitialData();

    Get.back();
  }

  Future validate() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      await addRegister();
    }
  }

  String get installments => controllerInstallments.value.value.text != '' && double.parse(controllerInstallments.value.value.text) > 0 ? controllerInstallments.value.value.text : '1';

  double get price => HelpFunctions.replaceMaskPrice(controllerPrice.value.value.text) != '' ? HelpFunctions.getPriceWithoutMask(controllerPrice.value.value.text) : 0.0;

  double get total => price / (double.parse(installments) > 0 ? double.parse(installments) : 1);

}