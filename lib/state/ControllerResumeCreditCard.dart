import 'package:finance/database/SimpleRegisterDao.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ControllerResumeCreditCard extends GetxController {

  @override
  void onClose() {
    StateSystem _stateSystem = Get.find();

    _stateSystem.loadInitialData();
    super.onClose();
  }

  var idCreditCard;

  var loadData = false;

  SimpleRegisterDao _simpleRegisterDao = SimpleRegisterDao();
  var arrayRegisters = [].obs;

  ControllerResumeCreditCard({required this.idCreditCard});

  @override
  void onInit() async {

    await loadCreditCardsRegisters();

    //final response = await _simpleRegisterDao.getRegistersById(id: idCreditCard);

    //arrayRegisters.value = response;

    super.onInit();
  }



  Future loadCreditCardsRegisters() async {
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
  }

}
