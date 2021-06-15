import 'package:finance/screens/FormCreditCard/FormCreditCard.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreditCard extends StatelessWidget {

  final borderRadius = 16.0;

  final creditCard;

  final containerHeight = 150.0;

  final containerWidth = 300.0;

  CreditCard({this.creditCard});

  @override
  Widget build(BuildContext context) {

    StateSystem stateSystem = Get.find();

    return Padding(
        padding: const EdgeInsets.only(bottom: 14, top: 12, left: 6, right: 6),
        child: Material(
            borderRadius: BorderRadius.circular(borderRadius),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: containerHeight,
                  maxWidth: containerWidth
                ),
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
                                          Expanded(child: Text(creditCard.description,)),
                                          Expanded(child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                                            Get.to(() => FormCreditCard(creditCard: creditCard,));
                                          },), flex: 0,)
                                        ],
                                      )
                                  ),
                                  Expanded(
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("currency".tr, style: TextStyle(
                                                  color: Constants.COLOR_INCOME,
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
                                                Text("- ${'currency'.tr}", style: TextStyle(
                                                    color: Constants.COLOR_EXPENSE,
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
        )
    );
  }

  Widget Limit(value){
    return Text(value, style: TextStyle(
        color: Constants.COLOR_INCOME,
        fontWeight: FontWeight.bold,
        fontSize: 20
    )
    );
  }

  Widget Expense(value){
    return Flexible(
      child: Text(value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
          color: Constants.COLOR_EXPENSE,
          fontWeight: FontWeight.bold,
          fontSize: 20
      )
      ),
    );
  }

}
