import 'package:finance/database/SimpleRegisterDao.dart';
import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:get/get.dart';

class StateCheckListSimpleRegister extends GetxController {

  SimpleRegisterDao simpleRegisterDao = SimpleRegisterDao();

  var arraySimpleRegister = [].obs;

  Future loadingData() async {
    StateSystem stateSystem = Get.find();

    final response = await simpleRegisterDao.getAllSimpleRegisterByMonth(selectedDate: stateSystem.selectedDate.value);
    arraySimpleRegister.value = response;
  }

  Future checkRegister({required SimpleRegister simpleRegister, value}) async {
    StateSystem _stateSystem = Get.find();
    Map<String, dynamic> data = {...simpleRegister.check};
    data[_stateSystem.getSelectedDateAsYMMM] = value;
    simpleRegister.check = data;
    await simpleRegisterDao.update(simpleRegister);

    int index = arraySimpleRegister.indexWhere((element) => element.id == simpleRegister.id);

    arraySimpleRegister[index].check = data;
    arraySimpleRegister.refresh();
  }

}