import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/routes/app_pages.dart';

class SplashScreenMain extends StatefulWidget {
  const SplashScreenMain({Key? key}) : super(key: key);

  @override
  State<SplashScreenMain> createState() => _SplashScreenMainState();
}

class _SplashScreenMainState extends State<SplashScreenMain> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          height: Get.height,
          width: Get.width,
          child: Image.asset(
            'assets/iPhone X, XS, 11 Pro – 5.png',
            fit: BoxFit.fill,
          )),
    );
  }
}
