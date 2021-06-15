import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HelpFunctions.dart';
import '../../../Dialogs/DialogSalary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Salary extends StatelessWidget {

  final StateSystem _stateSystem = Get.find();

  final borderRadius = 8.0;

  final textSalary = 'textSummarySalary'.tr;

  final currency = 'currency'.tr;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: (){
            Get.dialog(DialogSalary());
          },
          child: Obx(() => _stateSystem.showMoney.value == true ? Text("$textSalary: $currency ${HelpFunctions.formatCurrency(value: _stateSystem.salary.value)}", style: TextStyle(
            color: Colors.white
          ),) : Text("$textSalary: $currency ---", style: TextStyle(
              color: Colors.white
          ),)),
        )
      ],
    );
  }
}
