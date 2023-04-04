import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
import 'package:sizer/sizer.dart';
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

  OrganizationProfileNewController controller =
      Get.put(OrganizationProfileNewController());

  int totalPartiesCount = 0;
  String notificationCount = "0";
  double currentDotIndex = 0.0;
  var partiesJsonData;

  readNotificationCount() async {
    http.Response response = await http.post(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/notification_read_status_update'),
        headers: {'x-access-token': GetStorage().read('token')});

    print('Notification count read ::${response.body}');
  }

  alertBoxWithNavigation() async {
    if (controller.organisationVerification.value == '0') {
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
    await controller.getAPIOverview();
    await controller.getOrganisationDetailsToday();
    await controller.getOrganisationDetailsTom();
    await controller.getOrganisationDetailsUpcomming();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      autoRebuild: true,

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
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 65,
              backgroundColor: Colors.red.shade900,
              leading: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                  Get.to(DrawerView(
                    profileImageView: controller.circularDP.value,
                    timeLineImage: controller.timelinePic.value,
                    likes: controller.likes.value,
                    views: controller.views.value,
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
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Image.asset(
                              'assets/notification.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      controller.notificationCount.value == '0'
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          controller.organisationName.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'SegeoUI',
                          ),
                        ),
                      ),
                      controller.bluetick.value == '1'
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.verified,
                                    color: Colors.blue,
                                    size: 17,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  SizedBox(height: 5),
                  SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: double.parse(controller.organisationRating.value),
                    size: 18.0,
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
              height: 50,
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
                            phoneNumber: controller.phoneNumber.value,
                            organizationData: controller.fullOrganizationData,
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
            backgroundColor: controller.organisationVerification.value == '1'
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
                child: controller.isLoading.value == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Container(
                          child: Center(
                            child: CupertinoActivityIndicator(
                              radius: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          controller.organisationVerification.value == '1'
                              ? Container()
                              : isDismissed == true
                                  ? Container()
                                  : Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 3.0),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[700],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                fontSize: 13.sp,
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
                          controller.organisationVerification.value == '1'
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
                                    controller.likes.value,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'malgun'),
                                  ),
                                  Text(
                                    'LIKES',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
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
                                    controller.views.value,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'malgun'),
                                  ),
                                  Text(
                                    'VIEWS',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
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
                                    controller.going.value,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'malgun'),
                                  ),
                                  Text(
                                    'GOING',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
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
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'POPULAR EVENTS',
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                          controller.jsonPartyPopularData == null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 5.sp),
                                  child: Text(
                                    "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : Column(
                                  children: [
                                    CarouselSlider.builder(
                                      itemCount:
                                          controller.popularPartyLength.value,
                                      itemBuilder: (BuildContext context,
                                          int index, int pageViewIndex) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(PopularPartyPreview(
                                              isPopularParty: true,
                                              data: controller
                                                  .jsonPartyPopularData[index],
                                            ));
                                          },
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          18.0),
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
                                                                        height:
                                                                            15,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.favorite,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                Colors.red.shade900,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        '${controller.jsonPartyPopularData[index]['like']}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 6.sp),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        'LIKE',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 6.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            15,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Image.asset('assets/WhatsApp Image 2023-02-23 at 10.55.21 PM.jpeg'),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        '${controller.jsonPartyPopularData[index]['view']}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 6.sp),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        'VIEWS',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 6.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            15,
                                                                        child: Center(
                                                                            child:
                                                                                Image.asset('assets/WhatsApp Image 2023-02-23 at 10.55.22 PM.jpeg')),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        '${controller.jsonPartyPopularData[index]['ongoing']}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 6.sp),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        'GOING',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 6.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 30,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            12),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            12),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            12),
                                                                  ),
                                                                  child: controller.jsonPartyPopularData[index]
                                                                              [
                                                                              'image_status'] ==
                                                                          '1'
                                                                      ? Container(
                                                                          height:
                                                                              Get.height * 0.5,
                                                                          width:
                                                                              Get.width * 0.48,
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            imageUrl:
                                                                                '${controller.jsonPartyPopularData[index]['cover_photo']}',
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(12),
                                                                              bottomRight: Radius.circular(12),
                                                                              topLeft: Radius.circular(12),
                                                                              topRight: Radius.circular(12),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              Get.height * 0.5,
                                                                          width:
                                                                              Get.width * 0.48,
                                                                          child:
                                                                              ImageFiltered(
                                                                            imageFilter:
                                                                                ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              fit: BoxFit.cover,
                                                                              imageUrl: '${controller.jsonPartyPopularData[index]['cover_photo']}',
                                                                            ),
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(12),
                                                                              bottomRight: Radius.circular(12),
                                                                              topLeft: Radius.circular(12),
                                                                              topRight: Radius.circular(12),
                                                                            ),
                                                                          ),
                                                                        )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 5,
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
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
                                                                            BorderRadius.circular(15)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${controller.jsonPartyPopularData[index]['title']}',
                                                                            style: TextStyle(
                                                                                fontSize: 13.sp,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontFamily: 'malgun',
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          Text(
                                                                            'Today ${controller.jsonPartyPopularData[index]['start_time']}',
                                                                            style:
                                                                                TextStyle(fontSize: 11.sp, fontFamily: 'malgun'),
                                                                          ),
                                                                          SmoothStarRating(
                                                                            allowHalfRating:
                                                                                false,
                                                                            starCount:
                                                                                5,
                                                                            rating:
                                                                                double.parse(controller.organisationRating.value),
                                                                            size:
                                                                                20.0,
                                                                            color:
                                                                                Colors.orange,
                                                                            borderColor:
                                                                                Colors.orange,
                                                                            filledIconData:
                                                                                Icons.star,
                                                                            halfFilledIconData:
                                                                                Icons.star_half,
                                                                            defaultIconData:
                                                                                Icons.star_border,
                                                                            spacing:
                                                                                .5,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    elevation:
                                                                        18,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  right: 0,
                                                                  bottom: 5,
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        addOrganizationsEvent2Controller
                                                                            .isEditable
                                                                            .value = true;
                                                                        addOrganizationsEvent2Controller
                                                                            .getPrefiledData = controller
                                                                                .jsonPartyOgranisationDataToday[
                                                                            index];
                                                                        addOrganizationsEvent2Controller
                                                                            .isPopular
                                                                            .value = true;
                                                                        Get.toNamed(
                                                                            Routes.ADD_ORGANIZATIONS_EVENT2);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        width:
                                                                            30,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          color:
                                                                              Colors.orange,
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      style: ElevatedButton.styleFrom(
                                                                          padding: EdgeInsets
                                                                              .zero,
                                                                          elevation:
                                                                              0,
                                                                          backgroundColor:
                                                                              Colors.transparent),
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
                                                      0.12,
                                                  child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      child: Image.asset(
                                                          'assets/excellence.png'))),
                                            ],
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: 200,
                                        aspectRatio: 16 / 9,
                                        onPageChanged: (i, r) {
                                          setState(() {
                                            controller.count.value = i;
                                          });
                                        },
                                        viewportFraction: 0.96,
                                        initialPage: 0,
                                        reverse: false,
                                        autoPlay: false,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,

                                        enlargeFactor: 0.3,
                                        // onPageChanged: callbackFunction,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                    Container(
                                        child: DotsIndicator(
                                      dotsCount:
                                          controller.popularPartyLength.value,
                                      position: double.parse(
                                          controller.count.value.toString()),
                                      decorator: DotsDecorator(
                                        size: const Size.square(9.0),
                                        activeSize: const Size(28.0, 9.0),
                                        activeColor: Colors.orange,
                                        activeShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                    ))
                                  ],
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'TODAY',
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                          controller.lengthOfTodayParties.value == 0
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 5.sp),
                                  child: Text(
                                    "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : controller.popularPartyLength.value != 0
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey.shade300,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 190,
                                            width: Get.width,
                                            child: ListView.builder(
                                                controller: ScrollController(
                                                    initialScrollOffset: 0),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,

                                                // physics: NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .lengthOfTodayParties.value,
                                                itemBuilder: (context, index) {
                                                  return controller.jsonPartyOgranisationDataToday[
                                                                  index][
                                                              'papular_status'] !=
                                                          '1'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Get.to(
                                                                  PopularPartyPreview(
                                                                isPopularParty:
                                                                    false,
                                                                data: controller
                                                                        .jsonPartyOgranisationDataToday[
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
                                                                          BorderRadius.circular(
                                                                              17.0),
                                                                    ),
                                                                    child: controller.jsonPartyOgranisationDataToday[index]['image_status'] ==
                                                                            '1'
                                                                        ? ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(13.0),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: '${controller.jsonPartyOgranisationDataToday[index]['cover_photo']}',
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          )
                                                                        : ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(13.0),
                                                                            child:
                                                                                ImageFiltered(
                                                                              imageFilter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                                                                              child: CachedNetworkImage(
                                                                                imageUrl: '${controller.jsonPartyOgranisationDataToday[index]['cover_photo']}',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  child: Stack(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            80,
                                                                        width:
                                                                            171,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              const Color(0xffffffff),
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.5),
                                                                              spreadRadius: 3,
                                                                              blurRadius: 7,
                                                                              offset: Offset(0, 3), // changes position of shadow
                                                                            ),
                                                                          ],
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.black,
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 10.0,
                                                                              left: 20.0,
                                                                              right: 10.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${controller.jsonPartyOgranisationDataToday[index]['title']}",
                                                                                style: TextStyle(
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontFamily: 'malgun',
                                                                                  fontSize: 12.sp,
                                                                                  color: const Color(0xff564d4d),
                                                                                  height: 1.25,
                                                                                ),
                                                                                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                softWrap: false,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Text(
                                                                                '${controller.jsonPartyOgranisationDataToday[index]['start_time']}',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'malgun',
                                                                                  fontSize: 12.sp,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                controller.lengthOfTodayParties
                                                                            .value !=
                                                                        0
                                                                    ? Positioned(
                                                                        left: 0,
                                                                        top: 0,
                                                                        child: Container(
                                                                            height: 50,
                                                                            width: 55,
                                                                            child: GestureDetector(
                                                                              onTap: () {
                                                                                Get.to(PopularPartyPreview(isPopularParty: false, data: controller.jsonPartyOgranisationDataToday[index]));
                                                                              },
                                                                              child: Card(
                                                                                elevation: 5,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                                                child: Container(decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(40)), child: SizedBox(height: 15, width: 15, child: Lottie.asset('assets/21159-tm-boost-button.json'))),
                                                                              ),
                                                                            )),
                                                                      )
                                                                    : Container(),
                                                                Positioned(
                                                                  bottom: 15,
                                                                  right: 0,
                                                                  child:
                                                                      SizedBox(
                                                                    height: 30,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        addOrganizationsEvent2Controller
                                                                            .isEditable
                                                                            .value = true;
                                                                        addOrganizationsEvent2Controller
                                                                            .isPopular
                                                                            .value = false;
                                                                        addOrganizationsEvent2Controller
                                                                            .getPrefiledData = controller
                                                                                .jsonPartyOgranisationDataToday[
                                                                            index];
                                                                        Get.toNamed(
                                                                            Routes.ADD_ORGANIZATIONS_EVENT2);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.edit,
                                                                                color: Colors.white,
                                                                                size: 14,
                                                                              ),
                                                                              Text(
                                                                                "Edit",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        width:
                                                                            50,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.orange,
                                                                            borderRadius: BorderRadius.circular(30)),
                                                                      ),
                                                                      style: ElevatedButton.styleFrom(
                                                                          elevation:
                                                                              0,
                                                                          backgroundColor:
                                                                              Colors.transparent),
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
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                          controller.lengthOfTommParties.value == 0
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 5.sp),
                                  child: Text(
                                    "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                            itemCount: controller
                                                .lengthOfTommParties.value,
                                            itemBuilder: (context, index) {
                                              return controller.jsonPartyOgranisationDataTomm[
                                                              index]
                                                          ['papular_status'] !=
                                                      '1'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              PopularPartyPreview(
                                                            isPopularParty:
                                                                false,
                                                            data: controller
                                                                    .jsonPartyOgranisationDataTomm[
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
                                                              child: controller.jsonPartyOgranisationDataTomm[
                                                                              index]
                                                                          [
                                                                          'image_status'] ==
                                                                      '1'
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13.0),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            '${controller.jsonPartyOgranisationDataTomm[index]['cover_photo']}',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13.0),
                                                                      child:
                                                                          ImageFiltered(
                                                                        imageFilter: ui.ImageFilter.blur(
                                                                            sigmaX:
                                                                                8.0,
                                                                            sigmaY:
                                                                                8.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              '${controller.jsonPartyOgranisationDataTomm[index]['cover_photo']}',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
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
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ],
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10.0,
                                                                          left:
                                                                              20.0,
                                                                          right:
                                                                              10.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${controller.jsonPartyOgranisationDataTomm[index]['title']}",
                                                                            style:
                                                                                TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'malgun',
                                                                              fontSize: 12.sp,
                                                                              color: const Color(0xff564d4d),
                                                                              height: 1.25,
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
                                                                            '${controller.jsonPartyOgranisationDataTomm[index]['start_time']}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'malgun',
                                                                              fontSize: 12.sp,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            controller.lengthOfTommParties
                                                                        .value !=
                                                                    0
                                                                ? Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child: Container(
                                                                        height: 50,
                                                                        width: 55,
                                                                        child: GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(PopularPartyPreview(
                                                                                isPopularParty: false,
                                                                                data: controller.jsonPartyOgranisationDataTomm[index]));
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
                                                                  onPressed:
                                                                      () {
                                                                    addOrganizationsEvent2Controller
                                                                        .isEditable
                                                                        .value = true;
                                                                    addOrganizationsEvent2Controller
                                                                        .isPopular
                                                                        .value = false;
                                                                    addOrganizationsEvent2Controller
                                                                        .getPrefiledData = controller
                                                                            .jsonPartyOgranisationDataTomm[
                                                                        index];
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .ADD_ORGANIZATIONS_EVENT2);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                14,
                                                                          ),
                                                                          Text(
                                                                            "Edit",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .orange,
                                                                        borderRadius:
                                                                            BorderRadius.circular(30)),
                                                                  ),
                                                                  style: ElevatedButton.styleFrom(
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
                              'UPCOMING',
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          ),
                          controller.lengthOfUpcomingParties.value == 0
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 5.sp),
                                  child: Text(
                                    "Sorry, there are no parties available at this time. Please try again later or check back for updates.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                            itemCount: controller
                                                .lengthOfUpcomingParties.value,
                                            itemBuilder: (context, index) {
                                              return controller.jsonPartyOgranisationDataUpcomming[
                                                              index]
                                                          ['papular_status'] !=
                                                      '1'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              PopularPartyPreview(
                                                            isPopularParty:
                                                                false,
                                                            data: controller
                                                                    .jsonPartyOgranisationDataUpcomming[
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
                                                              child: controller.jsonPartyOgranisationDataUpcomming[
                                                                              index]
                                                                          [
                                                                          'image_status'] ==
                                                                      '1'
                                                                  ? ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13.0),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            '${controller.jsonPartyOgranisationDataUpcomming[index]['cover_photo']}',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13.0),
                                                                      child:
                                                                          ImageFiltered(
                                                                        imageFilter: ui.ImageFilter.blur(
                                                                            sigmaX:
                                                                                8.0,
                                                                            sigmaY:
                                                                                8.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              '${controller.jsonPartyOgranisationDataUpcomming[index]['cover_photo']}',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
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
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              3,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ],
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10.0,
                                                                          left:
                                                                              20.0,
                                                                          right:
                                                                              10.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${controller.jsonPartyOgranisationDataUpcomming[index]['title']}",
                                                                            style:
                                                                                TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontFamily: 'malgun',
                                                                              fontSize: 12.sp,
                                                                              color: const Color(0xff564d4d),
                                                                              height: 1.25,
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            softWrap:
                                                                                false,
                                                                          ),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                DateFormat.yMEd().format(DateTime.parse(controller.jsonPartyOgranisationDataUpcomming[index]['start_date'])),
                                                                                style: TextStyle(
                                                                                  fontSize: 12.sp,
                                                                                  color: const Color(0xffc40d0d),
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '${controller.jsonPartyOgranisationDataUpcomming[index]['start_time']}',
                                                                                style: TextStyle(
                                                                                  fontSize: 12.sp,
                                                                                  color: Colors.black,
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
                                                            controller.lengthOfUpcomingParties
                                                                        .value !=
                                                                    0
                                                                ? Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    child: Container(
                                                                        height: 40,
                                                                        width: 40,
                                                                        child: GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(PopularPartyPreview(
                                                                                isPopularParty: false,
                                                                                data: controller.jsonPartyOgranisationDataUpcomming[index]));
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
                                                              bottom: 5,
                                                              right: 0,
                                                              child: SizedBox(
                                                                height: 30,
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    addOrganizationsEvent2Controller
                                                                        .isEditable
                                                                        .value = true;
                                                                    addOrganizationsEvent2Controller
                                                                        .isPopular
                                                                        .value = false;
                                                                    addOrganizationsEvent2Controller
                                                                        .getPrefiledData = controller
                                                                            .jsonPartyOgranisationDataUpcomming[
                                                                        index];
                                                                    Get.toNamed(
                                                                        Routes
                                                                            .ADD_ORGANIZATIONS_EVENT2);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                14,
                                                                          ),
                                                                          Text(
                                                                            "Edit",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .orange,
                                                                        borderRadius:
                                                                            BorderRadius.circular(30)),
                                                                  ),
                                                                  style: ElevatedButton.styleFrom(
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
                            height: 50,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
