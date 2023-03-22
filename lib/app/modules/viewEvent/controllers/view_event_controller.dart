// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ViewEventController extends GetxController {
  //TODO: Implement ViewEventController

  final count = 0.obs;
  var event;

  @override
  void onInit() {
    super.onInit();
    event = Get.arguments;
    print(event!.startDate);
  }

  void increment() => count.value++;

  void joinParty(String id) async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      'Cookie': 'ci_session=bd8e12e1b0c97da163063921d8c456f66a0913a5'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://manage.partypeople.in/v1/party/join_party'));
    request.fields.addAll({'party_id': id});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(await response.stream.bytesToString());
      if (data['status'] == '1') {
        Get.snackbar('Success', 'You have joined the party',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            borderRadius: 10,
            margin: EdgeInsets.all(10),
            borderColor: Colors.green,
            borderWidth: 2,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ));
      } else {
        Get.snackbar('Error', data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            borderRadius: 10,
            borderWidth: 2,
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ));
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
