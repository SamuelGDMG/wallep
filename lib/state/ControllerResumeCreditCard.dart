import 'package:finance/database/SimpleRegisterDao.dart';
import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ControllerResumeCreditCard extends GetxController {

  @override
  void onClose() {
    StateSystem _stateSystem = Get.find();

    _stateSystem.loadInitialData();
    super.onClose();
  }

  var selectedDate = DateTime.now().millisecondsSinceEpoch.obs;

  var idCreditCard;

  var loadData = false;

  var total = 0.0.obs;

  SimpleRegisterDao _simpleRegisterDao = SimpleRegisterDao();
  var arrayRegisters = [].obs;

  ControllerResumeCreditCard({required this.idCreditCard});

  @override
  void onInit() async {

    StateSystem _stateSystem = Get.find();

    selectedDate.value = _stateSystem.selectedDate.value;

    await loadCreditCardsRegisters();

    super.onInit();
  }

  Future loadCreditCardsRegisters() async {

    List<SimpleRegister> response = await _simpleRegisterDao.getSimpleRegisterByIdAndDate(selectedDateByMill: selectedDate.value, idCreditCard: idCreditCard);

    double auxTotal = 0;

    response.forEach((element) {
      auxTotal += element.installment;
    });

    total.value = auxTotal;

    arrayRegisters.value = response;
  }

  Future changeSelectedDate(DateRangePickerSelectionChangedArgs e) async {
    selectedDate.value = e.value.millisecondsSinceEpoch;

    await loadCreditCardsRegisters();
  }

  DateTime get getDateTimeSelected => Jiffy.unix(selectedDate.value).dateTime;

  /*Future loadCreditCardsRegisters() async {
    final response = await _simpleRegisterDao.getRegistersById(id: idCreditCard);

    var auxRegisters = [];

    response.forEach((element) {

      Jiffy jiffy = Jiffy.unix(element.createdAt);

      final findMonth = auxRegisters.indexWhere((e) => e['key'] == jiffy.yMMM);

      if(findMonth == -1){
        Map<String, dynamic> data = {'key': jiffy.yMMM, 'registers': [element]};

        auxRegisters.add(data);
      }else{
        auxRegisters[findMonth]["registers"].add(element);
      }

    });

    arrayRegisters.value = auxRegisters;
  }*/

}
