// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pertypeople/app/modules/amenites_party.dart';
import 'package:pertypeople/app/select_photo_options_screen.dart';

import 'addOrganizationsEvent2/controllers/add_organizations_event2_controller.dart';

class EditProfileScreen extends StatefulWidget {
  var editProfileData;
  bool isPopularParty;

  EditProfileScreen(
      {required this.editProfileData, Key? key, required this.isPopularParty})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    _getCurrentPosition();
    controller.genderList.add(1);
    controller.title.text = widget.editProfileData['title'];
    controller.description.text = widget.editProfileData['description'];
    controller.startTime.text = widget.editProfileData['start_time'];
    controller.startDate.text = widget.editProfileData['start_date'];
    controller.endDate.text = widget.editProfileData['end_date'];
    controller.endTime.text = widget.editProfileData['end_time'];
    controller.startPeopleAge.text = widget.editProfileData['start_age'];
    controller.endPeopleAge.text = widget.editProfileData['end_age'];
    controller.peopleLimit.text = widget.editProfileData['person_limit'];
    controller.ladiesPrice.text = widget.editProfileData['ladies'];
    controller.stagPrice.text = widget.editProfileData['stag'];
    controller.couplesPrice.text = widget.editProfileData['couples'];
    controller.othersPrice.text = widget.editProfileData['others'];
    print("${widget.editProfileData}");
    super.initState();
  }

  String? _currentAddress;
  Position? _currentPosition;

  final cropKey = GlobalKey<CropState>();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  bool isLoading = false;

  Future<void> _getCurrentPosition() async {
    setState(() {
      isLoading = true;
    });
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });

      ///Save current address to text editor
      ///
      controller.location.text = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  AddOrganizationsEvent2Controller controller =
      Get.put(AddOrganizationsEvent2Controller());
  File? _image;

  _pickImageProfile(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        controller.profile = _image;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptionsProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImageProfile,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/mice.png'),
                      Text(
                        'Edit Party',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 22,
                          color: const Color(0xffc40d0d),
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: false,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showSelectPhotoOptionsProfile(context);
                },
                child: Stack(children: [
                  Container(
                    height: 250,
                    width: double.maxFinite,
                    child: controller.profile != null
                        ? Image.file(
                            controller.profile!,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            'https://manage.partypeople.in/${widget.editProfileData['cover_photo']}',
                            fit: BoxFit.fill,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: IconButton(
                        onPressed: () {
                          _showSelectPhotoOptionsProfile(context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.red,
                        )),
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.title,
                minLines: 1,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 37,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '${widget.editProfileData['title']}',
                  hintStyle: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 37,
                    color: const Color(0x8c7d7373),
                  ),
                ),
              ),
              TextField(
                controller: controller.description,
                minLines: 1,
                maxLines: 5,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 14,
                  color: const Color(0xff7d7373),
                ),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.menu_sharp,
                    color: Color(0xffB8B2B2),
                    size: 14,
                  ),
                  border: InputBorder.none,
                  hintText: '${widget.editProfileData['description']}',
                  hintStyle: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 14,
                    color: const Color(0xff7d7373),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  _showSelectPhotoOptionsProfile(context);
                },
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: const Color(0x247d7373),
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                            width: 1.0, color: const Color(0x24707070)),
                      ),
                      child: Icon(
                        Icons.image,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Edit cover photo',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: const Color(0xff7d7373),
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: false,
                    )
                  ],
                ),
              ),
              widget.isPopularParty == true
                  ? Container()
                  : SizedBox(
                      height: 20,
                    ),
              Row(
                children: [
                  widget.isPopularParty == true
                      ? Container()
                      : Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.redAccent,
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  widget.isPopularParty == true
                      ? Container()
                      : Text(
                          'Edit Party Date and Time',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              widget.isPopularParty == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.getStartDate(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () => controller.getStartDate(context),
                              keyboardType: TextInputType.datetime,
                              controller: controller.startDate,
                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'Party Start Date',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //controller.getEndDate(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () => controller.getEndDate(context),
                              controller: controller.endDate,

                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'Party End Date',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              widget.isPopularParty == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.getStartTime(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () => controller.getStartTime(context),
                              controller: controller.startTime,
                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'Party Start Time',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.getEndTime(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () {
                                controller.getEndTime(context);
                              },
                              controller: controller.endTime,

                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'Party End Time',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              widget.isPopularParty == true
                  ? Container()
                  : SizedBox(
                      height: 20,
                    ),

              /// | Post
              SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.pin_drop,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit location',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onTap: () async {
                    print("Open location dialog");
                    await _getCurrentPosition();
                  },
                  controller: controller.location,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Map Location",
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.gps_fixed)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.celebration,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit Party type',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Obx(() => DropdownButton<String>(
                    value: controller.partyType.value,
                    hint: Text('Select your party type',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          color: const Color(0xff035DC4),
                        )),
                    icon: const Icon(Icons.arrow_downward,
                        color: Color(0xff035DC4)),
                    style: const TextStyle(color: Color(0xff035DC4)),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      width: Get.width,
                      color: const Color(0xff035DC4),
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.partyType.value = newValue;
                      }
                    },
                    items: <String>['Music event', 'Light show', 'Neon party']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff035DC4),
                            )),
                      );
                    }).toList(),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit Gender',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              GroupButton(
                isRadio: false,
                controller: GroupButtonController(selectedIndex: 2),
                onSelected: (string, index, isSelected) {
                  print('$index button is selected');
                  print('$index button is selected');
                  if (isSelected) {
                    controller.genderList.add(index + 1);
                  } else {
                    controller.genderList.remove(index + 1);
                  }
                },
                maxSelected: 4,
                buttons: [
                  "Stag",
                  "Ladies",
                  "Couple",
                  "Others",
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.group,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit Age group',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controller.startPeopleAge,
                      minLines: 1,
                      maxLines: 1,
                      //enabled: false,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        color: const Color(0xff035DC4),
                      ),
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff035DC4)),
                        ),

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff035DC4), width: 1.0),
                        ),
                        hintText: '${widget.editProfileData['start_age']}',
                        hintStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          color: const Color(0xff035DC4),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controller.endPeopleAge,

                      minLines: 1,
                      maxLines: 1,
                      //enabled: false,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        color: const Color(0xff035DC4),
                      ),
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff035DC4)),
                        ),

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff035DC4), width: 1.0),
                        ),
                        hintText: '${widget.editProfileData['end_age']}',
                        hintStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          color: const Color(0xff035DC4),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit Party People Limit',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.peopleLimit,
                  minLines: 1,
                  maxLines: 1,
                  //enabled: false,
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 14,
                    color: const Color(0xff035DC4),
                  ),
                  decoration: InputDecoration(
                    //border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff035DC4)),
                    ),

                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xff035DC4), width: 1.0),
                    ),
                    hintText: '${widget.editProfileData['person_limit']}',
                    hintStyle: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 14,
                      color: const Color(0xff035DC4),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.local_offer,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Offers',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: TextField(
                  minLines: 1,
                  maxLines: 1,
                  //enabled: false,
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 14,
                    color: const Color(0xff035DC4),
                  ),
                  decoration: InputDecoration(
                    //border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff035DC4)),
                    ),

                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xff035DC4), width: 1.0),
                    ),
                    hintText: 'Enter offers',

                    suffixText: '(Optional)',
                    hintStyle: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 14,
                      color: const Color(0xff035DC4),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color(0x247d7373),
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0x24707070)),
                    ),
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Entry Fees',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 18,
                      color: const Color(0xff7d7373),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: false,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text("Ladies"),
                      Container(
                        width: 150,
                        child: TextField(
                          controller: controller.ladiesPrice,

                          keyboardType: TextInputType.number,
                          minLines: 1,
                          maxLines: 1,
                          //enabled: false,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xff035DC4),
                          ),
                          decoration: InputDecoration(
                            //border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff035DC4)),
                            ),

                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xff035DC4), width: 1.0),
                            ),
                            hintText: '₹ ${widget.editProfileData['ladies']}',
                            hintStyle: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff035DC4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Stag"),
                      Container(
                        width: 150,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: controller.stagPrice,
                          minLines: 1,
                          maxLines: 1,
                          //enabled: false,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xff035DC4),
                          ),
                          decoration: InputDecoration(
                            //border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff035DC4)),
                            ),

                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xff035DC4), width: 1.0),
                            ),
                            hintText: '₹ ${widget.editProfileData['stag']}',
                            hintStyle: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff035DC4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Couples"),
                      Container(
                        width: 150,
                        child: TextField(
                          controller: controller.couplesPrice,

                          keyboardType: TextInputType.number,
                          minLines: 1,
                          maxLines: 1,
                          //enabled: false,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xff035DC4),
                          ),
                          decoration: InputDecoration(
                            //border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff035DC4)),
                            ),

                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xff035DC4), width: 1.0),
                            ),
                            hintText: '₹ ${widget.editProfileData['couples']}',
                            hintStyle: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff035DC4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Others"),
                          Container(
                            width: 150,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: controller.othersPrice,

                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText:
                                    '₹ ${widget.editProfileData['others']}',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        if (controller.title.text != '' &&
                            controller.description.text != '' &&
                            controller.startDate.text != '' &&
                            controller.endDate.text != '' &&
                            controller.startTime.text != '' &&
                            controller.endTime.text != '' &&
                            controller.genderList.isNotEmpty &&
                            controller.peopleLimit.text != '') {
                          Get.to(AddAmenitiesParty(
                            isPopular: true,
                            editProfileData: widget.editProfileData,
                          ));
                        } else {
                          Get.snackbar(
                              'Empty Field', 'Kindly Fill all the fields');
                        }

                        ///Post api using update API
                      },
                      child: Text("Next")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
