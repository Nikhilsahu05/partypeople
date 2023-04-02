import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pertypeople/app/modules/global_header_id_controller.dart';

import '../../../routes/app_pages.dart';
import '../../GooglePlacesAutocomplete/views/myapp.dart';
import '../../addIndividualEvent/controllers/add_individual_event_controller.dart';

class AddOrganizationsEvent2Controller extends GetxController {
  //TODO: Implement AddOrganizationsEvent2Controller

  var isComplet = false.obs;
  var isLoading = false.obs;
  RxList selectedAmenities = [].obs;
  static final count = false.obs;
  static var address = "";

  var date = TextEditingController();
  var mobileNumber = TextEditingController();
  final title = TextEditingController();
  var name = '';
  var genderList = [];
  RxString timeline = ''.obs;
  final description = TextEditingController();
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  var location = TextEditingController();
  var latLng = LatLng(0, 0);
  final image = TextEditingController();
  final partyType = "Music event".obs;
  final gender = TextEditingController();
  final startPeopleAge = TextEditingController();
  final endPeopleAge = TextEditingController();
  final peopleLimit = TextEditingController();
  final partyStatus = TextEditingController();
  final ladiesPrice = TextEditingController();
  final stagPrice = TextEditingController();
  final couplesPrice = TextEditingController();
  final othersPrice = TextEditingController();
  final offersText = TextEditingController();
  RxBool isPopular = false.obs;
  SingingCharacter character = SingingCharacter.Full;
  var partyStatusChange = "".obs;

  var getPrefiledData;
  RxBool isEditable = false.obs;

  getEndDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    print('Time');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startingDate,
        firstDate: startingDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      var date = picked.toString().split(" ");
      var date1 = date[0].split("-");
      var date2 = "${date1[2]}-${date1[1]}-${date1[0]}";
      endDate.text = date2;
    }
  }

  var startingDate;

  getStartDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    print('Time');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      print('picked Date : ${picked}');
      startingDate = picked;
      var date = picked.toString().split(" ");
      var date1 = date[0].split("-");
      var date2 = "${date1[2]}-${date1[1]}-${date1[0]}";
      startDate.text = date2;
    }
  }

  getStartTime(BuildContext context) async {
    final TimeOfDay? result = await showTimePicker(
        context: context, initialTime: TimeOfDay.now() /*...*/);
    if (result != null) {
      print(result.period); // DayPeriod.pm or DayPeriod.am
      print(result.hour);
      print(result.minute);
      var hour = result.hour.toString().length == 1
          ? '0${result.hour.toString()}'
          : result.hour.toString();
      var min = result.minute.toString().length == 1
          ? '0${result.minute.toString()}'
          : result.minute.toString();
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
      var hour = result.hour.toString().length == 1
          ? '0${result.hour.toString()}'
          : result.hour.toString();
      var min = result.minute.toString().length == 1
          ? '0${result.minute.toString()}'
          : result.minute.toString();
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

  var fullEditableData;
  GlobalHeaderIDController globalHeaderIDController =
      Get.put(GlobalHeaderIDController());

  sendEditParty() async {
    isLoading.value = true;
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=f72b54d682c45ebf19fcc0fd54cef39508588d0c'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://manage.partypeople.in/v1/party/update'));
    request.fields.addAll({
      'title': title.text,
      'description': description.text,
      'start_date': startDate.text,
      'end_date': endDate.text,
      'start_time': startTime.text,
      'end_time': endTime.text,
      'latitude': latLng.latitude.toString(),
      'longitude': latLng.longitude.toString(),
      'type': getPertyType(partyType.value),
      'gender': genderList.toString().replaceAll('[', ' ').replaceAll(']', ''),
      'start_age': startPeopleAge.text,
      'end_age': endPeopleAge.text,
      'person_limit': peopleLimit.text,
      'status': '1',
      'organization_id': '1',
      'party_amenitie_id':
          selectedAmenities.toString().replaceAll('[', ' ').replaceAll(']', ''),
      "phone_number": mobileNumber.text,
      'offers': offersText.text,
      'ladies': ladiesPrice.text,
      'stag': stagPrice.text,
      'couples': couplesPrice.text,
      'others': othersPrice.text,
      'party_id': '${getPrefiledData['id']}',
      'cover_photo': timeline.value
      // 'organization_id': '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      isLoading.value = false;

      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      if (json['status'] == 1) {
        AddIndividualEventController.picture?.delete();
        AddIndividualEventController.picture = null;
        Get.snackbar("", "Party is under review.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
        Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
      } else {
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

  sendRequst() async {
    isLoading.value = true;
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=f72b54d682c45ebf19fcc0fd54cef39508588d0c'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://manage.partypeople.in/v1/party/add'));
    request.fields.addAll({
      'title': title.text,
      'description': description.text,
      'start_date': startDate.text,
      'end_date': endDate.text,
      'start_time': startTime.text,
      'end_time': endTime.text,
      'latitude': latLng.latitude.toString(),
      'longitude': latLng.longitude.toString(),
      'type': getPertyType(partyType.value),
      'gender': genderList.toString(),
      'start_age': startPeopleAge.text,
      'end_age': endPeopleAge.text, "phone_number": mobileNumber.text,

      'person_limit': peopleLimit.text,
      'status': character.name,
      'organization_id': '1',
      'party_amenitie_id':
          selectedAmenities.toString().replaceAll('[', ' ').replaceAll(']', ''),
      'offers': offersText.text,
      'ladies': ladiesPrice.text,
      'stag': stagPrice.text,
      'couples': couplesPrice.text,
      'others': othersPrice.text,
      'cover_photo': timeline.value
      // 'organization_id': '1'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      isLoading.value = false;
      var json = jsonDecode(await response.stream.bytesToString());
      print(json);
      if (json['status'] == 1) {
        AddIndividualEventController.picture?.delete();
        AddIndividualEventController.picture = null;
        Get.snackbar("", "Party is under review.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
        Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
      } else {
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
