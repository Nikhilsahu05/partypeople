// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'getOrgData.dart';
import 'getindividualData.dart';

class DashbordController extends GetxController {
  GetindividualData? getindividualData;
  GetOrgData? getGrupData;
  List<Datum>? toDayPertyIndividual = [];
  List<Datum>? toDayPertyOrgination = [];
  List<Datum>? tommarowPertyIndividual = [];
  List<Datum>? tommarowPertyOrgination = [];
  var getCitys = [].obs;
  var nearByUser = [].obs;
  var data;

  var isindividualSelected = true.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // getUserIndData();
    getUserOrgData();
    getTodayIndParty();
    getTodayOrgParty();
    getTommarowOrgPrty();
    getTommarowIndPrty();
    getAllCitys();
    nearByUsers();
    getProfile();
    data = Get.arguments;
    // getToommarowPerty();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

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
        GetStorage().write('profile_picture', data['data']['profile_picture']);
        GetStorage().write('full_name', data['data']['full_name']);
      } else {
        //print(response.reasonPhrase);
      }
    }
  }

  // getUserIndData() async {
  //   var headers = {
  //     'x-access-token': GetStorage().read("token").toString(),
  //     //'Cookie': 'ci_session=f72b54d682c45ebf19fcc0fd54cef39508588d0c'
  //   };
  //   var request = http.MultipartRequest(
  //       'GET',
  //       Uri.parse(
  //           'https://manage.partypeople.in/v1/party/get_user_all_individual_party'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   var json = await response.stream.bytesToString();
  //   var jsondata = jsonDecode(json);
  //   if (jsondata['status'] == 1) {
  //     getindividualData = getindividualDataFromJson(json);
  //     count.value = getindividualData!.data.length;
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  getUserOrgData() async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      //'Cookie': 'ci_session=cf9134a6171e23645d2a6d46c93c34e2284c45c1'
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://manage.partypeople.in/v1/party/get_user_organization_party_by_id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var json = await response.stream.bytesToString();
    print(json);
    var jsondata = jsonDecode(json);
    if (jsondata['status'] == 1) {
      getGrupData = getOrgDataFromJson(json);
      count.value = 67;

      // print(str2);
    } else {
      print(response.reasonPhrase);
    }
  }

  void getAllCitys() async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      'Cookie': 'ci_session=de6d713b333931d25740c249fd67250a24b581f2'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://manage.partypeople.in/v1/party/cities'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // var getCityList = getCitysFromJson(jsonString);
      // getCitys.value = getCityList.data;
    } else {
      print(response.reasonPhrase);
    }
  }

  void nearByUsers({String city = ''}) async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      'Cookie': 'ci_session=de6d713b333931d25740c249fd67250a24b581f2'
    };
    var request = http.Request('POST',
        Uri.parse('https://manage.partypeople.in/v1/home/near_by_users'));
    city.isEmpty
        ? request.bodyFields = {}
        : request.bodyFields = {'city_id': city};

    //request.bodyFields = {};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      nearByUser.value = data['data'];
    } else {
      print(response.reasonPhrase);
    }
  }

  void getTodayOrgParty({String city = ''}) async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      'Content-Type': 'application/x-www-form-urlencoded',
      // 'Cookie': 'ci_session=471ced3dc462db89e201c3312b0bb0c0f9da11ec'
    };

    var request = http.Request('POST',
        Uri.parse('https://manage.partypeople.in/v1/home/get_today_party'));
    city.isEmpty
        ? request.bodyFields = {'offset': '0', 'organisation_id': '1'}
        : request.bodyFields = {
            'offset': '0',
            'organisation_id': '1',
            'city_id': city
          };
    //request.bodyFields = {'offset': '0', 'organisation_id': '1'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();

      var data = getOrgDataFromJson(json);

      //get data whear status is 1
      if (data.data.isNotEmpty) {
        toDayPertyOrgination = data.data;

        count.value = 56;
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  void getTodayIndParty({String city = ''}) async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
      'Content-Type': 'application/x-www-form-urlencoded',
      // 'Cookie': 'ci_session=471ced3dc462db89e201c3312b0bb0c0f9da11ec'
    };
    var request = http.Request('POST',
        Uri.parse('https://manage.partypeople.in/v1/home/get_today_party'));
    city.isEmpty
        ? request.bodyFields = {'offset': '0', 'organisation_id': '0'}
        : request.bodyFields = {
            'offset': '0',
            'organisation_id': '0',
            'city_id': city
          };
    //request.bodyFields = {'offset': '0', 'organisation_id': '0'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();

      var data = getOrgDataFromJson(json);

      //get data whear status is 1

      toDayPertyIndividual = data.data;

      count.value = 56;
    } else {
      print(response.reasonPhrase);
    }
  }

  void getTommarowOrgPrty({String city = ''}) async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
    };
    var request = http.Request('POST',
        Uri.parse('https://manage.partypeople.in/v1/home/get_tomorrow_party'));
    city.isEmpty
        ? request.bodyFields = {'offset': '0', 'organisation': '1'}
        : request.bodyFields = {
            'offset': '0',
            'organisation': '1',
            'city_id': city
          };
    // request.bodyFields = {'offset': '0', 'organisation': '1'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();

      var data = getOrgDataFromJson(json);

      //get data whear status is 1

      tommarowPertyOrgination = data.data;
    } else {
      print(response.reasonPhrase);
    }
  }

  void getTommarowIndPrty({String city = ''}) async {
    var headers = {
      'x-access-token': GetStorage().read("token").toString(),
    };
    var request = http.Request('POST',
        Uri.parse('https://manage.partypeople.in/v1/home/get_tomorrow_party'));
    city.isEmpty
        ? request.bodyFields = {'offset': '0', 'organisation': '0'}
        : request.bodyFields = {
            'offset': '0',
            'organisation': '0',
            'city_id': city
          };
    // request.bodyFields = {'offset': '0', 'organisation': '0'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();

      var data = getOrgDataFromJson(json);

      //get data whear status is 1

      tommarowPertyIndividual = data.data;
    } else {
      print(response.reasonPhrase);
    }
  }

// void getToommarowPerty() async {
//   var headers = {
//     'x-access-token': GetStorage().read("token").toString(),
//     'Content-Type': 'application/x-www-form-urlencoded',
//   };
//   var request = http.Request('POST',
//       Uri.parse('https://manage.partypeople.in/v1/home/get_tomorrow_party'));
//   request.bodyFields = {'offset': '0'};
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     var json = await response.stream.bytesToString();

//     var data = getOrgDataFromJson(json);

//     //get data whear status is 1
//     if (data.data.isNotEmpty) {
//       tommarowPertyOrgination.value = data.data
//           .where((element) => element.organizationId == "1")
//           .toList();
//       tommarowPertyOrgination.value = data.data
//           .where((element) => element.organizationId == "0")
//           .toList();
//       count.value = 98;
//     }
//   } else {
//     print(response.reasonPhrase);
//   }
// }
}
