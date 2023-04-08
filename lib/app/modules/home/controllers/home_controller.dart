import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final pageCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    var a = GetStorage().read("token");

    if (a != null) {
      Get.offAllNamed('/dashbord');
    }
  }

  @override
  void onClose() {}

  void increment() {
    if (pageCount < 2) {
      pageCount.value++;
    } else {
      Get.toNamed("/login");
    }
  }

  void decrement() {
    if (pageCount > 0) {
      pageCount.value--;
    }
  }
}
