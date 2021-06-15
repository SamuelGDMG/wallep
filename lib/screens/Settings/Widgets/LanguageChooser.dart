import 'package:finance/state/LanguageState.dart';
import 'package:finance/utils/lang/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageChooser extends StatelessWidget {
  final String title = 'language'.tr;

  @override
  Widget build(BuildContext context) {

    final LanguageState _languageState = Get.find();

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
              DropdownButton<String>(
                iconSize: MediaQuery.of(context).size.width * 0.045,
                isExpanded: false,
                isDense: false,
                value: _languageState.selectedLanguage.value,
                onChanged: (symbol) {
                  _languageState.changeLanguage = symbol!;
                },
                items: TranslationService.languages.map(
                      (LanguageModel _language) {
                    return DropdownMenuItem<String>(
                      child: new Text(
                        _language.language,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      value: _language.symbol,
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
