import 'package:finance/state/LanguageState.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LanguageState>(LanguageState());
  }
}