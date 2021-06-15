import 'package:finance/screens/Home/ResumeSummaryTable/ResumeSummaryTable.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumeCheckExpense extends StatelessWidget {

  final borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {

    StateSystem _stateSystem = Get.find();
    
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Get.theme.primaryColor,
            elevation: 4,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(HelpFunctions.formatDataWithYear(date: _stateSystem.selectedDate.value, lang: Get.locale!.languageCode), style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),),
                  ResumeSummaryTable()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}
