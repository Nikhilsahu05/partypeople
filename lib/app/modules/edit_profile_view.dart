// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pertypeople/app/modules/cust_profile/controllers/cust_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  CustProfileController controller = Get.put(CustProfileController());

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
              GestureDetector(
                onTap: () {
                  controller.onCamera(context);
                },
                child: Obx(
                  (() => controller.profilePic.value.contains('upload')
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                            'http://app.partypeople.in/${controller.profilePic.value}',
                          ),
                        )
                      : controller.img != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(
                                File(controller.img!.path),
                              ),
                            )
                          : Image.asset(
                              "assets/profile_pic.png",
                              height: 200,
                              width: 200,
                            )),
                ),
              ),
              SizedBox(height: 10),
              Text(
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
                            '0 Views',
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
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ),
                          Text(
                            '0 Likes',
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
                    ]),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(top: 10),
                height: Get.height - 380,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Full Name *',
                        style: TextStyle(
                          fontFamily: 'malgun',
                          fontSize: 14,
                          color: const Color(0xff272727),
                          letterSpacing: -0.28,
                          height: 1.0714285714285714,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: controller.name.value,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            controller.isNameEmpty.value = false;
                          } else {
                            controller.isNameEmpty.value = true;
                          }
                        },
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          // focusedBorder: InputBorder(borderSide: BorderSide(color: Color(0xff393862))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorText: controller.isNameEmpty.value
                              ? 'Name Can\'t Be Empty'
                              : null,
                          //labelText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'City',
                        style: TextStyle(
                          fontFamily: 'malgun',
                          fontSize: 14,
                          color: const Color(0xff272727),
                          letterSpacing: -0.28,
                          height: 1.0714285714285714,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                      SizedBox(height: 10),
                      Obx(() => controller.city == null
                          ? Container()
                          : CustomSearchableDropDown(
                              // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                              // initialValue: [controller.cityID.value ],
                              items: controller.cityList,
                              label: controller.city.value,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xff393862), width: 0.2),
                              ),

                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(Icons.search),
                              ),
                              dropDownMenuItems: controller.cityList
                                  .map((e) => e['name'])
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.city.value = value['name'];
                                  controller.cityID.value = value['id'];
                                } else {
                                  controller.city.value = "";
                                }
                              },
                            )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'malgun',
                          fontSize: 14,
                          color: const Color(0xff272727),
                          letterSpacing: -0.28,
                          height: 1.0714285714285714,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                      SizedBox(height: 10),
                      Obx(() => TextField(
                            controller: controller.email,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                controller.isEmailEmpty.value = false;
                              } else {
                                controller.isEmailEmpty.value = true;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText: controller.isEmailEmpty.value
                                  ? 'Email Can\'t Be Empty'
                                  : null,
                              // focusedBorder: InputBorder(borderSide: BorderSide(color: Color(0xff393862))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff393862), width: 0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              //labelText: 'Password',
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Mobile',
                        style: TextStyle(
                          fontFamily: 'malgun',
                          fontSize: 14,
                          color: const Color(0xff272727),
                          letterSpacing: -0.28,
                          height: 1.0714285714285714,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                      SizedBox(height: 10),
                      Obx(() => TextField(
                            maxLength: 10,
                            controller: controller.mob.value,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              // focusedBorder: InputBorder(borderSide: BorderSide(color: Color(0xff393862))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff393862), width: 0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              //labelText: 'Password',
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateProfile();
                        },
                        child: Container(
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
                                fontFamily: 'malgun',
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
                        ),
                      )
                    ],
                  ),
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
