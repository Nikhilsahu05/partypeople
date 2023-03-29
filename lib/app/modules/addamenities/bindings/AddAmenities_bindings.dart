// ignore_for_file: file_names

import 'package:get/get.dart';

import '../controllers/addamenitiescontroller.dart';

class AddAmenitiesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAmenitiesController>(
      () => AddAmenitiesController(),
    );
  }
}
