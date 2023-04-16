// ignore_for_file: implementation_imports

import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart' as frm;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../profile_type.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController

  final count = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var mob = "".obs;
  var verfd = "";

  @override
  Future<void> onInit() async {
    super.onInit();

    mob.value = Get.arguments;
    //phonAuth();
  }

  Future<void> phonAuth() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${mob.value}',
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        print(verificationId);
        verfd = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  Future<void> verfyOtp(String smsCode) async {
    try {
      var response = await Dio().post(
          options:
              Options(headers: {"x-access-token": GetStorage().read("token")}),
          'http://app.partypeople.in/v1/account/otp_verify',
          data: frm.FormData.fromMap({'otp': smsCode}));
      print(response);
      Get.snackbar(
        "${response.data['message']}",
        '',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      if (response.data['status'] == 1) {
        Get.offAll(ProfileType());
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendOtp(String phonNum) async {
    try {
      var response = await Dio().post(
          options:
              Options(headers: {"x-access-token": GetStorage().read("token")}),
          'http://app.partypeople.in/v1/account/send_otp',
          data: frm.FormData.fromMap({'phone': phonNum}));
      print(response);

      if (response.data['status'] == 1) {
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
