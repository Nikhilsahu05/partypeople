import 'package:get/get.dart';

import '../controllers/add_organizations_event2_controller.dart';

class AddOrganizationsEvent2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrganizationsEvent2Controller>(
      () => AddOrganizationsEvent2Controller(),
    );
  }
}
