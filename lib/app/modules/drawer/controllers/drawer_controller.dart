import 'package:get/get.dart';

class DrawerController2 extends GetxController {
  //TODO: Implement DrawerController

  final count = 0.obs;
  var name = "";

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    try {
      name = data['full_name'];

      // ignore: empty_catches
    } catch (e) {}
  }

  void increment() => count.value++;
}
