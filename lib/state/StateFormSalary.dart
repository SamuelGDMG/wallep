import 'package:finance/database/MonthSalaryDao.dart';
import 'package:finance/model/MonthSalary.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateFormSalary extends GetxController {

  MonthSalaryDao _monthSalaryDao = MonthSalaryDao();

  var formKey = GlobalKey<FormState>();

  var controllerSalary = TextEditingController().obs;

  Future validate() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      await insertDate();
    }
  }

  Future insertDate() async {
    StateSystem stateSystem = Get.find();

    final replaceMaskSalary = controllerSalary.value.value.text.replaceAll(RegExp('[^0-9]'), "");

    final salaryFormated = replaceMaskSalary != "" ? double.parse(replaceMaskSalary) / 100 : 0.0;

    MonthSalary monthSalary = MonthSalary(salary: salaryFormated)
      ..setDate(stateSystem.selectedDate.value);

    await _monthSalaryDao.insert(monthSalary);

    stateSystem.salary.value = salaryFormated;

    stateSystem.loadInitialData();

    Get.back();
  }

  @override
  void onInit() {
    StateSystem stateSystem = Get.find();

    controllerSalary.value.text = stateSystem.salary.value.toString();

    super.onInit();
  }

}