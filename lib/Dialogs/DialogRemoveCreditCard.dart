import 'package:finance/state/ControllerResumeCreditCard.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogRemoveCreditCard extends StatelessWidget {

  final dialogRemoveCreditCardMessage = 'dialogRemoveCreditCardMessage'.tr;

  final idCreditCard;

  DialogRemoveCreditCard({this.idCreditCard});

  @override
  Widget build(BuildContext context) {

    ControllerResumeCreditCard _controllerResumeCreditCard = Get.find();

    StateSystem _stateSystem = Get.find();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline),
          SizedBox(height: 10,),
          Text(dialogRemoveCreditCardMessage)
        ],
      ),
      actions: [
        TextButton(
          child: Text('cancelButtonFormCreditCard'.tr,),
          onPressed: (){
            Get.back();
          },
        ),
        TextButton(
          child: Text("Ok",),
          onPressed: () async {
            _controllerResumeCreditCard.loadData = true;
            _stateSystem.removeCreditCard(idCreditCard: idCreditCard);
          },
        )
      ],
    );
  }

}