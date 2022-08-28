import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/city_wise_party_controller.dart';

class CityWisePartyView extends GetView<CityWisePartyController> {
  const CityWisePartyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CityWisePartyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CityWisePartyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
