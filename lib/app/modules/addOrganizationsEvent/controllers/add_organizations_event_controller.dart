import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../GooglePlacesAutocomplete/views/myapp.dart';
import '../../addIndividualEvent/controllers/add_individual_event_controller.dart';
import 'package:http/http.dart' as http;

import 'GetCitys.dart';

class AddOrganizationsEventController extends GetxController {
  //TODO: Implement AddOrganizationsEventController

  final count = 0.obs;
  final description = TextEditingController();
  final name = TextEditingController();
  final location = TextEditingController();
  var orgType = "Music event".obs;
  var city = "".obs;
  var cityKey = "".obs;
  var citySelected = [].obs;
  var citySelectedKey = [].obs;
  @override
  void onInit() {
    super.onInit();
    getCitys();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  GetCitys? getCityList;

  List<String> _kOptions = <String>[];

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
    // print("data $address");
    location.text = AddIndividualEventController.address;
  }

  void addBranch(var context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Add Branch"),
      content: Obx(() => city.value != null
          ? DropdownButton<String>(
              //value: controller.partyType.value,
              value: city.value.isEmpty ? null : city.value,
              hint: Text('Select your Search Branch',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 14,
                    color: const Color(0xff035DC4),
                  )),
              icon: const Icon(Icons.arrow_downward, color: Color(0xff035DC4)),
              style: const TextStyle(color: Color(0xff035DC4)),
              isExpanded: true,
              underline: Container(
                height: 1,
                width: Get.width,
                color: const Color(0xff035DC4),
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  city.value = newValue;
                  if (!citySelected.contains(_kOptions.indexOf(newValue))) {
                    citySelectedKey.add(_kOptions.indexOf(newValue));
                  }
                }
              },
              items: _kOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        color: const Color(0xff035DC4),
                      )),
                );
              }).toList())
          : Text("Please select city")),
      actions: <Widget>[
        TextButton(
          child: Text("Add"),
          onPressed: () {
            print(description.text);
            citySelected.add(city.value);
            city.value = "";

            Get.back();
          },
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  getCitys() async {
    var headers = {
      'x-access-token':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNjI0MjcyMzY5fQ.kMZ3IkYt1Bmqn5sylRtU0CZolo24izxlbHV_kFkbALI',
      'Cookie': 'ci_session=bb484ee68f2155ac47fcb20c35e31310064b7370'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://manage.partypeople.in/v1/party/cities'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      getCityList = getCitysFromJson(await response.stream.bytesToString());
      _kOptions = getCityList!.data.map((e) => e.name).toList();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> addOrgnition() async {
    if (citySelected.isEmpty) {
      Get.snackbar("Hy", "Please select city",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
      return;
    }
    if (AddIndividualEventController.latLng!.latitude.toString() ==
        0.0.toString()) {
      Get.snackbar("Hy", "Please select location",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
      return;
    }

    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=53748e98d26cf6811eb0a53be37158bf0cbe5b4b'
    };

    var request = http.MultipartRequest('POST',
        Uri.parse('https://manage.partypeople.in/v1/party/add_organization'));
    request.fields.addAll({
      'city_id': citySelectedKey.toString(),
      'description': description.text,
      'name': name.text,
      'latitude': AddIndividualEventController.latLng!.latitude.toString(),
      'longitude': AddIndividualEventController.latLng!.longitude.toString(),
      'type': '1',
    });

    request.headers.addAll(headers);
    print(request.fields);
    http.StreamedResponse response = await request.send();
    // print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      print(jsonResponse);
      //jsonResponse = json.decode(await response.stream.bytesToString());
      if (jsonResponse['status'] == 1) {
        var data = {
          'city_id': citySelectedKey.toString(),
          'description': description.text,
          'name': name.text,
          'latitude': AddIndividualEventController.latLng!.latitude.toString(),
          'longitude':
              AddIndividualEventController.latLng!.longitude.toString(),
          'type': orgType.value.toString(),
        };
        Get.offNamed('/organization-profile', arguments: data);
      } else {
        Get.snackbar("Hy", jsonResponse['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
      }
      print(jsonResponse);
    } else {
      print(response.reasonPhrase);
    }
  }
}
