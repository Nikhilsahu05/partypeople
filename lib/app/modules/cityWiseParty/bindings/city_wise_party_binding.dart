import 'package:get/get.dart';

import '../controllers/city_wise_party_controller.dart';

class CityWisePartyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CityWisePartyController>(
      () => CityWisePartyController(),
    );
  }
}
