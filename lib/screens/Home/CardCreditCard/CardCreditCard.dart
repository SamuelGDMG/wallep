import 'package:finance/model/CreditCard.dart';
import 'package:finance/screens/FormCreditCardSimpleRegister/FormCreditCardSimpleRegister.dart';
import 'package:finance/screens/ResumeCreditCard/ResumeCreditCard.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:finance/utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CardCreditCard extends StatelessWidget {

  final borderRadius = 16.0;

  final containerHeight = 150.0;

  final containerWidth = 300.0;

  final CreditCard creditCard;

  final currency = 'currency'.tr;

  final cardColor = "3A5DF8";

  CardCreditCard({required this.creditCard});

  @override
  Widget build(BuildContext context) {

    StateSystem stateSystem = Get.find();

    return Padding(
        padding: const EdgeInsets.only(bottom: 14, top: 12, left: 6, right: 6),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: (){
            Get.to(() => ResumeCreditCard(idCreditCard: creditCard.id,));
          },
          child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          elevation: 6,
            child: Padding(
            padding: const EdgeInsets.all(8.0),
              child: Container(
              height: containerHeight,
              width: containerWidth,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(creditCard.description,)
                                ],
                                )
                              ),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(currency, style: TextStyle(
                                              color: HexColor('3DDC97'),
                                              fontWeight: FontWeight.bold,
                                            fontSize: 8
                                           )
                                          )
                                        ],
                                      ),
                                      Obx(() => Row(
                                        children: [
                                          stateSystem.showMoney.value ? Limit("${HelpFunctions.formatCurrency(value: creditCard.creditLimit, name: '')}") :
                                          Limit('---')
                                        ],
                                      ))
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 0,
                                        child: Row(
                                          children: [
                                            Text("- $currency", style: TextStyle(
                                                color: HexColor('E94957'),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Obx(() => Row(
                                            children: [
                                              stateSystem.showMoney.value ? Expense("${HelpFunctions.formatCurrency(value: stateSystem.getCreditCardExpenseById(creditCard.id))}") :
                                              Expense('---')
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          )
                      ),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Button(creditCard.id),
                          )
                      )
                    ],
                  ),),
                  Expanded(
                      flex: 1,
                      child: Obx(
                          () => LinearPercentIndicator(
                            animation: true,
                            lineHeight: 8.0,
                            animationDuration: 2000,
                            percent: stateSystem.getPercentCreditCard(creditCard: creditCard),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Constants.COLOR_EXPENSE,
                            backgroundColor: Constants.COLOR_INCOME,
                          )
                      )
                  )
                ],
              ),
            ),
          )
          ),
        )
    );
  }

  Widget Button(idCreditCard){
    return Container(
      width: 55,
      height: 55,
      child: Material(
        color: HexColor('F7F0F0'),
        elevation: 1,
        borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: (){
              Get.to(FormCreditCardSimpleRegister(idCreditCard: idCreditCard,));
            },
            child: Icon(Icons.add),
          ),
      ),
    );
  }

  Widget Limit(value){
    return Text(value, style: TextStyle(
        color: HexColor('3DDC97'),
        fontWeight: FontWeight.bold,
        fontSize: 20
      )
    );
  }

  Widget Expense(value){
    return Flexible(
      child: Text(value, style: TextStyle(

          color: HexColor('E94957'),
          fontWeight: FontWeight.bold,
          fontSize: 20
      ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

}
