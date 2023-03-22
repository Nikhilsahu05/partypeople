// ignore_for_file: unnecessary_overrides, unused_local_variable, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';

enum SingingCharacter { male, female, other }

class AddProfileController extends GetxController {
  //TODO: Implement AddProfileController

  //TODO: Implement AddUserProfileController

  final count = 0.obs;
  SingingCharacter gender = SingingCharacter.male;
  var profilePic = ''.obs;
  var startDateController = TextEditingController().obs;
  var name = TextEditingController().obs;
  var mob = TextEditingController().obs;
  var city = ''.obs;
  var cityID = '';
  var email = TextEditingController().obs;
  var genderStatusChange = "male".obs;
  var uniqueId = ''.obs;

  var isNameEmpty = false.obs;
  var isEmailEmpty = false.obs;
  var startDate = 'Select Date'.obs;

  var isChanSomeDataChange = false.obs;

  var cityList = [
    {
      "id": "1",
      "name": "delhi",
      "image": "fd",
      "latitude": "28.644800",
      "longitude": "77.216721",
      "is_popular": "1"
    },
    {
      "id": "2",
      "name": "indore",
      "image": "d",
      "latitude": "22.7196",
      "longitude": "75.8577",
      "is_popular": "1"
    },
    {
      "id": "3",
      "name": "jabalpur",
      "image": "d",
      "latitude": "23.1815",
      "longitude": "79.9864",
      "is_popular": "1"
    },
    {
      "id": "4",
      "name": "bhopal",
      "image": "ds",
      "latitude": "23.2599",
      "longitude": "77.4126",
      "is_popular": "0"
    }
  ];

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    try {
      name.value.text = data['full_name'] ?? '';
      email.value.text = data['email'] ?? '';
      // uniqueId.value = data['uniqueId'];
      profilePic.value = data['profile_picture'] ?? '';
    } catch (e) {
      print(e);
    }
    //city.value = data['city'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
  var partyStatusChange = "".obs;

  getStartDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    print('Time');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2022 - 13),
        firstDate: DateTime.now(),
        lastDate: DateTime(3000));
    if (picked != null && picked != selectedDate) {
      var date = picked.toString().split(" ");
      var date1 = date[0].split("-");
      var date2 = "${date1[2]}-${date1[1]}-${date1[0]}";
      startDateController.value.text = date2;
      startDate.value = date2;
      isChanSomeDataChange.value = true;
    }
  }

  SingingCharacter character = SingingCharacter.male;

  updateProfile() async {
    var headers = {
      'x-access-token': GetStorage().read('token').toString(),
      'Cookie': 'ci_session=972e9866aaf4ca60e49a9a9373d917755592078c'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://manage.partypeople.in/v1/account/edit_profile'));
    request.fields.addAll({
      'full_name': name.value.text,
      'dob': startDate.value.toString(),
      'gender_id': getGender(genderStatusChange.value),
      'city_id': cityID,
      'phone': mob.value.text
    });
    // request.files.add(await http.MultipartFile.fromPath('profile_picture', json[]));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsnData = jsonDecode(await response.stream.bytesToString());
      if (jsnData['status'] == 1) {
        Get.offNamed(Routes.DASHBORD);
      } else {
        Get.snackbar("Hy", jsnData['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            borderRadius: 10,
            margin: EdgeInsets.all(10),
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ));
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getGender(String gender) {
    switch (gender) {
      case 'male':
        return '1';
      case 'female':
        return '2';
      case 'other':
        return '3';
    }
  }

  Future<void> uplodeImage(XFile? img) async {
    if (img != null) {
      var url = 'http://52.66.136.236/index.php/api/Profile/upload_profile_pic';
    }

    onDataChange(BuildContext context) {
      var alertDialog = AlertDialog(
        title: Text("Do you want to save the changes"),
        actions: <Widget>[
          TextButton(
            child: Text("Yes"),
            onPressed: () async {
              await updateProfile();
              Get.back();
              isChanSomeDataChange.value = false;
            },
          ),
          TextButton(
            child: Text("No"),
            onPressed: () {
              Get.offAllNamed(Routes.DASHBORD);
            },
          ),
        ],
      );

      Get.dialog(alertDialog);
    }

    onCamera(BuildContext context) {
      var alertDialog = AlertDialog(
        actions: <Widget>[
          TextButton(
            child: Text("Open Camera"),
            onPressed: () async {
              XFile? img =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              await uplodeImage(img);
              Get.back();
            },
          ),
          TextButton(
            child: Text("Sellect from Gallery"),
            onPressed: () async {
              XFile? img =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              await uplodeImage(img);
              Get.back();
            },
          ),
        ],
      );

      Get.dialog(alertDialog);
    }
  }
}
