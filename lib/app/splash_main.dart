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
  // Given an array of strings strs, group the anagrams together. You can return the answer in any order.
//
// An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.
//
// Example 1:
// Input: strs = ["eat","tea","tan","ate","nat","bat"]
// Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
//
// Example 2:
// Input: strs = [""]
// Output: [[""]]
//
// Example 3:
// Input: strs = ["a"]
// Output: [["a"]]

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, AppPages.INITIAL, (route) => false);
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
