import 'package:finance/routes/app_pages.dart';
import 'package:finance/state/StateLogin.dart';
import 'package:finance/utils/Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'utils/StorageUtil.dart';
import 'utils/lang/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final StateLogin _stateLogin = Get.put(StateLogin());

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeService().theme,
      theme: Themes.light,
      darkTheme: Themes.dark,
      initialBinding: InitialBinding(),
      getPages: AppPages.pages,
      initialRoute: StorageUtil.getBool('showIntro') == false
          ? _stateLogin.isUserAuth() ? Routes.HOME : Routes.LOGIN
          : Routes.INTRO,
    );
  }


}
