import 'package:finance/screens/Home/DateAndEye/DateAndEye.dart';
import 'package:finance/screens/Home/Salary/Salary.dart';
import 'package:finance/screens/Home/TotalBalance/TotalBalance.dart';
import '../ResumeSummaryTable/ResumeSummaryTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSummary extends StatelessWidget {

  final borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.primaryColor,
      elevation: 4,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateAndEye(),
            Salary(),
            TotalBalance(),
            ResumeSummaryTable()
          ],
        ),
      ),
    );
  }

}
