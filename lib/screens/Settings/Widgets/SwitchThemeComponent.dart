import 'package:finance/utils/Themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchThemeComponent extends StatelessWidget {
  final String title = 'darkMode'.tr;
  @override
  Widget build(BuildContext context) {

    var themeService = ThemeService();

    return Column(
      children: [
        Container(
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
              Switch(
                value: themeService.isDarkTheme(),
                onChanged: (value) {
                  themeService.switchTheme();
                },
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
