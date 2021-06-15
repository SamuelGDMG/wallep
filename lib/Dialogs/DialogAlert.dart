import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAlert extends StatelessWidget {

  final message;
  final icon;

  DialogAlert({this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(height: 10,),
          Text(message)
        ],
      ),
      actions: [
        TextButton(
          child: Text("Ok",),
          onPressed: (){
            Get.back();
          },
        )
      ],
    );
  }

}