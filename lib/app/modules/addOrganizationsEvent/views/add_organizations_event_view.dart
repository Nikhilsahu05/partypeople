// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../select_photo_options_screen.dart';
import '../controllers/add_organizations_event_controller.dart';

class AddOrganizationsEventView extends StatefulWidget {
  const AddOrganizationsEventView({Key? key}) : super(key: key);

  @override
  State<AddOrganizationsEventView> createState() =>
      _AddOrganizationsEventViewState();
}

class _AddOrganizationsEventViewState extends State<AddOrganizationsEventView> {
  var timelineImage;
  var profileImage;

  final cropKey = GlobalKey<CropState>();
  File? _image;

  _pickImageTimeLine(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;

        controller.timelinePicture = _image;
        timelineImage = _image;
        print('iamge path :::: ${controller.timelinePicture?.path}');
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  _pickImageProfile(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        profileImage = _image;
        controller.profilePicture = _image;
        print('Image profile ::: ${profileImage?.path}');

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

  void _showSelectPhotoOptionsTimeline(BuildContext context) {
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
                onTap: _pickImageTimeLine,
              ),
            );
          }),
    );
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

  AddOrganizationsEventController controller =
      Get.put(AddOrganizationsEventController());

  String? _currentAddress;
  Position? _currentPosition;

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
      addOrganizationsEventController.location.text = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  AddOrganizationsEventController addOrganizationsEventController =
      Get.put(AddOrganizationsEventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red.shade900,
          title: Text(
            controller.isEditable.value == true
                ? 'Edit Organisation Profile'
                : 'Profile',
            style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 20,
              color: Colors.white,
            ),
            softWrap: false,
          ),
        ),
        body: SingleChildScrollView(
            child: controller.isLoading.value == true
                ? Container(
                    height: Get.height,
                    width: 300,
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset('assets/loading_bar.gif'),
                        ),
                        Text(
                          "Wait while fetching your location",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.183, -0.74),
                            end: Alignment(1.071, -0.079),
                            colors: [
                              const Color(0xffd10e0e),
                              const Color(0xff870606),
                              const Color(0xff300202)
                            ],
                            stops: [0.0, 0.564, 1.0],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading == true
                            ? Center(
                                child: Container(
                                    height: Get.height,
                                    width: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.pin_drop,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Please Wait While We are Fetching Your Location",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )),
                              )
                            : Obx(
                                () => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                _showSelectPhotoOptionsTimeline(
                                                    context),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  width: double.maxFinite,
                                                  child: controller.isEditable
                                                              .value ==
                                                          true
                                                      ? controller.timelinePicture
                                                                  ?.path ==
                                                              null
                                                          ? Card(
                                                              child: Image.network(
                                                                  'https://manage.partypeople.in/${controller.timeline}',
                                                                  fit: BoxFit
                                                                      .fill),
                                                            )
                                                          : Card(
                                                              child: Image.file(
                                                                controller
                                                                    .timelinePicture!,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            )
                                                      : controller.timelinePicture !=
                                                              null
                                                          ? Card(
                                                              child: Image.file(
                                                                  controller
                                                                      .timelinePicture!,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            )
                                                          : Card(
                                                              child: Image.asset(
                                                                  'assets/img.png',
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _showSelectPhotoOptionsTimeline(
                                                            context);
                                                      },
                                                      icon: Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.9,
                                            child: GestureDetector(
                                              onTap: () {
                                                _showSelectPhotoOptionsProfile(
                                                    context);
                                              },
                                              child: Container(
                                                  child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(99)),
                                                      elevation: 5,
                                                      child: Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: controller
                                                                      .isEditable
                                                                      .value ==
                                                                  true
                                                              ? controller.profilePicture
                                                                          ?.path ==
                                                                      null
                                                                  ? CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red
                                                                              .shade900,
                                                                      maxRadius:
                                                                          40,
                                                                      backgroundImage:
                                                                          NetworkImage(
                                                                        'https://manage.partypeople.in/${controller.profile}',
                                                                      ),
                                                                    )
                                                                  : CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red
                                                                              .shade900,
                                                                      maxRadius:
                                                                          40,
                                                                      backgroundImage:
                                                                          FileImage(controller
                                                                              .profilePicture!))
                                                              : controller.profilePicture !=
                                                                      null
                                                                  ? CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red
                                                                              .shade900,
                                                                      maxRadius:
                                                                          40,
                                                                      backgroundImage:
                                                                          FileImage(controller.profilePicture!))
                                                                  : CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      maxRadius:
                                                                          45,
                                                                      backgroundImage:
                                                                          AssetImage(
                                                                        'assets/676-6764065_default-image-png.png',
                                                                      ),
                                                                    )))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: TextField(
                                          controller: controller.name,
                                          minLines: 1,
                                          maxLines: 1,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintText: "Organization Name"
                                                .toUpperCase(),
                                            hintStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextField(
                                          controller: controller.description,
                                          minLines: 1,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            hintText: "Add Description",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
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
                                              suffixIcon:
                                                  Icon(Icons.gps_fixed)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextField(
                                          controller: controller.city,
                                          minLines: 1,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            hintText: "Add More Branches",
                                            suffix: Text("(Optional)"),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Obx(() => ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                controller.citySelected.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  //controller.citySelected(index);
                                                },
                                                child: Container(
                                                    height: 50,
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                    width: Get.width,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              controller
                                                                      .citySelected[
                                                                  index],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'malgun',
                                                                fontSize: 14,
                                                                color: const Color(
                                                                    0xff035dc4),
                                                                letterSpacing:
                                                                    -0.28,
                                                                height:
                                                                    1.1428571428571428,
                                                              ),
                                                              textHeightBehavior:
                                                                  TextHeightBehavior(
                                                                      applyHeightToFirstAscent:
                                                                          false),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              softWrap: false,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller
                                                                    .citySelected
                                                                    .remove(controller
                                                                            .citySelected[
                                                                        index]);
                                                                controller
                                                                    .citySelectedKey
                                                                    .remove(index
                                                                        .toString());
                                                              },
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 28,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          width: Get.width,
                                                          color: const Color(
                                                              0xff035dc4),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            },
                                          )),
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 50,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                if (controller.name.text !=
                                                        '' &&
                                                    controller
                                                            .description.text !=
                                                        '') {
                                                  Get.toNamed(
                                                      Routes.AddAmenities);
                                                } else {
                                                  Get.snackbar('Empty Field',
                                                      'Kindly Fill All The Fields',
                                                      backgroundColor:
                                                          Colors.white);
                                                  return;
                                                }
                                              },
                                              child: Text('NEXT')),
                                        ),
                                      )
                                    ]),
                              ),
                      ),
                    ],
                  )));
  }
}

class GoogleMapsSystem extends StatefulWidget {
  @override
  _GoogleMapsSystemState createState() => _GoogleMapsSystemState();
}

class _GoogleMapsSystemState extends State<GoogleMapsSystem> {
  late GoogleMapController myController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Maps Demo'),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () => print('You have pressed the button'),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
