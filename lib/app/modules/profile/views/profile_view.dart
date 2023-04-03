// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.183, -0.74),
              end: Alignment(1.071, -0.079),
              colors: [
                const Color(0xffd10e0e),
                const Color(0xff870606),
                const Color(0xff300202)
              ],
              stops: [0.0, 0.564, 1.0],
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetStorage().read('profile_picture') == null
                    ? Image.asset('assets/profile_pic.png')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://manage.partypeople.in/' +
                                GetStorage().read('profile_picture'),
                          ),
                        ),
                      ),
                Text(
                  GetStorage().read('full_name') ?? "",
                  style: TextStyle(
                    fontFamily: 'malgun',
                    fontSize: 24.sp,
                    color: const Color(0xffffffff),
                    letterSpacing: -0.54,
                    height: 1.2222222222222223,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   height: 66,
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xffffffff),
                  //     border:
                  //         Border.all(width: 0.5, color: const Color(0xff707070)),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: const Color(0x29000000),
                  //         offset: Offset(0, 5),
                  //         blurRadius: 6,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Column(
                  //           children: [
                  //             Icon(
                  //               Icons.people,
                  //               color: Colors.red,
                  //               size: 30,
                  //             ),
                  //             Text(
                  //               '0 views',
                  //               style: TextStyle(
                  //                 fontFamily: 'Segoe UI',
                  //                 fontSize: 18,
                  //                 color: const Color(0xff7d7373),
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //               softWrap: false,
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             Icon(
                  //               Icons.heart_broken_sharp,
                  //               color: Colors.red,
                  //               size: 30,
                  //             ),
                  //             Text(
                  //               '0 likes',
                  //               style: TextStyle(
                  //                 fontFamily: 'Segoe UI',
                  //                 fontSize: 18,
                  //                 color: const Color(0xff7d7373),
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //               softWrap: false,
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             Icon(
                  //               Icons.calendar_month,
                  //               color: Colors.red,
                  //               size: 30,
                  //             ),
                  //             Text(
                  //               'No active Plan',
                  //               style: TextStyle(
                  //                 fontFamily: 'Segoe UI',
                  //                 fontSize: 18,
                  //                 color: const Color(0xff7d7373),
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //               softWrap: false,
                  //             ),
                  //           ],
                  //         )
                  //       ]),
                  // ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.CUST_PROFILE);
                      },
                      child:
                          drawerTile(title: 'View Profile', icon: Icons.edit)),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ADD_EVENT);
                      },
                      child: drawerTile(title: 'Post Party', icon: Icons.chat)),
                  drawerTile(title: 'History Post', icon: Icons.help),
                  drawerTile(
                      title: 'Subscription Plan', icon: Icons.contact_page),
                  drawerTile(title: 'Setting', icon: Icons.info),
                  GestureDetector(
                      onTap: () {
                        GetStorage().remove('token');
                        Get.offAllNamed(Routes.HOME);
                      },
                      child: drawerTile(title: 'Logout', icon: Icons.logout)),
                ],
              ),
            ),
          ]),
        ),
        Positioned(
          top: 30,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              'assets/back.png',
              height: 30,
              width: 30,
            ),
          ),
        ),
      ],
    ));
  }

  Container drawerTile({
    String title = '',
    IconData icon = Icons.person,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 58,
      width: Get.width - 30,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x59000000),
            offset: Offset(-6.123234262925839e-17, 1),
            blurRadius: 27,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        icon,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16.sp,
                          color: const Color(0xff525252),
                          letterSpacing: -0.38,
                          fontWeight: FontWeight.w600,
                          height: 1.2105263157894737,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                      SizedBox(width: 180),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            bottom: 10,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
