import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/city_list_controller.dart';

class CityListView extends GetView<CityListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CityListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CityListView is working',
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
    );
  }
}
