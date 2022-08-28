import 'package:get/get.dart';

import '../controllers/splashscreen_three_controller.dart';

class SplashscreenThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashscreenThreeController>(
      () => SplashscreenThreeController(),
    );
  }
}
