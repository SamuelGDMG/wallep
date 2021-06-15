import 'package:finance/state/StateBottomAppBarIndex.dart';
import 'package:get/get.dart';

/// Current Get version has an issue that disposes the controllers after
/// navigating to previous pages, so setting [permanent] to [true] is a
/// workaround to prevent the application from running into this problem
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StateBottomAppBarIndex>(
      StateBottomAppBarIndex(),
      permanent: true,
    );
  }
}
