import 'package:finance/state/StateLogin.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogSignOut extends StatelessWidget {

  final IconData icon;

  final String message;

  DialogSignOut({required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {

    StateLogin _stateLogin = Get.find();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(height: 10,),
          Text(message, textAlign: TextAlign.center,)
        ],
      ),
      actions: [
        TextButton(
          child: Text('signOutButtonTryLater'.tr,),
          onPressed: (){
            Get.back();
          },
        ),
        TextButton(
          child: Text("signOutButtonWithoutSaving".tr,),
          onPressed: () async {
            await _stateLogin.signingOutWithoutSaveOnDrive();
          },
        )
      ],
    );
  }

}