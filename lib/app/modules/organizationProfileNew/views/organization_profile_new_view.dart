// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison
import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent2/controllers/add_organizations_event2_controller.dart';
import 'package:pertypeople/app/modules/cust_profile/views/cust_profile_view.dart';
import 'package:pertypeople/app/modules/global_header_id_controller.dart';
import 'package:pertypeople/app/modules/organizationProfileNew/controllers/organization_profile_new_controller.dart';
import 'package:pertypeople/app/modules/popular_party_preview.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../routes/app_pages.dart';
import '../../drawer/views/drawer_view.dart';
import '../../notification_screen.dart';

class OrganizationProfileNewView extends StatefulWidget {
  const OrganizationProfileNewView({Key? key}) : super(key: key);

  @override
  State<OrganizationProfileNewView> createState() =>
      _OrganizationProfileNewViewState();
}

class _OrganizationProfileNewViewState
    extends State<OrganizationProfileNewView> {
  GlobalHeaderIDController globalHeaderIDController =
      Get.put(GlobalHeaderIDController());

  // DashbordController dashbordController = Get.put(DashbordController());
  String likes = "0";
  String views = "0";
  String going = "0";
  String token = '';
  String organisationName = "ORGANIZATION NAME";
  String organisationRating = "0";
  String partyStartTime = "";
  String partyDesc = '';
  String popularPartyVerification = '0';
  String organisationVerification = '0';
  String partyLike = '';
  String partyView = '';
  String partyOngoing = '';
  String timelinePic = '';
  String organizationDesc = '';
  String latitude = '';
  String longitude = '';
  String circularDP = '';
  var amenities;
  int lengthOfTodayParties = 0;
  int lengthOfTommParties = 0;
  int lengthOfUpcomingParties = 0;
  var jsonPartyOgranisationDataToday;
  var jsonPartyOgranisationDataTomm;
  var jsonPartyOgranisationDataUpcomming;
  var popularPartyLength = 0;

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
        setState(() {
          jsonPartyOgranisationDataToday = jsonDecodedData['data'];
          lengthOfTodayParties = jsonDecodedData['data'].length;

          print('************ $lengthOfTodayParties');
          for (var i = 0; i < lengthOfTodayParties; i++) {
            if (jsonPartyOgranisationDataToday[i]['papular_status'] == "1") {
              setState(() {
                if (popularPartyLength != null) {
                  popularPartyLength = popularPartyLength + 1;
                  print('Printing premium part length ::: $popularPartyLength');
                }
              });
            }
          }
        });
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
      setState(() {
        jsonPartyOgranisationDataTomm = jsonDecodedData['data'];
        lengthOfTommParties = jsonDecodedData['data'].length;
      });
    }
    for (var i = 0; i < lengthOfTommParties; i++) {
      if (jsonPartyOgranisationDataTomm[i]['papular_status'] == "1") {
        setState(() {
          if (popularPartyLength != null) {
            popularPartyLength = popularPartyLength + 1;
            print('Printing premium part length ::: $popularPartyLength');
          }
        });
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
      setState(() {
        jsonPartyOgranisationDataUpcomming = jsonDecodedData['data'];
        lengthOfUpcomingParties = jsonDecodedData['data'].length;
      });
    }
    for (var i = 0; i < lengthOfUpcomingParties; i++) {
      if (jsonPartyOgranisationDataUpcomming[i]['papular_status'] == "1") {
        setState(() {
          if (popularPartyLength != null) {
            popularPartyLength = popularPartyLength + 1;
            print('Printing premium part length ::: $popularPartyLength');
          }
        });
      }
    }
  }

  bool isLoading = false;
  var fullOrganizationData;
  String bluetick = '0';

  bool isRingtoneOne = false;

  getAPIOverview() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/organization_details'),
        headers: {
          'x-access-token': '${GetStorage().read("token")}',
        });
    print("response of Organization ${jsonDecode(response.body)['data'][0]}");
    setState(() {
      fullOrganizationData = jsonDecode(response.body)['data'][0];
      notificationCount =
          jsonDecode(response.body)['notification_count'].toString();

      if (notificationCount == '0') {
        print("Dont sing");
        setState(() {
          isRingtoneOne = true;
        });
      } else {
        if (isRingtoneOne == true) {
          AssetsAudioPlayer.newPlayer().open(
            Audio("assets/Notification - Notification.mp3"),
            autoStart: true,
            showNotification: true,
          );
        }

        setState(() {
          isRingtoneOne = false;
        });

        print("Sing ringtone");
      }

      timelinePic = jsonDecode(response.body)['data'][0]['timeline_pic'];
      circularDP = jsonDecode(response.body)['data'][0]['profile_pic'];
      likes = jsonDecode(response.body)['data'][0]['like'];
      bluetick = jsonDecode(response.body)['data'][0]['bluetick_status'];
      views = jsonDecode(response.body)['data'][0]['view'];
      going = jsonDecode(response.body)['data'][0]['ongoing'];
      organisationName = jsonDecode(response.body)['data'][0]['name'];
      popularPartyVerification =
          jsonDecode(response.body)['data'][0]['profile_pic_approval_status'];
      //profile_pic_approval_status
      //approval_status
      organisationVerification =
          jsonDecode(response.body)['data'][0]['approval_status'];
      organisationRating = jsonDecode(response.body)['data'][0]['rating'];

      organizationDesc = jsonDecode(response.body)['data'][0]['description'];

      print('printing ratings of organisation :: ${jsonDecode(response.body)}');

      //fetch CITY
    });
    setState(() {
      isLoading = false;
    });
  }

  int totalPartiesCount = 0;
  String notificationCount = "0";
  double currentDotIndex = 0.0;
  var partiesJsonData;

  // if (notificationCount == '0') {

  //     }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      print('automatic refresh');
