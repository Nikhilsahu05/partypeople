import 'package:get/get.dart';

import '../controllers/individual_otp_controller.dart';

class IndividualOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualOtpController>(
      () => IndividualOtpController(),
    );
  }
}
