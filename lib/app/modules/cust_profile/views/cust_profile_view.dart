import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cust_profile_controller.dart';

class CustProfileView extends GetView<CustProfileController> {
  const CustProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: Get.height - 100,
            width: Get.width,
            color: Colors.white,
          ),
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
            child: Column(children: [
              SizedBox(height: 50),
              Image.asset('assets/profile_pic.png'),
              Text(
                'Rachit Pawar',
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
                            '200 Views',
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
                            '200 Views',
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
                            '1 Week Plan',
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

              Container(
                padding: EdgeInsets.only(top: 10),
                height: Get.height - 300,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'Name',
                        ),
                      ),
                      //textfield for email
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      //radio button for gender
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "male",
                            groupValue: "",
                            onChanged: (value) {},
                          ),
                          Text("Male"),
                          Radio(
                            value: "female",
                            groupValue: "_gender",
                            onChanged: (value) {},
                          ),
                          Text("Female"),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 59,
                        width: 311,
                        decoration: BoxDecoration(
                          color: const Color(0xffffa914),
                          borderRadius: BorderRadius.circular(11.0),
                          border: Border.all(
                              width: 1.0, color: const Color(0xffffffff)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x66d7924d),
                              offset: Offset(0, 13),
                              blurRadius: 34,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'SAVE PROFILE',
                            style: TextStyle(
                              fontFamily: 'Malgun Gothic',
                              fontSize: 26,
                              color: const Color(0xffffffff),
                              letterSpacing: -0.52,
                              fontWeight: FontWeight.w700,
                              height: 0.5769230769230769,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                            softWrap: false,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // drawerTile(title: 'Edit Profile', icon: Icons.edit),
              // drawerTile(title: 'FAQ', icon: Icons.chat),
              // drawerTile(title: 'Help', icon: Icons.help),
              // drawerTile(title: 'Contact Us', icon: Icons.contact_page),
              // drawerTile(title: 'About Us', icon: Icons.info),
              // drawerTile(title: 'Logout', icon: Icons.logout),
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
      ),
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
