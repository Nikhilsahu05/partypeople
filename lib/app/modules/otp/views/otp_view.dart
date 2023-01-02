import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  @override
  Widget build(BuildContext context) {
    // var phoneNumber = Get.arguments;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, 0.0),
          radius: 0.424,
          colors: [const Color(0xffb11212), const Color(0xff2e0303)],
          stops: [0.0, 1.0],
          transform: GradientXDTransform(
              0.0, -1.0, 1.23, 0.0, -0.115, 1.0, Alignment(0.0, 0.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Phone Verification',
                    style: TextStyle(
                      fontFamily: 'Malgun Gothic',
                      fontSize: 21,
                      color: const Color(0xffFFA914),
                      letterSpacing: -0.42,
                      fontWeight: FontWeight.w700,
                      height: 0.8095238095238095,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'OTP code',
                    style: TextStyle(
                      fontFamily: 'Malgun Gothic',
                      fontSize: 43,
                      color: Color.fromARGB(255, 248, 248, 248),
                      letterSpacing: -0.86,
                      fontWeight: FontWeight.w700,
                      height: 0.8372093023255814,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Malgun Gothic',
                          fontSize: 14,
                          color: const Color(0xffB8A9A9),
                          letterSpacing: -0.28,
                          height: 1.2142857142857142,
                        ),
                        children: [
                          TextSpan(
                            text: 'Enter the 4-digit code sent to you \nat ',
                          ),
                          TextSpan(
                            text: controller.mob.value,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' did you enter the \ncorrect number?',
                          ),
                        ],
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                ),
                OtpTextField(
                  numberOfFields: 4,

                  enabledBorderColor: Color(0xffFFA914),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,

                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    // controller.verifyOtp(phoneNumber,verificationCode);
                  }, // end onSubmit
                ),
                SizedBox(
                  height: 100,
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'MalgunGothic',
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                      letterSpacing: -0.36,
                      height: 0.8333333333333334,
                    ),
                    children: [
                      TextSpan(
                        text: 'Don\'t receive the ',
                      ),
                      TextSpan(
                        text: 'otp',
                      ),
                      TextSpan(
                        text: ' ?',
                      ),
                      TextSpan(
                        text: ' RESEND OTP',
                        style: TextStyle(
                          color: const Color(0xffFFA914),
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 62,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.0),
                    color: const Color(0xffFFA914),
                    border:
                        Border.all(width: 1.0, color: const Color(0xffffffff)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Get.offAllNamed("/dashbord");
                      Get.snackbar("please use social login", "");
                    },
                    child: Text(
                      'VERFY',
                      style: TextStyle(
                        fontFamily: 'Malgun Gothic',
                        fontSize: 26,
                        color: const Color(0xffffffff),
                        letterSpacing: -0.36,
                        fontWeight: FontWeight.w700,
                        height: 0.9444444444444444,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
