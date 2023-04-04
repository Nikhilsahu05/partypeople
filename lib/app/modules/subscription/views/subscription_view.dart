// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, must_be_immutable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent2/controllers/add_organizations_event2_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
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
        child: Container(
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
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Get Subscriptions',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18.sp,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    height: Get.height * 0.23,
                    width: Get.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '1',
                          style: TextStyle(
                            fontFamily: 'malgun',
                            fontSize: 18.sp,
                            color: Colors.red.shade900,
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
                            fontSize: 16.sp,
                            color: Colors.red.shade900,
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
                            fontSize: 18.sp,
                            color: Colors.red.shade900,
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: LogoutOverlay(data: widget.data),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
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
    return widget.controller.count == null
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
                        fontSize: 26.sp,
                        color: Colors.white,
                        fontFamily: 'malgun',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "month",
                      style: TextStyle(
                        fontFamily: 'malgun',
                        fontSize: 15.sp,
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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
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

  AddOrganizationsEvent2Controller addOrganizationsEvent2Controller =
      Get.put(AddOrganizationsEvent2Controller());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Your Party will be boosted as Popular Party \nEnd Date - ${widget.data['end_date']} \nEnd Time - ${widget.data['end_time']}",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'malgun',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 20),
              Obx(() => Text(
                    'Boosted Days - ${controller.quantitySelect.toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'malgun',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  )),
              SizedBox(height: 10),
              Obx(() => Text(
                    'Total Amount - ₹${controller.totalAmount}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'malgun',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
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
              SizedBox(height: 20),
              Obx(() => Text(
                    "Discount - ${controller.discountPercentage}%",
                    style: TextStyle(
                      fontFamily: 'malgun',
                    ),
                  )),
              SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.orange),
                  onPressed: () {
                    addOrganizationsEvent2Controller.isPopular.value = false;
                    addOrganizationsEvent2Controller.isEditable.value = true;
                    Get.toNamed(Routes.ADD_ORGANIZATIONS_EVENT2);
                  },
                  child: Text(
                    "Edit Date & Time",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontFamily: 'malgun',
                    ),
                  )),
              SizedBox(
                height: 20,
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
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 25,
                            child: Image.asset('assets/shuttle.png'),
                          ),
                          Text(
                            "Boost Post".toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                fontFamily: 'malgun',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class FeatureWidget extends StatelessWidget {
  final String title;
  final String description;

  FeatureWidget({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
