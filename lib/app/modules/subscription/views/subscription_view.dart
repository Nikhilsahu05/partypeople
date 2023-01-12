import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Get Subscriptions',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 23,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                ),
                Text(
                  'For people who want to [see and search parties of other \ncities], [start chat - free for females],\n',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 14,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(
                  height: 20,
                ),
                Obx((() => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 241,
                        child: Expanded(
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                height: 241,
                                width: 169,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xffc40d0d)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29312e2e),
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Stack(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.red.shade100,
                                    size: 50,
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                controller.subscriptions!.data!
                                                    .viewSubscriptions![0]!.day
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 44,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.88,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.38636363636363635,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                controller.subscriptions!.data!
                                                    .viewSubscriptions![0]!.name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 22,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.44,
                                                  height: 0.6363636363636364,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                '${controller.subscriptions!.data!.viewSubscriptions![0]!.amount}/mo',
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 30,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.6,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.5,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              )
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 241,
                                width: 169,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xffc40d0d)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29312e2e),
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Stack(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.red.shade100,
                                    size: 50,
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                controller.subscriptions!.data!
                                                    .viewSubscriptions![1]!.day
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 44,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.88,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.38636363636363635,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                controller.subscriptions!.data!
                                                    .viewSubscriptions![1]!.name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 22,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.44,
                                                  height: 0.6363636363636364,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                '${controller.subscriptions!.data!.viewSubscriptions![1]!.amount}/mo',
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 30,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.6,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.5,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              )
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 241,
                                width: 169,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xffc40d0d)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29312e2e),
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Stack(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.red.shade100,
                                    size: 50,
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                controller.subscriptions!.data!
                                                    .viewSubscriptions![2]!.day
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 44,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.88,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.38636363636363635,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                controller.subscriptions!.data!
                                                    .viewSubscriptions![2]!.name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 22,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.44,
                                                  height: 0.6363636363636364,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        controller.subscriptions == null
                                            ? Container()
                                            : Text(
                                                '${controller.subscriptions!.data!.viewSubscriptions![2]!.amount}/mo',
                                                style: TextStyle(
                                                  fontFamily: 'Malgun Gothic',
                                                  fontSize: 30,
                                                  color:
                                                      const Color(0xff035dc4),
                                                  letterSpacing: -0.6,
                                                  fontWeight: FontWeight.w700,
                                                  height: 0.5,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                              )
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ))),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Continue"),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     foregroundColor: Colors.black,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(32.0),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Positioned(
              top: 30,
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset('assets/back_Button.png'))),
          Positioned(
            bottom: 0,
            child: Container(
              height: Get.height / 2.7,
              width: Get.width,
              color: Colors.white,
            ),
          ),
          Positioned(bottom: 0, child: Image.asset("assets/sub_bottom.png")),
          Positioned(
              top: 20, right: 10, child: Image.asset("assets/sub_Star.png")),
          Positioned(
            left: 40,
            right: 40,
            top: Get.height / 1.7,
            child: Column(
              children: [
                Container(
                  width: 311,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xffffa914),
                    borderRadius: BorderRadius.circular(11.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xffffffff)),
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
                    'CONTINUE',
                    style: TextStyle(
                      fontFamily: 'Malgun Gothic',
                      fontSize: 26,
                      color: const Color(0xffffffff),
                      letterSpacing: -0.52,
                      fontWeight: FontWeight.w700,
                      height: 0.5769230769230769,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    'No Thanks',
                    style: TextStyle(
                      fontFamily: 'Malgun Gothic',
                      fontSize: 20,
                      color: const Color(0xff707070),
                      letterSpacing: -0.4,
                      height: 0.75,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SubCard extends StatelessWidget {
  final SubscriptionController controller;
  final String month;
  final String price;
  const SubCard({
    Key? key,
    required this.controller,
    required this.month,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: controller.count == null
          ? Container()
          : GestureDetector(
              onTap: () {
                controller.count = int.parse(month);
              },
              child: Container(
                  // customize the appearance of your box here
                  decoration: BoxDecoration(
                    color: Color.fromARGB(30, 236, 221, 213),
                    border: Border.all(
                      color: controller.count.toString() == month
                          ? Colors.amber
                          : Colors.grey[400]!,
                      width: 3,
                    ),
                  ),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        month,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'Malgun Gothic',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "month",
                        style: TextStyle(
                          fontFamily: 'Malgun Gothic',
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        //rupee symbol
                        "\u20B9$price/mo",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
