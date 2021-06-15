import '../CardResumeSummaryTable/CardResumeSummaryTable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumeSummaryTable extends StatelessWidget {

  final borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Material(
        elevation: 2,
        color: Get.theme.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: 75,
          child: Row(
            children: [
              CardResumeSummaryTable(isIncome: true,),
              CardResumeSummaryTable(isIncome: false,)
            ],
          ),
        ),
      ),
    );
  }
}
