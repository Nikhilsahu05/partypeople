import 'package:get/get.dart';

import '../controllers/add_organizations_event_controller.dart';

class AddOrganizationsEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrganizationsEventController>(
      () => AddOrganizationsEventController(),
    );
  }
}
