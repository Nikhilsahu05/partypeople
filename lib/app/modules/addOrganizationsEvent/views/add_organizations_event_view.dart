import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../ImageCrop/iimageCrop.dart';
import '../../addIndividualEvent/controllers/add_individual_event_controller.dart';
import '../../addIndividualEvent/views/add_individual_event_view.dart';
import '../controllers/add_organizations_event_controller.dart';

class AddOrganizationsEventView
    extends GetView<AddOrganizationsEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color(0xffA72E2E),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.offAndToNamed('/add-individual-event');
                        },
                        child: Container(
                          height: 35,
                          width: 130,
                          child: Center(
                            child: Text(
                              'Individuals',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18,
                                color: const Color(0xfffffdfb),
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                            child: Text(
                          'Organizations',
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 18,
                            color: const Color(0xff3a3732),
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: false,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Profile Creation',
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 20,
                        color: const Color(0xff564d4d),
                      ),
                      softWrap: false,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // controller.sendRequst();
                  },
                  child: GestureDetector(
                    onTap: () => controller.addOrgnition(),
                    child: Container(
                      height: 34,
                      width: 73,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(168, 147, 0, 0),
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x1b000000),
                            offset: Offset(0, 5),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          softWrap: false,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            TextField(
              controller: controller.name,
              minLines: 1,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 37,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '| Orgnization Name',
                hintStyle: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 37,
                  color: const Color(0x8c7d7373),
                ),
              ),
            ),
            TextField(
              controller: controller.description,
              minLines: 1,
              maxLines: 5,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 14,
                color: const Color(0xff7d7373),
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.menu_sharp,
                  color: Color(0xffB8B2B2),
                  size: 14,
                ),
                border: InputBorder.none,
                hintText: 'Add description',
                hintStyle: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 14,
                  color: const Color(0xff7d7373),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onTap: () {
                controller.getLocation(context);
              },
              controller: controller.location,

              minLines: 1,
              maxLines: 1,
              //enabled: false,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 14,
                color: const Color(0xff035DC4),
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.gps_fixed,
                  color: const Color(0xff035DC4),
                  size: 18,
                ),
                //border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff035DC4)),
                ),

                border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff035DC4), width: 1.0),
                ),
                hintText: 'Select your live location on google',
                hintStyle: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 14,
                  color: const Color(0xff035DC4),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => DropdownButton<String>(
                  value: controller.orgType.value,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color(0xff035DC4)),
                  style: const TextStyle(color: Color(0xff035DC4)),
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    width: Get.width,
                    color: const Color(0xff035DC4),
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.orgType.value = newValue;
                    }
                  },
                  items: <String>['Music event', 'Light show', 'Neon party']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xff035DC4),
                          )),
                    );
                  }).toList(),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Manage branch',
                  style: TextStyle(
                    fontFamily: 'MalgunGothic',
                    fontSize: 16,
                    color: const Color(0xff564d4d),
                    letterSpacing: -0.32,
                    height: 1,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                GestureDetector(
                  onTap: () {
                    controller.addBranch(context);
                  },
                  child: Container(
                    height: 27,
                    width: 63,
                    decoration: BoxDecoration(
                      color: const Color(0xe5035dc4),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 13,
                          color: const Color(0xffffffff),
                        ),
                        softWrap: false,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.citySelected.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        //controller.citySelected(index);
                      },
                      child: Container(
                          height: 50,
                          margin: EdgeInsets.only(bottom: 10),
                          width: Get.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.citySelected[index],
                                    style: TextStyle(
                                      fontFamily: 'MalgunGothic',
                                      fontSize: 14,
                                      color: const Color(0xff035dc4),
                                      letterSpacing: -0.28,
                                      height: 1.1428571428571428,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    textAlign: TextAlign.center,
                                    softWrap: false,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.citySelected.remove(
                                          controller.citySelected[index]);
                                      controller.citySelectedKey
                                          .remove(index.toString());
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                width: Get.width,
                                color: const Color(0xff035dc4),
                              )
                            ],
                          )),
                    );
                  },
                )),
          ]),
        ));
  }
}
