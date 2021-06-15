import 'package:finance/state/StateLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackupTutorial extends StatelessWidget {
  final title = 'backup'.tr;

  @override
  Widget build(BuildContext context) {

    StateLogin _stateLogin = Get.find();

    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
                IconButton(

                  icon: Icon(Icons.backup),
                  onPressed: () async {
                    await _stateLogin.uploadFile();
                  },
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
