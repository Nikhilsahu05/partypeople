import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
    auth.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        Get.offAllNamed(Routes.ADD_PROFILE);
      }
      else{
        Get.snackbar("Error", "Invalid OTP");
      }
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
