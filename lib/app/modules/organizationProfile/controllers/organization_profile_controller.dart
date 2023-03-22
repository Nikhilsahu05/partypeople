import 'package:get/get.dart';

class OrganizationProfileController extends GetxController {
  //TODO: Implement OrganizationProfileController
  var data = {};
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
