import 'package:finance/bindings/home_binding.dart';
import 'package:finance/screens/Home/home.dart';
import 'package:finance/screens/Login/Login.dart';
import 'package:finance/screens/OnBoardingPage/OnBoardingPage.dart';
import 'package:finance/screens/Settings/SettingPage.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => Home(), binding: HomeBinding()),
    GetPage(name: Routes.INTRO, page: () => OnBoardingPage()),
    GetPage(name: Routes.LOGIN, page: () => Login()),
    //GetPage(name: Routes.SETTING, page: () => SettingPage()),
  ];
}