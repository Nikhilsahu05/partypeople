import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/organization_profile_controller.dart';

class OrganizationProfileView extends GetView<OrganizationProfileController> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        Container(
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
              Text(
                'Profile ',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 20,
                  color: const Color(0xff564d4d),
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Organization name',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 12,
                  color: const Color(0xff707070),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                controller.data['name'],
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 30,
                  color: const Color(0xff564d4d),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                controller.data['description'],
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 16,
                  color: const Color(0xff7d7373),
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Organization type',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 17,
                  color: const Color(0xff035dc4),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '09:30 PM to 11:30 PM',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 12,
                  color: const Color(0xff929292),
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                controller.data['type'].toString(),
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 14,
                  color: const Color(0xff7d7373),
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/add-organizations-event2', arguments:controller.data['name']);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xffc40d0d),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 5),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                      child: Row(
                    children: [
                      Image.asset(
                        'assets/hi.png',
                      ),
                      Text(
                        'Host New Event  ',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 25,
                          color: const Color(0xffffffff),
                        ),
                        softWrap: false,
                      ),
                    ],
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
