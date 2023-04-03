// ignore_for_file: unnecessary_null_comparison

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/add_profile_controller.dart';

class AddProfileView extends GetView<AddProfileController> {
  const AddProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Add Profile'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full Name',
                          style: TextStyle(
                            fontFamily: 'malgunBold',
                            fontSize: 11.sp,
                            color: const Color(0xff272727),
                            letterSpacing: -0.28,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          softWrap: false,
                        ),
                        SizedBox(height: 10),
                        Obx(() => TextField(
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
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Date of Birth',
                          style: TextStyle(
                            fontFamily: 'malgunBold',
                            fontSize: 11.sp,
                            color: const Color(0xff272727),
                            letterSpacing: -0.28,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          softWrap: false,
                        ),
                        SizedBox(height: 10),
                        Obx(() => TextField(
                              controller: controller.startDateController.value,
                              onTap: (() => controller.getStartDate(context)),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff393862), width: 0.3),
                                    borderRadius: BorderRadius.circular(10)),
                                //labelText: 'Password',
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(
                            fontFamily: 'malgunBold',
                            fontSize: 11.sp,
                            color: const Color(0xff272727),
                            letterSpacing: -0.28,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          softWrap: false,
                        ),
                        SizedBox(height: 10),
                        Obx(() => controller.genderStatusChange.value != null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Text('Male'),
                                      Radio<SingingCharacter>(
                                        value: SingingCharacter.male,
                                        groupValue: controller.gender,
                                        onChanged: (SingingCharacter? value) {
                                          controller.gender = value!;
                                          // controller.partyStatus.text = 'Full';
                                          controller.genderStatusChange.value =
                                              'male';
                                          // print(controller.partyStatus.text);
                                        },
                                      ),
                                      SizedBox(width: 20),
                                      Text('Female'),
                                      Radio<SingingCharacter>(
                                        value: SingingCharacter.female,
                                        groupValue: controller.gender,
                                        onChanged: (SingingCharacter? value) {
                                          controller.gender = value!;
                                          controller.genderStatusChange.value =
                                              'female';
                                          // controller.partyStatus.text = "Awaited";
                                          // print(controller.partyStatus.text);
                                        },
                                      ),
                                      SizedBox(width: 20),
                                      Text('Other'),
                                      Radio<SingingCharacter>(
                                        value: SingingCharacter.other,
                                        groupValue: controller.gender,
                                        onChanged: (SingingCharacter? value) {
                                          controller.gender = value!;
                                          controller.genderStatusChange.value =
                                              '0ther';
                                          // controller.partyStatus.text = "Awaited";
                                          // print(controller.partyStatus.text);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container()),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'City',
                          style: TextStyle(
                            fontFamily: 'malgunBold',
                            fontSize: 11.sp,
                            color: const Color(0xff272727),
                            letterSpacing: -0.28,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          softWrap: false,
                        ),
                        SizedBox(height: 10),
                        CustomSearchableDropDown(
                          // backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          items: controller.cityList,
                          label: 'Select City',
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
                              controller.cityID = value['id'];
                            } else {
                              controller.city.value = "";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'malgunBold',
                            fontSize: 11.sp,
                            color: const Color(0xff272727),
                            letterSpacing: -0.28,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          softWrap: false,
                        ),
                        SizedBox(height: 10),
                        Obx(() => TextField(
                              controller: controller.email.value,
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
                            fontFamily: 'malgunBold',
                            fontSize: 11.sp,
                            color: const Color(0xff272727),
                            letterSpacing: -0.28,
                            height: 1.0714285714285714,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
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
                            height: 58,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(11.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x66393862),
                                  offset: Offset(0, 13),
                                  blurRadius: 34,
                                ),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              'Submit'.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'malgun',
                                fontSize: 21.sp,
                                color: const Color(0xffffffff),
                                letterSpacing: -0.52,
                                fontWeight: FontWeight.w700,
                                height: 0.5769230769230769,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.center,
                              softWrap: false,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
