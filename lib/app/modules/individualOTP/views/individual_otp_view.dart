import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

class IndividualOtpView extends StatefulWidget {
  const IndividualOtpView({super.key});

  @override
  State<IndividualOtpView> createState() => _IndividualOtpViewState();
}

class _IndividualOtpViewState extends State<IndividualOtpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Phone Verification',
                      style: TextStyle(
                        fontFamily: 'malgun',
                        fontSize: 13.sp,
                        color: Color(0xffFFA914),
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
                        fontFamily: 'malgun',
                        fontSize: 26.sp,
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
                  const SizedBox(height: 15),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'malgun',
                            fontSize: 12.sp,
                            color: Color(0xffB8A9A9),
                            letterSpacing: -0.28,
                            height: 1.2142857142857142,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Enter the 4-digit code sent to you \nat ',
                            ),
                            TextSpan(
                              text: 'text',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const TextSpan(
                              text: ' did you enter the \ncorrect number?',
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
              child: DottedLine(dashLength: 8, dashColor: Color(0xffD9D3D3)),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: OTPTextField(
                  controller: OtpFieldController(),
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
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                  onChanged: (pin) {},
                  onCompleted: (pin) {}),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {},
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'malgun',
                    fontSize: 12.sp,
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
                      style: TextStyle(color: Colors.yellow, fontSize: 13.sp),
                    ),
                  ],
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            IndividualProfileButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class IndividualProfileButton extends StatefulWidget {
  final Function onPressed;

  IndividualProfileButton({required this.onPressed});

  @override
  _IndividualProfileButtonState createState() =>
      _IndividualProfileButtonState();
}

class _IndividualProfileButtonState extends State<IndividualProfileButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        Tween<double>(begin: 1.0, end: 0.95).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onPressed();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: Transform.scale(
        scale: _animation.value,
        child: Container(
          width: Get.width * 0.6,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            color: const Color(0xffFFA914),
            border: Border.all(width: 1.0, color: const Color(0xffffffff)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x66FFA914),
                offset: Offset(0, 13),
                blurRadius: 34,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Verify OTP'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'malgun',
                  fontSize: 13.sp,
                  color: const Color(0xffffffff),
                  letterSpacing: -0.36,
                  fontWeight: FontWeight.bold,
                  height: 0.9444444444444444,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
