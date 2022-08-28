import 'package:get/get.dart';

import '../controllers/add_individual_event_controller.dart';

class AddIndividualEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddIndividualEventController>(
      () => AddIndividualEventController(),
    );
  }
}
