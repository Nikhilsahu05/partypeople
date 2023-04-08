// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent/controllers/add_organizations_event_controller.dart';
import 'package:pertypeople/app/modules/verification_screen.dart';
import 'package:pertypeople/app/settings_view.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../../all_parties_history.dart';

// class DrawerView extends GetView<DrawerController2> {
//

class DrawerView extends StatefulWidget {
  String views;
  String likes;
  String profileImageView;
  String timeLineImage;

  DrawerView(
      {Key? key,
      required this.views,
      required this.likes,
      required this.profileImageView,
      required this.timeLineImage});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  AddOrganizationsEventController addOrganizationsEventController =
      Get.put(AddOrganizationsEventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade900,
          elevation: 0,
          title: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(children: [
                CoverPhotoAndProfileWidget(
                    coverPhotoUrl: widget.timeLineImage,
                    profilePhotoUrl: widget.profileImageView),
                SizedBox(height: 10),
                LikesAndViewsWidget(
                    views: int.parse(widget.views),
                    likes: int.parse(widget.likes)),
                SizedBox(height: 20),
                CustomOptionWidget(
                  title: 'Edit Organisation Profile',
                  icon: Icons.edit,
                  onTap: () {
                    addOrganizationsEventController.isEditable.value = true;
                    Get.toNamed(Routes.ADD_ORGANIZATIONS_EVENT);
                  },
                ),
                CustomOptionWidget(
                  title: 'Frequently Asked Questions',
                  icon: Icons.question_answer,
                  onTap: () async {
                    final Uri _url = Uri.parse(
                        "https://partypeople.in/index.html#rockon_faq");

                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
                CustomOptionWidget(
                  title: 'Need Any Help?',
                  icon: Icons.help_center,
                  onTap: () async {
                    final Uri _url =
                        Uri.parse("https://partypeople.in/#rockon_contact");

                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                ),
                CustomOptionWidget(
                  title: 'Document Verification',
                  icon: Icons.verified,
                  onTap: () {
                    print("verification screen navigation");
                    Get.to(VerificationScreen());
                  },
                ),
                CustomOptionWidget(
                  title: 'All Parties History',
                  icon: Icons.history,
                  onTap: () {
                    print("Parties screen navigation");
                    Get.to(AllPartiesHistory());
                  },
                ),
                CustomOptionWidget(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    print("Settings screen navigation");
                    Get.to(SettingsView());
                  },
                ),
                CustomOptionWidget(
                  title: 'Logout',
                  icon: Icons.login_outlined,
                  onTap: () {
                    GetStorage().remove('token');
                    Get.offAllNamed(Routes.HOME);
                  },
                ),
              ]),
            ),
          ],
        ));
  }

  Container drawerTile({
    String title = '',
    IconData icon = Icons.person,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 58,
      width: Get.width - 30,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        icon,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 16.sp,
                          color: const Color(0xff525252),
                          letterSpacing: -0.38,
                          fontWeight: FontWeight.w600,
                          height: 1.2105263157894737,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        softWrap: false,
                      ),
                      SizedBox(width: 180),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            bottom: 10,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class CoverPhotoAndProfileWidget extends StatelessWidget {
  final String coverPhotoUrl;
  final String profilePhotoUrl;

  CoverPhotoAndProfileWidget({
    required this.coverPhotoUrl,
    required this.profilePhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(coverPhotoUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: Get.height * 0.19,
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(profilePhotoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LikesAndViewsWidget extends StatelessWidget {
  final int likes;
  final int views;

  LikesAndViewsWidget({required this.likes, required this.views});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(
                Icons.favorite,
                size: 28.0,
                color: Colors.red.shade900,
              ),
              SizedBox(height: 8.0),
              Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          Container(
            height: 40.0,
            width: 1.0,
            color: Colors.grey[350],
          ),
          Column(
            children: [
              Icon(
                Icons.people,
                size: 28.0,
                color: Colors.red.shade900,
              ),
              SizedBox(height: 8.0),
              Text(
                views.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//Placeholder image for testing
//http://via.placeholder.com/640x360

class CustomOptionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  CustomOptionWidget({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24.0,
                color: Colors.red.shade900,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16.0,
                color: Colors.grey[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
