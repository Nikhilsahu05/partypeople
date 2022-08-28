import 'package:get/get.dart';

import '../controllers/splashscreen_two_controller.dart';

class SplashscreenTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenTwoController>(
      () => SplashscreenTwoController(),
    );
  }
}
