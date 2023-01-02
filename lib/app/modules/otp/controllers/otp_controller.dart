import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController

  final count = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var mob = "".obs;
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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
