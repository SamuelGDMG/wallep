import 'package:finance/screens/CheckSimpleRegister/CheckSimpleRegister.dart';
import 'package:finance/screens/Home/BottomBar/BottomBar.dart';
import 'package:finance/screens/Home/Main/Main.dart';
import 'package:finance/screens/Settings/SettingPage.dart';
import 'package:finance/state/StateBottomAppBarIndex.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<StateBottomAppBarIndex> {

  final appName = Constants.APP_NAME;

  final StateSystem _stateSystem = Get.put(StateSystem());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appName, style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Obx(() => _getSelectedPage(controller.activeIndex.value)),
      backgroundColor: Get.theme.backgroundColor,
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return Main();
      case 1:
        return CheckSimpleRegister();
      case 2:
        return SettingPage();
      default:
        return Main();
    }
  }

}
