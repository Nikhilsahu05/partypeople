import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../controllers/drawer_controller.dart';

class DrawerView extends GetView<DrawerController2> {
  const DrawerView({Key? key}) : super(key: key);
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
                    fontFamily: 'MalgunGothicBold',
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
                          Icon(
                            Icons.people,
                            color: Colors.red,
                            size: 30,
                          ),
                          Text(
                            '0 views',
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
                          Icon(
                            Icons.calendar_month,
                            color: Colors.red,
                            size: 30,
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
                    Get.toNamed(Routes.CUST_PROFILE);
                  },
                  child: drawerTile(title: 'Edit Profile', icon: Icons.edit)),
              drawerTile(title: 'FAQ', icon: Icons.chat),
              drawerTile(title: 'Help', icon: Icons.help),
              drawerTile(title: 'Contact Us', icon: Icons.contact_page),
              drawerTile(title: 'About Us', icon: Icons.info),
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