// Here you can write your code

      getAPIOverview();
      getOrganisationDetailsToday();
      getOrganisationDetailsTom();
      getOrganisationDetailsUpcomming();
    });
    super.initState();
  }

  readNotificationCount() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/notification_read_status_update'),
        headers: {'x-access-token': GetStorage().read('token')});

    print('Notification count read ::${response.body}');
  }

  alertBoxWithNavigation() async {
    if (organisationVerification == '0') {
      await Alert(
        context: context,
        title: "Under Review",
        desc:
            "Please wait while we are reviewing your application,\n After verification you can start posting parties.",
      ).show();

      // Code will continue after alert is closed.
      debugPrint("Alert closed now.");
    } else {
      addOrganizationsEvent2Controller.isPopular.value = false;
      addOrganizationsEvent2Controller.isEditable.value = false;
      Get.toNamed(Routes.ADD_ORGANIZATIONS_EVENT2);
    }
  }

  OrganizationProfileNewController organizationProfileNewController =
      Get.put(OrganizationProfileNewController());
  bool isDismissed = false;

  AddOrganizationsEvent2Controller addOrganizationsEvent2Controller =
      Get.put(AddOrganizationsEvent2Controller());

  Future<void> myAsyncRefreshFunction() async {
    getAPIOverview();
    getOrganisationDetailsToday();
    getOrganisationDetailsTom();
    getOrganisationDetailsUpcomming();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      /// delegate with configuration
      builder: MaterialIndicatorDelegate(
        builder: (context, controller) {
          return Container(
              height: 15,
              width: 15,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.black,
                ),
              ));
        },
      ),
      onRefresh: myAsyncRefreshFunction,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 75,
            backgroundColor: Colors.red.shade900,
            leading: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () {
                Get.to(DrawerView(
                  profileImageView: circularDP,
                  timeLineImage: timelinePic,
                  likes: likes,
                  views: views,
                ));
              },
              child: Image.asset(
                'assets/side_drawer.png',
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () async {
                          await readNotificationCount();
                          Get.to(NotificationScreen());
                        },
                        child: Image.asset(
                          'assets/notification.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    notificationCount == '0'
                        ? Container()
                        : Positioned(
                            right: 0,
                            top: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              maxRadius: 5,
                            ),
                          ),
                  ],
                ),
              ),
            ],
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (bluetick == '1')
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 15,
                      ),
                    if (bluetick == '1')
                      SizedBox(
                        width: 5,
                      ),
                    Flexible(
                      child: Text(
                        '${organisationName.capitalizeFirst}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'SegeoUI',
                          overflow: TextOverflow.ellipsis,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SmoothStarRating(
                  allowHalfRating: false,
                  starCount: 5,
                  rating: double.parse(organisationRating),
                  size: 20.0,
                  color: Colors.orange,
                  borderColor: Colors.orange,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  spacing: .5,
                ),
              ],
            )),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xffCE2323),
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomAppBar(
            height: 75,
            color: Color(0xff5A0404),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 30,
                    child: Center(
                        child: Container(
                            height: 26,
                            width: 26,
                            child: Image.asset('assets/home (1).png'))),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(CustProfileView(
                          organizationData: fullOrganizationData,
                        ));
                      },
                      child: Container(
                          height: 26,
                          width: 26,
                          child: Image.asset('assets/profile (1).png'))),
                ],
              ),
            ),
            shape: const CircularNotchedRectangle(),
            elevation: 18,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            alertBoxWithNavigation();
          },
          child: Icon(
            Icons.add,
            size: 55,
          ),
          backgroundColor: organisationVerification == '1'
              ? Color(0xffFFA914)
              : Colors.grey[400],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/red_background.png"),
                        fit: BoxFit.fill))),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  organisationVerification == '1'
                      ? Container()
                      : isDismissed == true
                          ? Container()
                          : Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Text(
                                      "Your account is not verified yet.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          isDismissed = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                  organisationVerification == '1'
                      ? Container()
                      : SizedBox(
                          height: 20,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              height: 58,
                              child: Image.asset('assets/22 (2).png')),
                          Text(
                            likes,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'malgun'),
                          ),
                          Text(
                            'LIKES',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SegeoUI'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 58,
                              child: Image.asset('assets/22 (3).png')),
                          Text(
                            views,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'malgun'),
                          ),
                          Text(
                            'VIEWS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SegeoUI'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 58,
                              child: Image.asset('assets/22 (1).png')),
                          Text(
                            going,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'malgun'),
                          ),
                          Text(
                            'GOING',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SegeoUI'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'POPULAR EVENTS',
                      style:
                          GoogleFonts.oswald(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  popularPartyLength == 0 || lengthOfTodayParties == 0
                      ? Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: lengthOfTodayParties,
                              itemBuilder: (context, index) {
                                if (jsonPartyOgranisationDataToday[index]
                                        ['papular_status'] ==
                                    '1') {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(PopularPartyPreview(
                                        isPopularParty: true,
                                        data: jsonPartyOgranisationDataToday[
                                            index],
                                      ));
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 18.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  height: 15,
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .favorite,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .red
                                                                          .shade900,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  '${jsonPartyOgranisationDataToday[index]['like']}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'LIKE',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  height: 15,
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/WhatsApp Image 2023-02-23 at 10.55.21 PM.jpeg'),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  '${jsonPartyOgranisationDataToday[index]['view']}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'VIEWS',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  height: 15,
                                                                  child: Center(
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/WhatsApp Image 2023-02-23 at 10.55.22 PM.jpeg')),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  '${jsonPartyOgranisationDataToday[index]['ongoing']}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  'GOING',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          8),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          height:
                                                              Get.height * 0.5,
                                                          width:
                                                              Get.width * 0.48,
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                '${jsonPartyOgranisationDataToday[index]['cover_photo']}',
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                            Radius.circular(30),
                                                          ))),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 5,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child:

                                                          //
                                                          Stack(
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            width: 180,
                                                            child: Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${jsonPartyOgranisationDataToday[index]['title']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              'malgun',
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      'Today ${jsonPartyOgranisationDataToday[index]['start_time']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'malgun'),
                                                                    ),
                                                                    SmoothStarRating(
                                                                      allowHalfRating:
                                                                          false,
                                                                      starCount:
                                                                          5,
                                                                      rating: double
                                                                          .parse(
                                                                              organisationRating),
                                                                      size:
                                                                          20.0,
                                                                      color: Colors
                                                                          .orange,
                                                                      borderColor:
                                                                          Colors
                                                                              .orange,
                                                                      filledIconData:
                                                                          Icons
                                                                              .star,
                                                                      halfFilledIconData:
                                                                          Icons
                                                                              .star_half,
                                                                      defaultIconData:
                                                                          Icons
                                                                              .star_border,
                                                                      spacing:
                                                                          .5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              elevation: 18,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            right: 0,
                                                            bottom: 5,
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  addOrganizationsEvent2Controller
                                                                      .isEditable
                                                                      .value = true;
                                                                  addOrganizationsEvent2Controller
                                                                          .getPrefiledData =
                                                                      jsonPartyOgranisationDataToday[
                                                                          index];
                                                                  addOrganizationsEvent2Controller
                                                                      .isPopular
                                                                      .value = true;
                                                                  Get.toNamed(Routes
                                                                      .ADD_ORGANIZATIONS_EVENT2);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  width: 30,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 14,
                                                                    ),
                                                                  ),
                                                                ),
                                                                style: ElevatedButton.styleFrom(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    elevation:
                                                                        0,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            child: Container(
                                                height: 60,
                                                width: 60,
                                                child: Image.asset(
                                                    'assets/excellence.png'))),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'TODAY',
                      style:
                          GoogleFonts.oswald(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  lengthOfTodayParties == 0
                      ? Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : popularPartyLength != 0
                          ? Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 190,
                                    width: Get.width,
                                    child: ListView.builder(
                                        controller: ScrollController(
                                            initialScrollOffset: 0),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,

                                        // physics: NeverScrollableScrollPhysics(),
                                        itemCount: lengthOfTodayParties,
                                        itemBuilder: (context, index) {
                                          return jsonPartyOgranisationDataToday[
                                                          index]
                                                      ['papular_status'] !=
                                                  '1'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                          PopularPartyPreview(
                                                        isPopularParty: false,
                                                        data:
                                                            jsonPartyOgranisationDataToday[
                                                                index],
                                                      ));
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 160,
                                                          width: 171,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffffffff),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        17.0),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  '${jsonPartyOgranisationDataToday[index]['cover_photo']}',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                height: 80,
                                                                width: 171,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5),
                                                                      spreadRadius:
                                                                          3,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .red
                                                                        .shade900
                                                                        .withOpacity(
                                                                            0.5),
                                                                    width: 1,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          10.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${jsonPartyOgranisationDataToday[index]['title']}",
                                                                        style:
                                                                            TextStyle(
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontFamily:
                                                                              'malgun',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              const Color(0xff564d4d),
                                                                          height:
                                                                              1.25,
                                                                        ),
                                                                        textHeightBehavior:
                                                                            TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                        softWrap:
                                                                            false,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        '${jsonPartyOgranisationDataToday[index]['start_time']}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'malgun',
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              const Color(0xffc40d0d),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        lengthOfTodayParties !=
                                                                0
                                                            ? Positioned(
                                                                left: 0,
                                                                top: 0,
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            55,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(PopularPartyPreview(
                                                                                isPopularParty: false,
                                                                                data: jsonPartyOgranisationDataToday[index]));
                                                                          },
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                5,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                                            child:
                                                                                Container(decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(40)), child: SizedBox(height: 15, width: 15, child: Lottie.asset('assets/21159-tm-boost-button.json'))),
                                                                          ),
                                                                        )),
                                                              )
                                                            : Container(),
                                                        Positioned(
                                                          bottom: 15,
                                                          right: 0,
                                                          child: SizedBox(
                                                            height: 30,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                addOrganizationsEvent2Controller
                                                                    .isEditable
                                                                    .value = true;
                                                                addOrganizationsEvent2Controller
                                                                        .isPopular
                                                                        .value =
                                                                    false;
                                                                addOrganizationsEvent2Controller
                                                                        .getPrefiledData =
                                                                    jsonPartyOgranisationDataToday[
                                                                        index];
                                                                Get.toNamed(Routes
                                                                    .ADD_ORGANIZATIONS_EVENT2);
                                                              },
                                                              child: Container(
                                                                child: Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            14,
                                                                      ),
                                                                      Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                width: 50,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .orange,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                              ),
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'TOMORROW',
                      style:
                          GoogleFonts.oswald(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  lengthOfTommParties == 0
                      ? Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 190,
                                width: Get.width,
                                child: ListView.builder(
                                    controller: ScrollController(
                                        initialScrollOffset: 0),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,

                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: lengthOfTommParties,
                                    itemBuilder: (context, index) {
                                      return jsonPartyOgranisationDataTomm[
                                                  index]['papular_status'] !=
                                              '1'
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(PopularPartyPreview(
                                                    isPopularParty: false,
                                                    data:
                                                        jsonPartyOgranisationDataTomm[
                                                            index],
                                                  ));
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 160,
                                                      width: 171,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffffffff),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(17.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              '${jsonPartyOgranisationDataTomm[index]['cover_photo']}',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 80,
                                                            width: 171,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xffffffff),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      3,
                                                                  blurRadius: 7,
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .red
                                                                    .shade900
                                                                    .withOpacity(
                                                                        0.5),
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          10.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${jsonPartyOgranisationDataTomm[index]['title']}",
                                                                    style:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          'malgun',
                                                                      fontSize:
                                                                          16,
                                                                      color: const Color(
                                                                          0xff564d4d),
                                                                      height:
                                                                          1.25,
                                                                    ),
                                                                    textHeightBehavior:
                                                                        TextHeightBehavior(
                                                                            applyHeightToFirstAscent:
                                                                                false),
                                                                    softWrap:
                                                                        false,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    '${jsonPartyOgranisationDataTomm[index]['start_time']}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'malgun',
                                                                      fontSize:
                                                                          16,
                                                                      color: const Color(
                                                                          0xffc40d0d),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    lengthOfTommParties != 0
                                                        ? Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                                height: 50,
                                                                width: 55,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(PopularPartyPreview(
                                                                        isPopularParty:
                                                                            false,
                                                                        data: jsonPartyOgranisationDataTomm[
                                                                            index]));
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40)),
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .black,
                                                                            borderRadius: BorderRadius.circular(
                                                                                40)),
                                                                        child: SizedBox(
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                15,
                                                                            child:
                                                                                Lottie.asset('assets/21159-tm-boost-button.json'))),
                                                                  ),
                                                                )),
                                                          )
                                                        : Container(),
                                                    Positioned(
                                                      bottom: 15,
                                                      right: 0,
                                                      child: SizedBox(
                                                        height: 30,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            addOrganizationsEvent2Controller
                                                                .isEditable
                                                                .value = true;
                                                            addOrganizationsEvent2Controller
                                                                .isPopular
                                                                .value = false;
                                                            addOrganizationsEvent2Controller
                                                                    .getPrefiledData =
                                                                jsonPartyOgranisationDataTomm[
                                                                    index];
                                                            Get.toNamed(Routes
                                                                .ADD_ORGANIZATIONS_EVENT2);
                                                          },
                                                          child: Container(
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 14,
                                                                  ),
                                                                  Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .orange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  elevation: 0,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'UPCOMING',
                      style:
                          GoogleFonts.oswald(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  lengthOfUpcomingParties == 0
                      ? Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 190,
                                width: Get.width,
                                child: ListView.builder(
                                    controller: ScrollController(
                                        initialScrollOffset: 0),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,

                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: lengthOfUpcomingParties,
                                    itemBuilder: (context, index) {
                                      return jsonPartyOgranisationDataUpcomming[
                                                  index]['papular_status'] !=
                                              '1'
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(PopularPartyPreview(
                                                    isPopularParty: false,
                                                    data:
                                                        jsonPartyOgranisationDataUpcomming[
                                                            index],
                                                  ));
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 160,
                                                      width: 171,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffffffff),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(17.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              '${jsonPartyOgranisationDataUpcomming[index]['cover_photo']}',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 80,
                                                            width: 171,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0xffffffff),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      3,
                                                                  blurRadius: 7,
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .red
                                                                    .shade900
                                                                    .withOpacity(
                                                                        0.5),
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          20.0,
                                                                      right:
                                                                          10.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${jsonPartyOgranisationDataUpcomming[index]['title']}",
                                                                    style:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          'malgun',
                                                                      fontSize:
                                                                          16,
                                                                      color: const Color(
                                                                          0xff564d4d),
                                                                      height:
                                                                          1.25,
                                                                    ),
                                                                    textHeightBehavior:
                                                                        TextHeightBehavior(
                                                                            applyHeightToFirstAscent:
                                                                                false),
                                                                    softWrap:
                                                                        false,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        DateFormat.yMEd().format(DateTime.parse(jsonPartyOgranisationDataUpcomming[index]
                                                                            [
                                                                            'start_date'])),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              const Color(0xffc40d0d),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        '${jsonPartyOgranisationDataUpcomming[index]['start_time']}',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              const Color(0xffc40d0d),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    lengthOfUpcomingParties != 0
                                                        ? Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(PopularPartyPreview(
                                                                        isPopularParty:
                                                                            false,
                                                                        data: jsonPartyOgranisationDataUpcomming[
                                                                            index]));
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        5,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40)),
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .black,
                                                                            borderRadius: BorderRadius.circular(
                                                                                40)),
                                                                        child: SizedBox(
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                15,
                                                                            child:
                                                                                Lottie.asset('assets/21159-tm-boost-button.json'))),
                                                                  ),
                                                                )),
                                                          )
                                                        : Container(),
                                                    Positioned(
                                                      bottom: 5,
                                                      right: 0,
                                                      child: SizedBox(
                                                        height: 30,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            addOrganizationsEvent2Controller
                                                                .isEditable
                                                                .value = true;
                                                            addOrganizationsEvent2Controller
                                                                .isPopular
                                                                .value = false;
                                                            addOrganizationsEvent2Controller
                                                                    .getPrefiledData =
                                                                jsonPartyOgranisationDataUpcomming[
                                                                    index];
                                                            Get.toNamed(Routes
                                                                .ADD_ORGANIZATIONS_EVENT2);
                                                          },
                                                          child: Container(
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 14,
                                                                  ),
                                                                  Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .orange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  elevation: 0,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
