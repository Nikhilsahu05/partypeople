// ignore_for_file: must_be_immutable

import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
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
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              child: Stack(children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'User Name',
                        style: TextStyle(
                          fontFamily: 'malgun',
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: -0.36,
                          fontWeight: FontWeight.w700,
                          height: 0.9444444444444444,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 62,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 0.2, color: const Color(0xff707070)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x21329d9c),
                            offset: Offset(0, 13),
                            blurRadius: 34,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: TextField(
                          maxLines: 1,
                          controller: username,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: const Color(0xff707070),
                            ),
                            border: InputBorder.none,
                            label: Text('Enter Username'),
                            hintStyle: TextStyle(
                              fontFamily: 'malgun',
                              fontSize: 18,
                              color: const Color(0xff4b4444),
                              letterSpacing: -0.36,
                              fontWeight: FontWeight.w700,
                              height: 0.9444444444444444,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontFamily: 'malgun',
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                          letterSpacing: -0.36,
                          fontWeight: FontWeight.w700,
                          height: 0.9444444444444444,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 62,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21.0),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 0.2, color: const Color(0xff707070)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x21329d9c),
                            offset: Offset(0, 13),
                            blurRadius: 34,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: TextField(
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: controller.mobileNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_iphone,
                              color: const Color(0xff707070),
                            ),
                            border: InputBorder.none,
                            label: Text('Enter Mobile Number'),
                            hintStyle: TextStyle(
                              fontFamily: 'malgun',
                              fontSize: 18,
                              color: const Color(0xff4b4444),
                              letterSpacing: -0.36,
                              fontWeight: FontWeight.w700,
                              height: 0.9444444444444444,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.0),
                        color: const Color(0xffFFA914),
                        border: Border.all(
                            width: 1.0, color: const Color(0xffffffff)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x66FFA914),
                            offset: Offset(0, 13),
                            blurRadius: 34,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (controller.mobileNumber.text.isNotEmpty &&
                              username.text.isNotEmpty) {
                            controller.verifyPhone();
                          } else {
                            Get.snackbar(
                                'Field is Empty', 'Fill all the fields');
                          }
                        },
                        child: Text(
                          'GET OTP',
                          style: TextStyle(
                            fontFamily: 'malgun',
                            fontSize: 26,
                            color: const Color(0xffffffff),
                            letterSpacing: -0.36,
                            fontWeight: FontWeight.bold,
                            height: 0.9444444444444444,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Prefer to login with social media',
                      style: TextStyle(
                        fontFamily: 'malgun',
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 255, 255),
                        letterSpacing: -0.36,
                        height: 0.8333333333333334,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 6,
                          width: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: const Color(0xffFFA914),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.logInWithGoogle();
                              },
                              child: Image.asset(
                                'assets/googleLogo.png',
                                height: 45,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'By creating an account, you agree to our \nTerms of Service and Privacy Policy',
                          style: TextStyle(
                            fontFamily: 'malgun',
                            fontSize: 10,
                            color: Colors.grey.shade300,
                            letterSpacing: -0.2,
                            height: 1.4,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    ));
  }
}
