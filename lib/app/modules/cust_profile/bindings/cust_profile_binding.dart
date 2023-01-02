import 'package:get/get.dart';

import '../controllers/cust_profile_controller.dart';

class CustProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustProfileController>(
      () => CustProfileController(),
    );
  }
}
