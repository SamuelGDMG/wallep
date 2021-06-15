import 'package:finance/service/user/user_firebase.dart';
import 'package:finance/state/StateLogin.dart';
import 'package:finance/widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    StateLogin _stateLogin = Get.find();

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Image.asset('assets/images/logo_transparent.png', width: 300, height: 300,),
                    alignment: Alignment.center,
                  )
                ],
              )
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      buttonColor: Colors.white,
                      buttonTitle: "loginButton".tr,
                      onTap: () async {
                        _stateLogin.loginWithGoogle();
                      },
                      textColor: Colors.red,
                    )
                  ],
                ),
              )
          ),
        ],
      ),
      backgroundColor: Get.theme.primaryColor,
    );
  }
}
