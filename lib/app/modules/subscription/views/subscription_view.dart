import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: Get.height - 100,
          width: Get.width - 30,
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
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/dancecouple.png',
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SubCard(
                      month: "1",
                      price: "100",
                      controller: controller,
                    ),
                    SubCard(
                      month: "2",
                      price: "200",
                      controller: controller,
                    ),
                    SubCard(
                      month: "3",
                      price: "300",
                      controller: controller,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ],
          ),
        ),
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
