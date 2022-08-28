import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../addIndividualEvent/controllers/add_individual_event_controller.dart';
import '../controllers/add_event_controller.dart';

class AddEventView extends GetView<AddEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () async {
             await Get.toNamed('/add-individual-event');
              if (AddIndividualEventController.picture != null) {
      print("get picture");
      AddIndividualEventController.picture?.delete();
      AddIndividualEventController.picture = null;
    }
            },
            child: Container(
              height: 232,
              width: 232,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(38.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: Center(child: Image.asset('assets/man.png')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Individuals',
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 35,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
            softWrap: false,
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('/add-organizations-event');
            },
            child: Container(
              height: 232,
              width: 232,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(38.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: Center(child: Image.asset('assets/bulding.png')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Organizations',
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 35,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w600,
            ),
            softWrap: false,
          )
              ]),
            ),
        ));
  }
}
