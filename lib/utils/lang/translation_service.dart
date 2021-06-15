import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en.dart';
import 'pt.dart';

class LanguageModel {
  LanguageModel(
      this.language,
      this.symbol,
      );

  String language;
  String symbol;
}

class TranslationService extends Translations {
  static final fallbackLocale = Locale('pt', 'US');

  static final List<LanguageModel> languages = [
    LanguageModel("English", "en"),
    LanguageModel("Português", "pt"),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'pt': pt
  };
}
