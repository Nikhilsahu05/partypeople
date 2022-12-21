import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../controllers/view_event_controller.dart';

class ViewEventView extends GetView<ViewEventController> {
  const ViewEventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 260,
                      width: double.infinity,
                      child: Image.network(
                        'https://manage.partypeople.in/${controller.event!.coverPhoto}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(41, 225, 192, 192),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      Share.share(
                          "hy you can join this party ${controller.event!.fullName}");
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(41, 225, 192, 192),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SUBSCRIPTION);
                      // controller.joinParty(controller.event!.id);
                    },
                    child: Container(
                      width: 126,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xffffa914),
                        borderRadius: BorderRadius.circular(11.0),
                        border: Border.all(
                            width: 1.0, color: const Color(0xffffffff)),
                      ),
                      child: Center(
                          child: Text(
                        'Join',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 25,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: false,
                      )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.event!.title,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 30,
                      color: const Color(0xff564d4d),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    controller.event!.description,
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 16,
                      color: const Color(0xff7d7373),
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${controller.event!.startDate} to ${controller.event!.endDate}',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 17,
                      color: const Color(0xff035dc4),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${controller.event!.startTime} to ${controller.event!.endTime}',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 12,
                      color: const Color(0xff929292),
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: const Color(0x247d7373),
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                              width: 1.0, color: const Color(0x24707070)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${controller.event.fullName}',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff7d7373),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            'Organizer',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 12,
                              color: const Color(0xff929292),
                            ),
                            softWrap: true,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0x0f707070),
                      border: Border.all(
                          width: 1.0, color: const Color(0x0f707070)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {},
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffc40d0d),
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Call',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                                color: const Color(0xff7d7373),
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xffc40d0d),
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            Text(
                              'Direction',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                                color: const Color(0xff7d7373),
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xffc40d0d),
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 16,
                                color: const Color(0xff7d7373),
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Member',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: const Color(0xff7d7373),
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: false,
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share('Hay you can join this event');
                        },
                        child: Container(
                          width: 62,
                          height: 27,
                          decoration: BoxDecoration(
                            color: const Color(0xe5035dc4),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Center(
                              child: Text(
                            'invite',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 13,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          )),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
