// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:pertypeople/app/modules/edit_party_screen.dart';

import '../controllers/subscription_controller.dart';

// ignore: must_be_immutable
class SubscriptionView extends StatefulWidget {
  String id;
  var data;

  SubscriptionView({required this.id, required this.data});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  customAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Text("Party Time and ID"),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        // showCustomDialog(context);
                        Get.to(SubscriptionView(
                          id: widget.data['id'],
                          data: widget.data,
                        ));
                      },
                      child: Container(
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.183, -0.74),
                              end: Alignment(1.071, -0.079),
                              colors: [
                                Colors.pink,
                                Colors.purple,
                                Colors.pink,
                              ],
                              stops: [0.0, 0.564, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(45)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 35,
                                  child: Image.asset('assets/shuttle.png')),
                              Text(
                                "Boost Post".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                  Container(
                    height: 200,
                    width: 300,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          // showCustomDialog(context, '499');
                          showDialog(
                            context: context,
                            builder: (_) => LogoutOverlay(
                              data: widget.data,
                            ),
                          );
                        },
                        child: Center(
                          child: Container(
                              height: 300,
                              width: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xffc40d0d)),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '1',
                                        style: TextStyle(
                                          fontFamily: 'malgun',
                                          fontSize: 30,
                                          color: const Color(0xff035dc4),
                                          letterSpacing: -0.88,
                                          fontWeight: FontWeight.w700,
                                          height: 0.38636363636363635,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'DAYS',
                                        style: TextStyle(
                                          fontFamily: 'malgun',
                                          fontSize: 20,
                                          color: const Color(0xff035dc4),
                                          letterSpacing: -0.44,
                                          height: 0.6363636363636364,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '₹499',
                                        style: TextStyle(
                                          fontFamily: 'malgun',
                                          fontSize: 30,
                                          color: const Color(0xff035dc4),
                                          letterSpacing: -0.6,
                                          fontWeight: FontWeight.w700,
                                          height: 0.5,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/excellence.png')),
                                ),
                              ])),
                        ),
                      ),
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }
}

class SubCard extends StatefulWidget {
  final SubscriptionController controller;
  final String month;
  final String price;

  SubCard({
    Key? key,
    required this.controller,
    required this.month,
    required this.price,
  }) : super(key: key);

  @override
  State<SubCard> createState() => _SubCardState();
}

class _SubCardState extends State<SubCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: widget.controller.count == null
          ? Container()
          : GestureDetector(
              onTap: () {
                widget.controller.count = int.parse(widget.month);
              },
              child: Container(
                  // customize the appearance of your box here
                  decoration: BoxDecoration(
                    color: Color.fromARGB(30, 236, 221, 213),
                    border: Border.all(
                      color: widget.controller.count.toString() == widget.month
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
                        widget.month,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'malgun',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "month",
                        style: TextStyle(
                          fontFamily: 'malgun',
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
                        "\u20B9${widget.price}/mo",
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

class LogoutOverlay extends StatefulWidget {
  var data;

  LogoutOverlay({
    required this.data,
  });

  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay> {
  SubscriptionController controller = Get.put(SubscriptionController());
  var totalHoursOfParty;
  var noOfDays;

  @override
  void initState() {
    totalHoursOfParty = DateTime.parse(widget.data['end_date'].toString())
        .difference(DateTime.now());
    noOfDays = totalHoursOfParty.inDays;
    print("Check for data => ${totalHoursOfParty.inDays}");
    if (noOfDays == 0) {
      noOfDays = 1;
      controller.discountPercentage.value = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icons8-wallet.gif'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your Party will be boosted as Popular Party till \n End Date - ${widget.data['end_date']} \n End Time - ${widget.data['end_time']}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => Text(
                      'Boosted Days - ${controller.quantitySelect.toString()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                SizedBox(
                  height: 10,
                ),
                Obx(() => Text(
                      'Total Amount - ₹${controller.totalAmount}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                InputQty(
                  maxVal: noOfDays,
                  initVal: noOfDays,
                  minVal: 1,
                  isIntrinsicWidth: false,
                  borderShape: BorderShapeBtn.circle,
                  boxDecoration: const BoxDecoration(),
                  steps: 1,
                  onQtyChanged: (val) {
                    controller.quantitySelect.value = int.parse(val.toString());

                    if (controller.quantitySelect.value >= 20) {
                      controller.discountPercentage.value = 20;
                    } else {
                      controller.discountPercentage.value =
                          controller.quantitySelect.value;
                    }

                    controller.totalAmount.value =
                        controller.subscriptionAmount.value *
                            int.parse(val.toString());

                    int amount = (((int.parse(val.toString()) *
                                    controller.subscriptionAmount.value) *
                                (controller.discountPercentage.value).round()) /
                            100)
                        .round();

                    controller.totalAmount.value =
                        controller.totalAmount.value - amount;

                    if (int.parse(val.toString()) == 1) {
                      controller.totalAmount.value = 499;
                    }

                    if (noOfDays == 1 || controller.totalAmount.value == 499) {
                      controller.discountPercentage.value = 0;
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => Text("Discount - ${controller.discountPercentage}%")),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        controller.initPaymentSheet(
                            controller.totalAmount.value.toString());
                      });
                    },
                    child: Container(
                      width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.183, -0.74),
                            end: Alignment(1.071, -0.079),
                            colors: [
                              Colors.pink,
                              Colors.purple,
                              Colors.pink,
                            ],
                            stops: [0.0, 0.564, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(45)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 35,
                                child: Image.asset('assets/shuttle.png')),
                            Text(
                              "Boost Post".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      Get.to(EditProfileScreen(
                          editProfileData: widget.data, isPopularParty: false));
                    },
                    child: Text(
                      "Edit Date & Time",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
