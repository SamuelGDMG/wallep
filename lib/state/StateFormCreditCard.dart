import 'package:finance/database/CreditCardDao.dart';
import 'package:finance/model/CreditCard.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class StateFormCreditCard extends GetxController {

  CreditCardDao _creditCardDao = CreditCardDao();
  var creditCard;

  StateFormCreditCard({this.creditCard}){
    if(creditCard != null){
      CreditCard _creditCard = creditCard;

      controllerName.value.text = _creditCard.description;
      controllerCreditLimit.value.text = HelpFunctions.formatCurrency(name: 'currency'.tr, value: _creditCard.creditLimit);
    }
  }

  var formKey = GlobalKey<FormState>();

  var controllerName = TextEditingController().obs;

  var controllerCreditLimit = TextEditingController().obs;

  Future validate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if(creditCard != null){
        await updateCreditCard();
      }else{
        await addRegister();
      }
    }
  }

  Future updateCreditCard() async {

    CreditCard credit = creditCard;

    final replaceMaskPrice = controllerCreditLimit.value.value.text.replaceAll(RegExp('[^0-9]'), "");

    final limit = replaceMaskPrice != "" ? double.parse(replaceMaskPrice) / 100 : 0.0;

    CreditCard _creditCard = CreditCard(id: credit.id, creditLimit: limit, description: controllerName.value.value.text, key: credit.key);

    await _creditCardDao.update(_creditCard);

    StateSystem stateSystem = Get.find();

    await stateSystem.loadCreditCards();

    Get.back();

  }

  Future addRegister() async {

    var uuid = Uuid();

    final replaceMaskPrice = controllerCreditLimit.value.value.text.replaceAll(RegExp('[^0-9]'), "");

    final limit = replaceMaskPrice != "" ? double.parse(replaceMaskPrice) / 100 : 0.0;

    CreditCard creditCard = CreditCard(id: uuid.v4(), creditLimit: limit, description: controllerName.value.value.text);

    await _creditCardDao.insert(creditCard);

    StateSystem stateSystem = Get.find();

    await stateSystem.loadCreditCards();

    Get.back();

  }
}