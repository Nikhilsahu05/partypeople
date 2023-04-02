// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pertypeople/app/modules/global_header_id_controller.dart';

import '../../../routes/app_pages.dart';
import 'GetCitys.dart';

class AddOrganizationsEventController extends GetxController {
  //TODO: Implement AddOrganizationsEventController
  RxBool isLoading = false.obs;
  final count = 0.obs;
  final description = TextEditingController();
  final name = TextEditingController();
  TextEditingController location = TextEditingController();
  var selectedLocation;
  TextEditingController city = TextEditingController();
  var cityKey = "".obs;
  var citySelected = [].obs;
  var citySelectedKey = [].obs;

  final branches = TextEditingController();
  RxString timeline = ''.obs;
  RxString profile = ''.obs;

  var latitude;
  RxBool isEditable = false.obs;
  var longitude;
  Set<Marker> markers = {};
  RxString organisationID = ''.obs;
  var fullOrganisationJsonData;

  getAPIOverview() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/organization_details'),
        headers: {
          'x-access-token': '${GetStorage().read("token")}',
        });
    print("response of Organization ${response.body}");
    organisationID.value = jsonDecode(response.body)['data'][0]['id'];
    print(
        'Getting ID Of Organisation ::: ${jsonDecode(response.body)['data'][0]['id']}');
    print(organisationID.value);
    print("Print for test");
    fullOrganisationJsonData = jsonDecode(response.body);
    if (jsonDecode(response.body)['data'] != null) {
      name.text = jsonDecode(response.body)['data'][0]['name'];

      location.text = jsonDecode(response.body)['data'][0]['city_id'];
      description.text = jsonDecode(response.body)['data'][0]['description'];
      timeline.value =
          "${jsonDecode(response.body)['data'][0]['timeline_pic']}";
      profile.value = "${jsonDecode(response.body)['data'][0]['profile_pic']}";
      update();
      refresh();
    }

    update();
    refresh();
  }

  @override
  void onInit() {
    getAPIOverview();

    getCitys();
    onMapCreated;
    getCurrentLocation();
    super.onInit();
  }

  GetCitys? getCityList;

  // ---- CUSTOME MAP SCREEN

  late GoogleMapController? mapController;
  late LatLng center;
  Position? currentPosition;
  String? currentAddress;
  RxList selectedAmenitiesListID = [].obs;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      center = LatLng(position.latitude, position.longitude);
      latitude = position.latitude;
      longitude = position.longitude;
      markers.add(Marker(
          markerId: MarkerId('Home'),
          position: LatLng(position.latitude, position.longitude)));
      update();

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

      Placemark place = placemarks[0];

      currentAddress =
          "${place.street}, ${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
      print(currentAddress);
      // getcurrentaddressforUI = currentAddress;
      update();
    } catch (e) {
      print(e);
    }
  }

  getCitys() async {
    var headers = {
      'x-access-token': '${GetStorage().read("token")}',
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://manage.partypeople.in/v1/party/cities'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      getCityList = getCitysFromJson(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updateOrganisation() async {
    isLoading.value = true;

    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://manage.partypeople.in/v1/party/update_organization'));
    request.fields.addAll({
      'organization_amenitie_id': selectedAmenitiesListID
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', ''),
      'city_id': location.text,
      'description': description.text,
      'branch': branches.text,
      'name': name.text.toUpperCase(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'organization_id': organisationID.value,
      'type': '1',
      'profile_pic': profile.value,
      'timeline_pic': timeline.value,
    });

    try {
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse['message'] == 'Organization Update Successfully.') {
          Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
        }
        print(jsonResponse);
      } else {
        Get.offAllNamed((Routes.ORGANIZATION_PROFILE_NEW));
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("API call error: ${e.toString()}");
      // handle the error here
    }

    isLoading.value = false;
    update();
  }

  GlobalHeaderIDController globalHeaderIDController =
      Get.put(GlobalHeaderIDController());

  Future<void> addOrgnition() async {
    print("Printing profile picture and timeline picture");

    isLoading.value = true;
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      // 'Cookie': 'ci_session=53748e98d26cf6811eb0a53be37158bf0cbe5b4b'
    };

    var request = http.MultipartRequest('POST',
        Uri.parse('https://manage.partypeople.in/v1/party/add_organization'));
    request.fields.addAll({
      'organization_amenitie_id': selectedAmenitiesListID
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', ''),
      'city_id': location.text,
      'description': description.text,
      'branch': branches.text,
      'name': name.text.toUpperCase(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'type': '1',
      'profile_pic': '$profile',
      'timeline_pic': '$timeline',
    });

    request.headers.addAll(headers);

    print("Pending Fields :${request.fields}");
    http.StreamedResponse response = await request.send();

    update();
    // print(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      print(jsonResponse);
      isLoading.value = false;
      if (jsonResponse['message'] == 'Organization Create Successfully.') {
        Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
      } else if (jsonResponse['message'] == 'Organization Already Created.') {
        Get.offAllNamed(Routes.ORGANIZATION_PROFILE_NEW);
      }

      //jsonResponse = json.decode(await response.stream.bytesToString());
      print(jsonResponse);
    } else {
      print(response.reasonPhrase);
    }
  }
}
