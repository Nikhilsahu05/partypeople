// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'addOrganizationsEvent2/views/add_organizations_event2_view.dart';

class PopularRegularPartyPost extends StatefulWidget {
  bool isPopular;

  PopularRegularPartyPost({required this.isPopular});

  @override
  State<PopularRegularPartyPost> createState() =>
      _PopularRegularPartyPostState();
}

class _PopularRegularPartyPostState extends State<PopularRegularPartyPost> {
  String mid = "bVBouo64708539442572", orderId = "", amount = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;

  @override
  void initState() {
    print('Type of party :: ${widget.isPopular}');

    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
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
              //border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {
                  Get.to(AddOrganizationsEvent2View(
                    isPopular: true,
                  ));
                },
                child: Container(
                  height: 232,
                  width: 232,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(38.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                  child: Center(
                      child: Container(
                          height: 180,
                          width: 180,
                          child: Image.asset('assets/charisma.png'))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'POPULAR PARTY',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 18,
                  letterSpacing: 1.5,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 232,
                  width: 232,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(38.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                  child: Center(
                      child: Container(
                          height: 180,
                          width: 180,
                          child: Image.asset('assets/toast.png'))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'REGULAR PARTY',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 18,
                  letterSpacing: 1.5,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              )
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
}
