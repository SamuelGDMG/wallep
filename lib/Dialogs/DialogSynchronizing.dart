import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogSynchronizing extends StatelessWidget {

  final messageIndicator = 'messageIndicator'.tr;
  final messageUploadFile = 'messageUploadFile'.tr;


  final upload;

  DialogSynchronizing({this.upload = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          Text(upload ? messageUploadFile : messageIndicator)
        ],
      ),
    );
  }

}
