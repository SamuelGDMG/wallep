import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/state/ControllerResumeCreditCard.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceCreditCard extends StatelessWidget {

  final containerWidth = 300.0;

  final borderRadius = 16.0;

  final invoiceCreditCard = "invoiceCreditCardTitle".tr;
  final invoiceCreditBills = "invoiceCreditBills".tr;

  @override
  Widget build(BuildContext context) {

    ControllerResumeCreditCard _controllerResumeCreditCard = Get.find();

    return Material(
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: 6,
        child: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: BoxConstraints(
            maxWidth: containerWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text("$invoiceCreditCard ${HelpFunctions.formatDataWithYear(date: _controllerResumeCreditCard.selectedDate.value, lang: Get.locale!.languageCode)}"))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("- " + HelpFunctions.formatCurrency(value: _controllerResumeCreditCard.total.value, name: "currency".tr), style: TextStyle(
                        color: Constants.COLOR_EXPENSE,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(invoiceCreditBills, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: _controllerResumeCreditCard.arrayRegisters.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (_, index){

                        SimpleRegister simpleRegister = _controllerResumeCreditCard.arrayRegisters[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(simpleRegister.name, style: TextStyle(
                              fontSize: 16
                            ),),
                            //Text("Data: ${HelpFunctions.formatDataWithYear(date: simpleRegister.firstInstallment, lang: Get.locale!.languageCode)}"),
                            Text(HelpFunctions.formatCurrency(value: simpleRegister.installment, name: "currency".tr), style: TextStyle(
                                fontSize: 16,
                              color: Constants.COLOR_EXPENSE
                            )),
                            /*Visibility(child: Text("Parcelas: ${simpleRegister.installments}"), visible: simpleRegister.installments != 1,),
                            Text("Total: " + HelpFunctions.formatCurrency(value: simpleRegister.price, name: "currency".tr)),*/
                            Visibility(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(height: 1, ),
                            ), visible: !(_controllerResumeCreditCard.arrayRegisters.length == index + 1),)
                          ],
                        );
                      })),
                ),
              ],
            ),
          )
        )
    );
  }
}
