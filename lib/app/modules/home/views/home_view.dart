import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 10) {
          // Get.toNamed('/splashscreen-two');
        } else if (details.delta.dx < -10) {
          Get.toNamed('/splashscreen-two');
        }
      },
      child: Stack(
        children: [
          Container(
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
                child: Image(
                  image: AssetImage('assets/dancecouple.png'),
                ),
              )),
          Positioned(
              bottom: 70,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your Partner',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 35,
                      color: const Color(0xffffffff),
                      letterSpacing: -0.7000000000000001,
                      fontWeight: FontWeight.w600,
                      height: 1.9964688982282366,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lorem Ipsum is simply dummy text\nof the printing and typesetting industry. \nLorem Ipsum has been the industry\'s \nstandard dummy text ever\n ',
                    style: TextStyle(
                      fontFamily: 'MalgunGothic',
                      fontSize: 12,
                      color: const Color(0xffffffff),
                      letterSpacing: -0.24,
                      height: 1.6666666666666667,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    softWrap: false,
                  )
                ],
              )),
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
                  fontFamily: 'MalgunGothic',
                  fontSize: 12,
                  color: const Color(0xffffffff),
                  letterSpacing: -0.24,
                  height: 1.6666666666666667,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                softWrap: false,
              ),
            ),
          ),
          Positioned(
              bottom: 45,
              left: 20,
              child: Row(
                children: [
                  Container(
                    height: 9,
                    width: 33,
                    decoration: BoxDecoration(
                      color: const Color(0xffdbb314),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 9,
                    width: 15,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 9,
                    width: 15,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
