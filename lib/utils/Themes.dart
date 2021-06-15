import 'package:finance/utils/HexColor.dart';
import 'package:finance/utils/StorageUtil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {

  static final light = ThemeData.light().copyWith(
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      primaryTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      accentTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
    primaryColor: HexColor("3A5DF8"),
    accentColor: HexColor("f8f9fa"),
    backgroundColor: Colors.grey[100]
  );

  static final dark = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: GoogleFonts.lato().fontFamily,
    ),
    primaryTextTheme: ThemeData.dark().textTheme.apply(
      fontFamily: GoogleFonts.lato().fontFamily,
    ),
    accentTextTheme: ThemeData.dark().textTheme.apply(
      fontFamily: GoogleFonts.lato().fontFamily,
    ),
  );

}

class ThemeService {
  final _key = 'isDarkMode';

  ThemeMode get theme => isDarkTheme() ? ThemeMode.dark : ThemeMode.light;

  // Dark Mode is true by default
  bool isDarkTheme() => StorageUtil.getBool(_key) ?? true;

  _saveTheme(bool isDarkMode) => StorageUtil.putBool(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(isDarkTheme() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!isDarkTheme());
  }
}