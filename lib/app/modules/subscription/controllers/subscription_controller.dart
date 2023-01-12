import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'subscription_model.dart';

class SubscriptionController extends GetxController {
  //TODO: Implement SubscriptionController

  int count = -1.obs;
  Subscriptions? subscriptions;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getSub();
  }

  Future<void> getSub() async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=f72b54d682c45ebf19fcc0fd54cef39508588d0c'
    };
    isLoading = true.obs;
    var response = await Dio().get(
        'https://manage.partypeople.in/v1/party/subscriptions',
        options: Options(headers: headers));

    debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      subscriptions = Subscriptions.fromJson(response.data);
      isLoading = false.obs;
    } else {
      Get.snackbar("Hy", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
      isLoading = false.obs;
    }
  }
}
