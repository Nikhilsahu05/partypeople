import 'package:adobe_xd/adobe_xd.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../login/controllers/login_controller.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  // ignore: non_constant_identifier_names
  String OTPCodeValue = '';

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // var phoneNumber = Get.arguments;
    return Scaffold(
        body: controller.isLoading.value == true
            ? Center(
                child: Image.asset('assets/loading_bar.gif'),
              )
            : Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.0, 0.0),
                    radius: 0.424,
                    colors: [Color(0xffb11212), Color(0xff2e0303)],
                    stops: [0.0, 1.0],
                    transform: GradientXDTransform(
                        0.0, -1.0, 1.23, 0.0, -0.115, 1.0, Alignment(0.0, 0.0)),
                  ),
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Phone Verification',
                                style: TextStyle(
                                  fontFamily: 'malgun',
                                  fontSize: 21,
                                  color: Color(0xffFFA914),
                                  letterSpacing: -0.42,
                                  fontWeight: FontWeight.w700,
                                  height: 0.8095238095238095,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'OTP code',
                                style: TextStyle(
                                  fontFamily: 'malgun',
                                  fontSize: 43,
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  letterSpacing: -0.86,
                                  fontWeight: FontWeight.w700,
                                  height: 0.8372093023255814,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text.rich(
                                  TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'malgun',
                                      fontSize: 14,
                                      color: Color(0xffB8A9A9),
                                      letterSpacing: -0.28,
                                      height: 1.2142857142857142,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            'Enter the 4-digit code sent to you \nat ',
                                      ),
                                      TextSpan(
                                        text: controller.mobileNumber.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      const TextSpan(
                                        text:
                                            ' did you enter the \ncorrect number?',
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: const TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: DottedLine(
                            dashLength: 8, dashColor: Color(0xffD9D3D3)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55.0),
                        child: OTPTextField(
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 55,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 9,
                            contentPadding: EdgeInsets.all(20),
                            otpFieldStyle: OtpFieldStyle(
                                backgroundColor: Colors.white,
                                borderColor: Colors.white,
                                enabledBorderColor: Colors.white),
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black),
                            onChanged: (pin) {
                              OTPCodeValue = pin;
                              if (kDebugMode) {
                                print(OTPCodeValue);
                              }
                            },
                            onCompleted: (pin) {
                              if (kDebugMode) {
                                print(OTPCodeValue);
                              }

                              OTPCodeValue = pin;
                            }),
                      ),
                      const SizedBox(
                        height: 75,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.verifyPhone();
                        },
                        child: const Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'malgun',
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
                                text: 'OTP',
                              ),
                              TextSpan(
                                text: ' ?',
                              ),
                              TextSpan(
                                text: ' RESEND OTP',
                                style: TextStyle(
                                    color: Colors.yellow, fontSize: 16),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        child: Container(
                          height: 62,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.0),
                            color: const Color(0xffFFA914),
                            border: Border.all(
                                width: 1.0, color: const Color(0xffffffff)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (OTPCodeValue.length != 4) {
                                Get.snackbar(
                                  "Enter 4 Digit OTP",
                                  '',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                );
                              } else {
                                controller.verifyOTP(OTPCodeValue, context);
                              }
                            },
                            child: Text(
                              'Verify'.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'malgun',
                                fontSize: 26,
                                color: Color(0xffffffff),
                                letterSpacing: -0.36,
                                fontWeight: FontWeight.bold,
                                height: 0.9444444444444444,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
