import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:finance/state/StateBottomAppBarIndex.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends GetView<StateBottomAppBarIndex> {

  final bottomHome = 'bottomHome'.tr;
  final bottomCheckRegistersMonth= 'bottomCheckRegistersMonth'.tr;
  final bottomSettings = 'bottomSettings'.tr;

  @override
  Widget build(BuildContext context) {

    StateSystem _stateSystem = Get.find();

    return ConvexAppBar(
      backgroundColor: Get.theme.primaryColor,
      style: TabStyle.react,
      items: [
        TabItem(icon: Icons.home, title: bottomHome),
        TabItem(icon: Icons.check_box_outlined, title: bottomCheckRegistersMonth),
        TabItem(icon: Icons.settings, title: bottomSettings),
      ],
      initialActiveIndex: 0,
      onTap: (int i) {
        _stateSystem.getFewSimpleRegister();
        controller.setBottomAppBarIndex(i);
        },
    );
  }
}
