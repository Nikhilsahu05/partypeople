import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../GooglePlacesAutocomplete/views/myapp.dart';
import '../views/add_individual_event_view.dart';

enum SingingCharacter { Full, Awaited }

class AddIndividualEventController extends GetxController {
  //TODO: Implement AddIndividualEventController

  var isComplet = false.obs;
  var isLoading = false.obs;

  static final count = 0.obs;
  static var address = "";
  static File? picture;
  var date = TextEditingController();
  final title = TextEditingController();
  final description = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final location = TextEditingController();
  static LatLng? latLng = LatLng(0, 0);
  final image = TextEditingController();
  final partyType = "Music event".obs;
  final gender = TextEditingController();
  final startPeopleAge = TextEditingController();
  final endPeopleAge = TextEditingController();
  final peopleLimit = TextEditingController();
  final partyStatus = TextEditingController();
  SingingCharacter character = SingingCharacter.Full;
  var partyStatusChange = "".obs;
  var genderList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (picture != null) {
      picture?.delete();
      picture = null;
    }
  }

  getEndDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    print('Time');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      //get date in format dd/mm/yyyy
      var date = picked.toString().split(" ");
      var date1 = date[0].split("-");
      var date2 = "${date1[2]}-${date1[1]}-${date1[0]}";
      endDate.text = date2;

      //reverse string

    }
  }

  getStartDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    print('Time');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      //reverse the date
      var date = picked.toString().split(" ");
      var date1 = date[0].split("-");
      var date2 = "${date1[2]}-${date1[1]}-${date1[0]}";
      startDate.text = date2;
    }
  }

  getStartTime(BuildContext context) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      print(result.period); // DayPeriod.pm or DayPeriod.am
      print(result.hour);
      print(result.minute);
     var hour = result.hour.toString().length == 1 ?'0${result.hour.toString()}':result.hour.toString();
        var min =  result.minute.toString().length == 1 ?'0${result.minute.toString()}':result.minute.toString();
      startTime.text = "$hour:$min";
    }
  }

  getEndTime(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
        context: context, initialTime: TimeOfDay.now() /*...*/);
    if (result != null) {
      print(result.period); // DayPeriod.pm or DayPeriod.am
      print(result.hour);
      print(result.minute);
       var hour = result.hour.toString().length == 1 ?'0${result.hour.toString()}':result.hour.toString();
        var min =  result.minute.toString().length == 1 ?'0${result.minute.toString()}':result.minute.toString();
      endTime.text = "$hour:$min";

      
    }
  }

  Future<void> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Hy", "Location permission denied",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Hy", "Location permission denied",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Get.to(MyApp());
    print("data $address");
    location.text = address;
  }

  sendRequst() async {
    isLoading.value = true;
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=f72b54d682c45ebf19fcc0fd54cef39508588d0c'
    };
    print("file size ${picture?.lengthSync()}");
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://manage.partypeople.in/v1/party/add'));
    request.fields.addAll({
      'title': title.text,
      'description': description.text,
      'start_date': startDate.text,
      'end_date': endDate.text,
      'start_time': startTime.text,
      'end_time': endTime.text,
      'latitude': latLng!.latitude.toString(),
      'longitude': latLng!.longitude.toString(),
      'type': getPertyType(partyType.value),
      'gender': genderList.toString(),
      'start_age': startPeopleAge.text,
      'end_age': endPeopleAge.text,
      'person_limit': peopleLimit.text,
      'status': character.name,
      'organization_id': '0'

      // 'organization_id': '1'
    });

    if (picture != null) {
      //var pic = await http.MultipartFile.fromPath('cover_photo',picture!.path);
      //add multipart to request
      // request.files.add(pic);
      request.files
          .add(await http.MultipartFile.fromPath('cover_photo', picture!.path));
    }
    request.headers.addAll(headers);
    print(request.fields);
    print(request.files);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading.value = false;

      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      if (json['status'] == 1) {
        picture?.delete();
        picture = null;
        Get.snackbar("", "Party created successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
        Get.offAllNamed('/dashbord');
      } else {
        //  picture = null;
        Get.snackbar('Hy', json['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
        // Get.offAllNamed('/dashbord');
      }
    } else {
      //print(response.statusCode);
      isLoading.value = false;
      Get.snackbar(response.reasonPhrase!,
          'Something went wrong Status Code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
      // print(response.headers);
    }
  }

    getPertyType(String gender) {
    switch (gender) {
      case 'Music event':
        return '1';
      case 'Light show':
        return '2';
      case 'Neon party':
        return '3';
    }
  }
}
