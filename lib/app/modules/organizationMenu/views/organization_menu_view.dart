// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../controllers/organization_menu_controller.dart';

class OrganizationMenuView extends GetView<OrganizationMenuController> {
  const OrganizationMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(children: [
              SizedBox(height: 50),
              GetStorage().read('profile_picture') == null
                  ? Image.asset('assets/profile_pic.png')
                  : CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        'https://manage.partypeople.in/' +
                            GetStorage().read('profile_picture'),
                      ),
                    ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  GetStorage().read('full_name') ?? "",
                  style: TextStyle(
                    fontFamily: 'malgun',
                    fontSize: 27,
                    color: const Color(0xffffffff),
                    letterSpacing: -0.54,
                    height: 1.2222222222222223,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(5),
                height: 66,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  border:
                      Border.all(width: 0.5, color: const Color(0xff707070)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 5),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/event.png',
                            height: 30,
                          ),
                          Text(
                            ' Total Events',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 18,
                              color: const Color(0xff7d7373),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: false,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.heart_broken_sharp,
                            color: Colors.red,
                            size: 30,
                          ),
                          Text(
                            '0 likes',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 18,
                              color: const Color(0xff7d7373),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: false,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/plan.png',
                            height: 30,
                          ),
                          Text(
                            'No active Plan',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 18,
                              color: const Color(0xff7d7373),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: false,
                          ),
                        ],
                      )
                    ]),
              ),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.ORGANIZATION_PROFILE_NEW);
                  },
                  child: drawerTile(title: 'Edit Profile', icon: Icons.edit)),
              drawerTile(title: 'Post History', icon: Icons.history),
              drawerTile(title: 'Settings', icon: Icons.settings),
              drawerTile(title: 'Privacy', icon: Icons.privacy_tip),
              drawerTile(title: 'Security', icon: Icons.security),
              GestureDetector(
                  onTap: () {
                    GetStorage().remove('token');
                    Get.offAllNamed(Routes.HOME);
                  },
                  child: drawerTile(title: 'Logout', icon: Icons.logout)),
            ]),
          ),
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
                          fontSize: 19,
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
