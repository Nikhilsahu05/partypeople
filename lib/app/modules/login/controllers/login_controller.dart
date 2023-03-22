import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pertypeople/app/modules/global_header_id_controller.dart';
import 'package:pertypeople/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  static var token = "";
  final count = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController mobileNumber = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  RxBool googleLogin = false.obs;

  @override
  void onClose() {}

  void increment() => count.value++;

  void logInWithGoogle() {
    _handleSignIn();
  }

  GlobalHeaderIDController globalHeaderIDController =
      Get.put(GlobalHeaderIDController());

  void _handleSignIn() async {
    try {
      GoogleSignInAccount? data = await _googleSignIn.signIn();

      print('Printing google login data :: ${data?.displayName}');

      if (data?.displayName != null) {
        var url =
            Uri.parse('https://manage.partypeople.in/v1/account/social_signup');
        // print(_googleSignIn.currentUser?.photoUrl.toString());
        var responce = await http.post(url, body: {
          'social_id': _googleSignIn.currentUser?.id.toString(),
          'type': 'google',
          'profile_picture': _googleSignIn.currentUser?.photoUrl.toString(),
          'email': _googleSignIn.currentUser?.email,
          'full_name': _googleSignIn.currentUser?.displayName,
          'latitude': '',
          'longitude': '',
        });

        print(responce.body);
        var json = jsonDecode(responce.body);
        print(json);
        globalHeaderIDController.token.value = json['data']['token'];
        //token = json['token'];
        await GetStorage().write("token", json['data']['token']);
        if (json['data']['first_time'] == '1') {
          Get.offAllNamed(Routes.ADD_ORGANIZATIONS_EVENT,
              arguments: json['data']);
        } else {
          Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
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

  verifyOTP(String otpValue, BuildContext context) async {
    http.Response response = await http.post(
        Uri.parse(
          'https://manage.partypeople.in/v1/account/otp_verify',
        ),
        body: {
          'otp': otpValue,
        },
        headers: {
          'x-access-token': globalHeaderIDController.token.value
        });
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.snackbar('OTP', '${json['message']}', backgroundColor: Colors.white);
      if (json['message'].contains('successfully'.toUpperCase()) ||
          json['message'].contains('successfully'.toLowerCase())) {
        getAPIOverview(context);

        print("Can proceed to new screen");
      }
    } else {
      Get.snackbar('OTP', '${json['message']}');
    }
  }

  getAPIOverview(BuildContext context) async {
    isLoading.value = true;
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/organization_details'),
        headers: {
          'x-access-token': '${GetStorage().read("token")}',
        });
    print("response of Organization ${response.body}");

    if (jsonDecode(response.body)['message'] == 'Organization Data Found.') {
      isLoading.value = false;

      Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
    } else {
      isLoading.value = false;
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.ADD_ORGANIZATIONS_EVENT, (Route<dynamic> route) => false);
    }
  }

  verifyPhone() async {
    Get.snackbar('OTP', 'OTP Sent Successfully', backgroundColor: Colors.white);

    if (mobileNumber.text.isPhoneNumber) {
      var url = Uri.parse('https://manage.partypeople.in/v1/account/login');
      var response = await http.post(url, body: {
        'phone': mobileNumber.text,
      });
      var json = jsonDecode(response.body);
      globalHeaderIDController.token.value = json['data']['token'];
      globalHeaderIDController.uniqueID.value = json['data']['unique_id'];
      globalHeaderIDController.userId.value =
          json['data']['user_id'].toString();
      globalHeaderIDController.phone.value = json['data']['phone'];
      print(json['data']['token']);
      await GetStorage().write("token", json['data']['token']);

      globalHeaderIDController.token.value = json['data']['token'];

      Get.toNamed(Routes.OTP, arguments: mobileNumber.text);
    }
  }
}
