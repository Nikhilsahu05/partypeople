import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrganizationProfileNewController extends GetxController {
  //TODO: Implement OrganizationProfileNewController
  RxString notificationCount = '0'.obs;
  RxString likes = '0'.obs;
  RxString views = '0'.obs;
  RxString bluetick = '0'.obs;
  RxString going = '0'.obs;
  var count = 0.obs;
  RxString token = ''.obs;
  RxString organisationName = 'Organisation Name'.obs;
  RxString organisationRating = '0'.obs;
  RxString partyStartTime = ''.obs;
  RxString partyDesc = ''.obs;
  RxString popularPartyVerification = '0'.obs;
  RxString organisationVerification = '0'.obs;
  RxString partyLike = ''.obs;
  RxString partyView = ''.obs;
  RxString partyOngoing = ''.obs;
  RxString timelinePic = ''.obs;
  RxString organizationDesc = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString circularDP = ''.obs;
  var amenities;

  RxInt lengthOfTodayParties = 0.obs;
  RxInt lengthOfTommParties = 0.obs;
  RxInt lengthOfUpcomingParties = 0.obs;
  var jsonPartyOgranisationDataToday;

  var jsonPartyOgranisationDataTomm;

  var jsonPartyPopularData;

  var jsonPartyOgranisationDataUpcomming;

  RxInt popularPartyLength = 0.obs;
  RxBool isLoading = false.obs;
  var fullOrganizationData;

  // if (notificationCount.value == '0') {
  //   print("Dont sing");
  // } else {
  //   AssetsAudioPlayer.newPlayer().open(
  //     Audio("assets/Notification - Notification.mp3"),
  //     autoStart: true,
  //     showNotification: true,
  //   );
  //   print("Sing ringtone");
  // }

  ///TODO:Create A Separate List For Popular Parties

  getAPIOverview() async {
    isLoading.value = true;
    http.Response response = await http.post(
      Uri.parse('https://manage.partypeople.in/v1/party/organization_details'),
      headers: {'x-access-token': '${GetStorage().read("token")}'},
    );
    print("response of Organization ${jsonDecode(response.body)['data'][0]}");

    fullOrganizationData = jsonDecode(response.body)['data'][0];
    notificationCount.value =
        jsonDecode(response.body)['notification_count'].toString();

    timelinePic.value = jsonDecode(response.body)['data'][0]['timeline_pic'];
    circularDP.value = jsonDecode(response.body)['data'][0]['profile_pic'];
    likes.value = jsonDecode(response.body)['data'][0]['like'];
    views.value = jsonDecode(response.body)['data'][0]['view'];
    going.value = jsonDecode(response.body)['data'][0]['ongoing'];
    organisationName.value = jsonDecode(response.body)['data'][0]['name'];
    bluetick.value = jsonDecode(response.body)['data'][0]['bluetick_status'];
    popularPartyVerification.value =
        jsonDecode(response.body)['data'][0]['profile_pic_approval_status'];
    organisationVerification.value =
        jsonDecode(response.body)['data'][0]['approval_status'];
    organisationRating.value = jsonDecode(response.body)['data'][0]['rating'];
    organizationDesc.value =
        jsonDecode(response.body)['data'][0]['description'];

    print('printing ratings of organisation :: ${jsonDecode(response.body)}');

    isLoading.value = false;
  }

  getOrganisationDetailsToday() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/get_user_organization_party_by_id'),
        body: {
          'organization_id': '1',
          'status': '1'
        },
        headers: {
          'x-access-token': '${GetStorage().read("token")}',
        });
    print('Test ${response.body}');

    var jsonDecodedData = jsonDecode(response.body);
    if (jsonDecodedData['data'] != null) {
      if (jsonDecodedData['data'].length != 0) {
        jsonPartyOgranisationDataToday = jsonDecodedData['data'];
        lengthOfTodayParties.value = jsonDecodedData['data'].length;

        print('************ $lengthOfTodayParties');
        for (var i = 0; i < lengthOfTodayParties.value; i++) {
          if (jsonPartyOgranisationDataToday[i]['papular_status'] == "1") {
            jsonPartyPopularData = jsonPartyOgranisationDataToday;
            popularPartyLength.value = jsonDecodedData['data'].length;
          }
        }
      }
    }
  }

  getOrganisationDetailsTom() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/get_user_organization_party_by_id'),
        body: {
          'organization_id': '1',
          'status': '2'
        },
        headers: {
          'x-access-token': '${GetStorage().read("token")}',
        });
    print(response.body);
    var jsonDecodedData = jsonDecode(response.body);
    if (jsonDecodedData['data'] != null) {
      print(jsonDecodedData['data'].length);

      jsonPartyOgranisationDataTomm = jsonDecodedData['data'];
      lengthOfTommParties.value = jsonDecodedData['data'].length;
    }
    for (var i = 0; i < lengthOfTommParties.value; i++) {
      if (jsonPartyOgranisationDataTomm[i]['papular_status'] == "1") {
        jsonPartyPopularData = jsonPartyOgranisationDataTomm;
        popularPartyLength.value = jsonDecodedData['data'].length;
      }
    }
  }

  getOrganisationDetailsUpcomming() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/get_user_organization_party_by_id'),
        body: {
          'organization_id': '1',
          'status': '3'
        },
        headers: {
          'x-access-token': '${GetStorage().read("token")}',
        });
    print(response.body);

    var jsonDecodedData = jsonDecode(response.body);
    if (jsonDecodedData['data'] != null) {
      jsonPartyOgranisationDataUpcomming = jsonDecodedData['data'];
      lengthOfUpcomingParties.value = jsonDecodedData['data'].length;
    }
    for (var i = 0; i < lengthOfUpcomingParties.value; i++) {
      if (jsonPartyOgranisationDataUpcomming[i]['papular_status'] == "1") {
        jsonPartyPopularData = jsonPartyOgranisationDataUpcomming;
        popularPartyLength.value = jsonDecodedData['data'].length;
      }
    }
  }

  @override
  void onInit() {
    getAPIOverview();
    getOrganisationDetailsToday();
    getOrganisationDetailsUpcomming();
    getOrganisationDetailsTom();
    // Timer.periodic(Duration(seconds: 5), (timer) async {
    //   await getAPIOverview();
    //   await getOrganisationDetailsToday();
    //   await getOrganisationDetailsUpcomming();
    //   await getOrganisationDetailsTom();
    // });

    super.onInit();
  }
}
