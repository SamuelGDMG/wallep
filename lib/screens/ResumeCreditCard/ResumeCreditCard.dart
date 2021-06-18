import 'package:finance/Dialogs/DialogDatePicker.dart';
import 'package:finance/Dialogs/DialogRemoveCreditCard.dart';
import 'package:finance/screens/ResumeCreditCard/CardResumeMonth/CardResumeMonth.dart';
import 'package:finance/screens/ResumeCreditCard/invoice_credit_card/invoice_credit_card.dart';
import 'package:finance/state/ControllerResumeCreditCard.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CreditCard/CreditCard.dart';

class ResumeCreditCard extends StatelessWidget {

  final resumeCreditCardTitle = 'resumeCreditCardTitle'.tr;

  final resumeCreditCardNoRegisters = 'resumeCreditCardNoRegisters'.tr;

  final idCreditCard;

  ResumeCreditCard({this.idCreditCard});

  @override
  Widget build(BuildContext context) {
    
    StateSystem _stateSystem = Get.find();
    ControllerResumeCreditCard _controllerResumeCreditCard = Get.put(ControllerResumeCreditCard(idCreditCard: idCreditCard));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(DialogDatePicker(dateTimeSelected: _controllerResumeCreditCard.getDateTimeSelected, selectDate:(e) => _controllerResumeCreditCard.changeSelectedDate(e),));
        },
        child: const Icon(Icons.calendar_today_rounded, color: Colors.white,),
        backgroundColor: Get.theme.primaryColor,
      ),
      appBar: AppBar(
        title: Text(resumeCreditCardTitle.tr, style: TextStyle(
          color: Colors.white
        ),),
        actions: [
            IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              Get.dialog(
                DialogRemoveCreditCard(idCreditCard: idCreditCard),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Obx(() => CreditCard(creditCard: _stateSystem.getCreditCard(idCreditCard),)),
            ),
            Obx(() => _controllerResumeCreditCard.arrayRegisters.length > 0 ? InvoiceCreditCard() : Center(
              child: Text(resumeCreditCardNoRegisters),
            ))
          ],
        ),
      ),
    );
  }

}