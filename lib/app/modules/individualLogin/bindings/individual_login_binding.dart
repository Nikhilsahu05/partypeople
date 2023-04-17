import 'package:get/get.dart';

import '../controllers/individual_login_controller.dart';

class IndividualLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualLoginController>(
      () => IndividualLoginController(),
    );
  }
}
