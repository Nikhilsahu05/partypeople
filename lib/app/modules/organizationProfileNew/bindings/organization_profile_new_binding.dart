import 'package:get/get.dart';

import '../controllers/organization_profile_new_controller.dart';

class OrganizationProfileNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizationProfileNewController>(
      () => OrganizationProfileNewController(),
    );
  }
}
