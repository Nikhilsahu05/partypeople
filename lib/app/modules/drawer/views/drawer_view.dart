// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent/controllers/add_organizations_event_controller.dart';
import 'package:pertypeople/app/modules/verification_screen.dart';
import 'package:pertypeople/app/settings_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../controllers/drawer_controller.dart';

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
  DrawerController2 controller = Get.put(DrawerController2());
  var timelineImage;
  var profileImage;

  _getFromGalleryTimeLine(ImageSource imageSource) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: imageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      //_sample?.delete();
      //_file?.delete();

      setState(() {
        timelineImage = imageFile;
      });
      setState(() {
        timelineImage = imageFile;
      });
    }
  }

  AddOrganizationsEventController addOrganizationsEventController =
      Get.put(AddOrganizationsEventController());

  _getFromGalleryProfile(ImageSource imageSource) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: imageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        profileImage = imageFile;
        GetStorage().write('profile_picture', profileImage.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _getFromGalleryTimeLine(
                                          ImageSource.camera);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      _getFromGalleryTimeLine(
                                          ImageSource.gallery);
                                    },
                                    icon: Icon(
                                      Icons.photo,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ));
                        },
                        child: Container(
                            child: Stack(
                          children: [
                            Container(
                              height: 250,
                              width: double.maxFinite,
                              child: Card(
                                child: timelineImage == null
                                    ? Image.network(
                                        widget.timeLineImage,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        timelineImage,
                                        fit: BoxFit.fill,
                                      ),
                                elevation: 5,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                child: IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                _getFromGalleryTimeLine(
                                                    ImageSource.camera);
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                _getFromGalleryTimeLine(
                                                    ImageSource.gallery);
                                              },
                                              icon: Icon(
                                                Icons.photo,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                      Positioned(
                        bottom: 15,
                        left: MediaQuery.of(context).size.width / 2.9,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _getFromGalleryProfile(
                                            ImageSource.camera);
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        _getFromGalleryProfile(
                                            ImageSource.gallery);
                                      },
                                      icon: Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ));
                          },
                          child: Container(
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(99)),
                                  elevation: 10,
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: profileImage == null
                                        ? CircleAvatar(
                                            backgroundColor:
                                                Colors.red.shade900,
                                            maxRadius: 40,
                                            backgroundImage: NetworkImage(
                                                widget.profileImageView))
                                        : CircleAvatar(
                                            maxRadius: 40,
                                            backgroundImage:
                                                FileImage(profileImage)),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      GetStorage().read('full_name') ?? "",
                      style: TextStyle(
                        fontFamily: 'malgun',
                        fontSize: 27,
                        color: const Color(0xffffffff),
                        letterSpacing: -0.54,
                        height: 1.2222222222222223,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      softWrap: false,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                '0 views',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: const Color(0xff7d7373),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                '0 likes',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: const Color(0xff7d7373),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        addOrganizationsEventController.isEditable.value = true;
                        Get.toNamed(Routes.ADD_ORGANIZATIONS_EVENT);
                      },
                      child:
                          drawerTile(title: 'Edit Profile', icon: Icons.edit)),
                  Divider(
                    thickness: 0.7,
                    height: 1,
                  ),
                  GestureDetector(
                      onTap: () async {
                        final Uri _url = Uri.parse(
                            "https://partypeople.in/index.html#rockon_faq");

                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      child: drawerTile(title: 'FAQ', icon: Icons.chat)),
                  Divider(
                    thickness: 0.7,
                    height: 1,
                  ),
                  GestureDetector(
                      onTap: () async {
                        final Uri _url =
                            Uri.parse("https://partypeople.in/#rockon_contact");

                        if (!await launchUrl(_url)) {
                          throw Exception('Could not launch $_url');
                        }
                      },
                      child: drawerTile(title: 'Help', icon: Icons.help)),
                  Divider(
                    thickness: 0.7,
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("verification screen navigation");
                      Get.to(VerificationScreen());
                    },
                    child:
                        drawerTile(title: 'Verification', icon: Icons.verified),
                  ),
                  Divider(
                    thickness: 0.7,
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Settings screen navigation");
                      Get.to(SettingsView());
                    },
                    child: drawerTile(title: 'Settings', icon: Icons.settings),
                  ),
                  Divider(
                    thickness: 0.7,
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      GetStorage().remove('token');
                      Get.offAllNamed(Routes.HOME);
                    },
                    child: drawerTile(title: 'Logout', icon: Icons.logout),
                  ),
                  Divider(
                    thickness: 0.7,
                    height: 1,
                  ),
                ]),
              ),
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
                          fontSize: 19,
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
