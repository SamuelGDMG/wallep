import '../../../Dialogs/DialogDatePicker.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateSelected extends StatelessWidget {

  final borderRadius = 8.0;

  final StateSystem _stateSystem = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: (){
            Get.dialog(DialogDatePicker(dateTimeSelected: _stateSystem.getDateTimeSelected, selectDate:(e) => _stateSystem.changeSelectedDate(e),));
          },
          child: Obx((){

            String dateTime = HelpFunctions.formatDataWithYear(date: _stateSystem.selectedDate.value, lang: Get.locale!.languageCode);

            return Text(dateTime, style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
            );
          },
          ),
        )
      ],
    );
  }
}
