import 'package:about/about.dart';
import 'package:finance/state/LanguageState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutButton extends StatelessWidget {

  void showAbout(BuildContext context) {
    showAboutPage(
      title: Text('about'.tr, style: TextStyle(
        color: Colors.white
      ),),
      context: context,
      applicationVersion: 'appVersion'.tr,
      applicationLegalese: 'Copyright © Samuel Santos, 2021',
      children: <Widget>[
        MarkdownPageListTile(
          icon: Icon(Icons.favorite),
          title: Text('thanksTo'.tr),
          filename: 'CONTRIBUTORS.md',
        ),
        LicensesPageListTile(title: Text('licenses'.tr)),
      ],
      applicationIcon: const SizedBox(
        width: 100,
        height: 100,
        child: Image(
          image: AssetImage('assets/images/logo_transparent.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'about'.tr,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () => showAbout(context),
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
