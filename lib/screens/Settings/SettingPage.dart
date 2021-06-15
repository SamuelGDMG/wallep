import 'package:finance/screens/Settings/Widgets/AboutButton.dart';
import 'package:finance/screens/Settings/Widgets/Contact.dart';
import 'package:finance/screens/Settings/Widgets/LanguageChooser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Widgets/BackupTutorial.dart';
import 'Widgets/SignOutComponent.dart';
import 'Widgets/SwitchThemeComponent.dart';

class SettingPage extends StatelessWidget {

  final title = 'titlePageSettings'.tr;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchThemeComponent(),
          LanguageChooser(),
          BackupTutorial(),
          AboutButton(),
          Contact(),
          SignOutComponent()
        ],
      ),
    );
  }
}