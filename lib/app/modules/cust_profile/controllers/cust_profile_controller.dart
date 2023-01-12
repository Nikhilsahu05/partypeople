import 'dart:convert';
import 'package:dio/src/form_data.dart' as frm;
import 'package:dio/src/multipart_file.dart' as multFile;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../routes/app_pages.dart';
import '../../addProfile/controllers/add_profile_controller.dart';

//The name 'MultipartFile' is defined in the libraries 'package:dio/src/multipart_file.dart (via package:dio/dio.dart)' and 'package:get/get_connect/http/src/multipart/multipart_file.dart'.
//Try using 'as prefix' for one of the import directives, or hiding the name from all but one of the imports.
class CustProfileController extends GetxController {
  //TODO: Implement CustProfileController

  final count = 0.obs;
  XFile? img;
  SingingCharacter gender = SingingCharacter.male;
  var profilePic = ''.obs;
  var startDateController = TextEditingController().obs;
  var name = TextEditingController().obs;
  var mob = TextEditingController().obs;
  var city = ''.obs;
  var cityID = ''.obs;
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

  void returnCity(String cityIdstring) {
    if (cityIdstring.isEmpty) {
      return;
    }
    // cityID.value = cityId;
    for (var element in cityList) {
      if (element['name'] == cityIdstring.toLowerCase()) {
        city.value = element['name']!;
        cityID.value = element['id']!;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;

    try {
      name.value.text = data['full_name'] ?? '';
      email.value.text = data['email'] ?? '';
      uniqueId.value = data['uniqueId'];
      profilePic.value = data['profile_picture'] ?? '';
      returnCity(data['city_id']);
    } catch (e) {
      print(e);
    }
    try {
      getProfile();
    } catch (e) {}

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
        firstDate: DateTime(1900),
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
    // ignore: unused_local_variable
    if (img != null) {
      var formData = frm.FormData.fromMap({
        'profile_picture':
            await multFile.MultipartFile.fromFile(img!.path, filename: 'image'),
      });
    }

    var headers = {
      'x-access-token': GetStorage().read('token').toString(),
      'Cookie': 'ci_session=972e9866aaf4ca60e49a9a9373d917755592078c'
    };
    var response = await Dio()
        .post('https://manage.partypeople.in/v1/account/edit_profile',
            data: frm.FormData.fromMap({
              'full_name': name.value.text,
              'dob': startDate.value.toString(),
              'gender_id': getGender(genderStatusChange.value),
              'city_id': cityID.value,
              'phone': mob.value.text
            }),
            options: Options(
              headers: headers,
            ));

    if (response.statusCode == 200) {
      var data = response.data;
      var jsnData = data;
      if (jsnData['status'] == 1) {
        Get.snackbar("Hy", jsnData['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            borderRadius: 10,
            margin: EdgeInsets.all(10),
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ));
        Get.offAllNamed(Routes.DASHBORD,arguments: data);
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
      // print(response.re);
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
      var headers = {
        'x-access-token': GetStorage().read('token').toString(),
        'Cookie': 'ci_session=972e9866aaf4ca60e49a9a9373d917755592078c'
      };
      var formData = frm.FormData.fromMap({
        'profile_picture': await multFile.MultipartFile.fromFile(img.path,
            filename: img.path.split('/').last),
      });
      var response = await Dio().post(
          'https://manage.partypeople.in/v1/account/change_profile_picture',
          data: formData,
          options: Options(headers: headers));

      // if (response.data[''] == 1) {
      //   var data = await response.data;
      //   var jsnData = jsonDecode(data);
      //   if (jsnData['status'] == 1) {
      // Get.offNamed(Routes.DASHBORD);
      Get.snackbar(
        "Hy",
        response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        borderRadius: 10,
        margin: EdgeInsets.all(10),
      );
      //getProfile();
      // } else {
      //   Get.snackbar("Hy", jsnData['message'],
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.red,
      //       borderRadius: 10,
      //       margin: EdgeInsets.all(10),
      //       icon: Icon(
      //         Icons.error,
      //         color: Colors.white,
      //       ));
      // }
    } else {
      //  print(response.reasonPhrase);
    }

    // onDataChange(BuildContext context) {
    //   var alertDialog = AlertDialog(
    //     title: Text("Do you want to save the changes"),
    //     actions: <Widget>[
    //       TextButton(
    //         child: Text("Yes"),
    //         onPressed: () async {
    //           await updateProfile();
    //           Get.back();
    //           isChanSomeDataChange.value = false;
    //         },
    //       ),
    //       TextButton(
    //         child: Text("No"),
    //         onPressed: () {
    //           Get.offAllNamed(Routes.DASHBORD);
    //         },
    //       ),
    //     ],
    //   );

    //   Get.dialog(alertDialog);
    // }
  }

  void onCamera(BuildContext context) {
    var alertDialog = AlertDialog(
      actions: <Widget>[
        TextButton(
          child: Text("Open Camera"),
          onPressed: () async {
            img = await ImagePicker().pickImage(source: ImageSource.camera);
            uplodeImage(img);
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
            getProfile();
          },
        ),
      ],
    );

    Get.dialog(alertDialog);
  }

  void getProfile() async {
    var headers = {
      'x-access-token': GetStorage().read('token').toString(),
      'Cookie': 'ci_session=7b585fc89d2d80b7dc4f04611db79a7f621ad8ce'
    };

    var response = await Dio().get(
        'https://manage.partypeople.in/v1/account/get_profile',
        options: Options(headers: headers));

    if (response.statusCode == 200) {
      var dataString = response.data;
      var data = dataString;

      if (data['status'] == 1) {
        profilePic.value = data['data']['profile_picture'];
        debugPrint(profilePic.value);
        name.value.text = data['data']['full_name'];
        email.value.text = data['data']['email'];
        mob.value.text = data['data']['phone'];
        startDate.value = data['data']['dob'];
        startDateController.value.text = data['data']['dob'];
        returnCity(data['data']['city']);
      } else {
        //print(response.reasonPhrase);
      }
    }
  }
}
