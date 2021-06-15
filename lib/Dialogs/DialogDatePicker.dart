import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DialogDatePicker extends StatelessWidget {

  final dialogTitle = "Calendar";
  final minDate = DateTime(2019);

  final StateSystem _stateSystem = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(maxHeight: 350),
        child: Container(
          height: 250,
          child: SfDateRangePicker(
              initialSelectedDate: _stateSystem.getDateTimeSelected,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs e){
              _stateSystem.changeSelectedDate(e);
              Get.back();
            },
            minDate: minDate,
            view: DateRangePickerView.year,
            allowViewNavigation: false,
              selectionColor: Get.theme.primaryColor,
              monthCellStyle: DateRangePickerMonthCellStyle(

              ),
              yearCellStyle: DateRangePickerYearCellStyle(
                todayCellDecoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle
                ),
                todayTextStyle: const TextStyle(color: Colors.white),
              )
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel", style: TextStyle(
            color: Get.theme.primaryColor
          ),),
          onPressed: (){
            Get.back();
          },
        )
      ],
    );
  }
}

