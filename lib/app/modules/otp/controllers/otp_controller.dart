import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/src/form_data.dart' as frm;

import '../../../routes/app_pages.dart';

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
    phonAuth();
  }

  @override
  void onReady() {
    super.onReady();
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

  void verifyOtp(String smsCode) {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verfd, smsCode: smsCode);
    auth.signInWithCredential(credential).then((value) async {
      if (value.user != null) {
        try {
          var response = await Dio().post(
              'https://manage.partypeople.in/v1/account/login',
              data: frm.FormData.fromMap({'phone': mob.value}));
          print(response);
          if (response.data['status'] == 1) {
            await GetStorage().write("token", response.data['data']['token']);
            if (response.data['data']['first_time'] == 1) {
              Get.offAllNamed(Routes.CUST_PROFILE,
                  arguments: response.data['data']);
            } else {
              Get.offAllNamed(Routes.DASHBORD,
                  arguments: response.data['data']);
            }
          } else {
            Get.snackbar("Error", "Invalid OTP");
          }
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar("Error", "Invalid OTP");
      }
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
