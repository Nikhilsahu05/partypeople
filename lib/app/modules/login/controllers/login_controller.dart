import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pertypeople/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  static var token = "";
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void logInWithGoogle() {
    _handleSignIn();
  }

  void _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      var a = await _googleSignIn.isSignedIn();
      print(a);
      print(_googleSignIn.currentUser);
      if (a == true) {
        var url =
            Uri.parse('https://manage.partypeople.in/v1/account/social_signup');
        var responce = await http.post(url, body: {
          'social_id': _googleSignIn.currentUser?.id.toString(),
          'type': 'google',
          'profile_picture': _googleSignIn.currentUser?.photoUrl.toString(),
          'email': _googleSignIn.currentUser?.email,
          'full_name': _googleSignIn.currentUser?.displayName,
        });
        var json = jsonDecode(responce.body);
        print(json);
        //token = json['token'];
        await GetStorage().write("token", json['data']['token']);
        if (json['data']['first_time'] == '1') {
          Get.offAllNamed(Routes.ADD_PROFILE, arguments: json['data']);
        } else {
          Get.offAllNamed('/dashbord');
        }
      }
    } catch (error) {
      print(error);
    }
  }

  signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    print(loginResult.message);
    // Create a credential from the access token
  }
}
