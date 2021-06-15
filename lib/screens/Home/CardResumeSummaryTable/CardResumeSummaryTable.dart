import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:finance/utils/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardResumeSummaryTable extends StatelessWidget {

  final isIncome;

  final textSummaryIncome = 'textSummaryIncome'.tr;
  final textSummaryExpense = 'textSummaryExpense'.tr;

  final StateSystem _stateSystem = Get.find();

  CardResumeSummaryTable({this.isIncome = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isIncome ? textSummaryIncome : textSummaryExpense, style: TextStyle(color: isIncome ? HexColor('3DDC97') : HexColor('E94957')),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("currency".tr, style: TextStyle(
                      fontSize: 16
                  ),),
                  Flexible(
                    child: Obx(() => _stateSystem.showMoney.value ? Text(HelpFunctions.formatCurrency(value: isIncome ? _stateSystem.income.value : _stateSystem.expense.value),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ) : Text('---')),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
