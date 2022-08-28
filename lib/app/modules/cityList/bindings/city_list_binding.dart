import 'package:get/get.dart';

import '../controllers/city_list_controller.dart';

class CityListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CityListController>(
      () => CityListController(),
    );
  }
}
