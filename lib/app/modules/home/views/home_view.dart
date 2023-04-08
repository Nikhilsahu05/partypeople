import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  static var kHeadingStyle = GoogleFonts.oswald(
    fontSize: 29.sp,
    color: Colors.white,
    letterSpacing: -0.7000000000000001,
    fontWeight: FontWeight.w600,
    height: 1.9964688982282366,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! > 10) {
            Get.find<HomeController>().decrement();
          } else if (details.primaryVelocity! < -10) {
            Get.find<HomeController>().increment();
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, 0.0),
                  radius: 0.424,
                  colors: [
                    const Color(0xffb11212),
                    const Color(0xff2e0303),
                  ],
                  stops: [0.0, 1.0],
                  transform: GradientXDTransform(
                    0.0,
                    -1.0,
                    1.23,
                    0.0,
                    -0.115,
                    1.0,
                    Alignment(0.0, 0.0),
                  ),
                ),
              ),
              child: Center(
                child: Obx(() => Get.find<HomeController>().pageCount == 0
                    ? Image.asset('assets/dancecouple.png')
                    : Get.find<HomeController>().pageCount == 1
                        ? Image.asset('assets/img2.png')
                        : Image.asset('assets/img3.png')),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Get.find<HomeController>().pageCount == 0
                        ? Text('Find Your Partner', style: kHeadingStyle)
                        : Get.find<HomeController>().pageCount == 1
                            ? Text('Find Chillout Place', style: kHeadingStyle)
                            : Text('Find Best Club', style: kHeadingStyle),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Obx(
                      () => Get.find<HomeController>().pageCount == 0
                          ? Text(
                              'Discover the ultimate partying experience with PartyMate. Connect with strangers and have an unforgettable time!',
                              style: GoogleFonts.oswald(
                                fontSize: 11.sp,
                                color: Colors.white,
                              ))
                          : Get.find<HomeController>().pageCount == 1
                              ? Text(
                                  'Join the party with PartyNow! Meet new people and find the hottest parties in town with just a few taps.',
                                  style: GoogleFonts.oswald(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                  ))
                              : Text(
                                  'Make new friends and party like never before with PartyConnect. Find exciting events and connect with strangers who share your love for partying.',
                                  style: GoogleFonts.oswald(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                  )),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 45,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LOGIN);
                },
                child: Text(
                  'Skip\n ',
                  style: TextStyle(
                    fontFamily: 'malgun',
                    fontSize: 11.sp,
                    color: Colors.white,
                    letterSpacing: -0.24,
                    height: 1.6666666666666667,
                  ),
                ),
              ),
            ),
            Obx(
              () => Positioned(
                bottom: 45,
                left: 20,
                child: Row(
                  children: [
                    Get.find<HomeController>().pageCount == 0
                        ? bottomScrollView(
                            color: Color(0xffdbb314),
                            width: 33,
                          )
                        : bottomScrollView(
                            color: Colors.white,
                            width: 15,
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Get.find<HomeController>().pageCount == 1
                        ? bottomScrollView(
                            color: Color(0xffdbb314),
                            width: 33,
                          )
                        : bottomScrollView(
                            color: Colors.white,
                            width: 15,
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    Get.find<HomeController>().pageCount == 2
                        ? bottomScrollView(
                            color: Color(0xffdbb314),
                            width: 33,
                          )
                        : bottomScrollView(
                            color: Colors.white,
                            width: 15,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class bottomScrollView extends StatelessWidget {
  bottomScrollView({
    required this.color,
    required this.width,
  });

  final color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(11.0),
      ),
    );
  }
}
