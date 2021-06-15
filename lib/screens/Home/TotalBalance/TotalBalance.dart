import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:finance/utils/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';

class TotalBalance extends StatelessWidget {

  final StateSystem _stateSystem = Get.find();

  final textSummaryAccountBalance = 'textSummaryAccountBalance'.tr;

  final currency = 'currency'.tr;

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 13.0,
          animation: true,
          percent: _stateSystem.totalBalanceInPercent,
          center: FittedBox(
            fit: BoxFit.fitWidth,
            child: Obx(
                    () => _stateSystem.showMoney.value == true ?
                    getWidgetTotal(HelpFunctions.formatCurrency(value: _stateSystem.income.value - _stateSystem.expense.value, name: currency)) :
                    getWidgetTotal('$currency ---')
            ),
          ),
          footer: new Text(
            textSummaryAccountBalance,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: Colors.white),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Constants.COLOR_EXPENSE,
          backgroundColor: Constants.COLOR_INCOME,
        ),
        )
      ],
    );
  }

  Widget getWidgetTotal(text) {
    return Text(text,
      style:
      new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

}
