import 'package:get/get.dart';

import '../controllers/organization_menu_controller.dart';

class OrganizationMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizationMenuController>(
      () => OrganizationMenuController(),
    );
  }
}
