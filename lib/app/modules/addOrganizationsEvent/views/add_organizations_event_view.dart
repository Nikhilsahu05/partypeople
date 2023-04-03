// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pertypeople/cached_image_placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../../select_photo_options_screen.dart';
import '../controllers/add_organizations_event_controller.dart';

class AddOrganizationsEventView extends StatefulWidget {
  const AddOrganizationsEventView({Key? key}) : super(key: key);

  @override
  State<AddOrganizationsEventView> createState() =>
      _AddOrganizationsEventViewState();
}

class _AddOrganizationsEventViewState extends State<AddOrganizationsEventView> {
  final cropKey = GlobalKey<CropState>();

  Future<String?> savePhotoToFirebase(
      String tokenId, File photo, String imageName) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();

      // Initialize Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;

      // Create a reference to the photo in Firebase Storage
      Reference photoRef =
          storage.ref().child('$tokenId/organization/$imageName.jpg');

      // Upload the photo to Firebase Storage
      await photoRef.putFile(photo);

      // Get the download URL for the photo
      String downloadURL = await photoRef.getDownloadURL();
      setState(() {
        controller.isLoading.value = false;
      });
      return downloadURL;
    } catch (e) {
      print('Error saving photo to Firebase Storage: $e');
      return null;
    }
  }

  _pickImageTimeLine(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        savePhotoToFirebase(GetStorage().read("token"), img!, 'timeLine')
            .then((value) {
          print('checking URL ::: $value');
          controller.timeline.value = value!;
          controller.isLoading.value = false;
        });

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
        controller.isLoading.value = true;
        savePhotoToFirebase(GetStorage().read('token'), img!, 'profileImage')
            .then((value) {
          controller.profile.value = value!;
        });
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

  var jsonAddAmenitiesData;
  bool isLoading = false;
  List<MultiSelectCard> ameList = [];

  Future<void> newAmenities() async {
    setState(() {
      controller.isLoading.value = true;
    });

    // Get organization details
    final organizationResponse = await http.post(
      Uri.parse('https://manage.partypeople.in/v1/party/organization_details'),
      headers: {
        'x-access-token': '${GetStorage().read("token")}',
      },
    );
    final organizationData = await jsonDecode(organizationResponse.body)['data']
        [0]['organization_amenities'];

    // Add all amenities to the selected list and create MultiSelectCard for each amenity
    for (final amenityData in organizationData) {
      controller.selectedAmenitiesListID.add(amenityData['id']);
      ameList.add(
        MultiSelectCard(
          value: amenityData['id'],
          enabled: true,
          selected: true,
          label: amenityData['name'],
        ),
      );
    }

    setState(() {
      controller.isLoading.value = false;
    });
  }

  Future<void> getAmenities() async {
    // Get organization details
    if (controller.isEditable.value == true) {
      print("Function for matching amenities is now working");
      await newAmenities();
    }
    // Get all amenities
    final amenitiesResponse = await http.get(
      Uri.parse(
          'https://manage.partypeople.in/v1/party/organization_amenities'),
      headers: {
        'x-access-token': '${GetStorage().read("token")}',
      },
    );
    final amenitiesData = await jsonDecode(amenitiesResponse.body)['data'];

    for (final amenityData in amenitiesData) {
      bool alreadyExists = false;
      for (final ameItem in ameList) {
        if (ameItem.value == amenityData['id']) {
          alreadyExists = true;
          break;
        }
      }
      if (!alreadyExists) {
        ameList.add(
          MultiSelectCard(
            value: amenityData['id'],
            label: amenityData['name'],
          ),
        );
      }
    }
    setState(() {
      controller.isLoading.value = false;
    });
  }

  @override
  void initState() {
    getAmenities();
    // getEditedAmenities();
    _handleLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Obx(
      () => Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/red_background.png"),
                fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                      controller.isEditable.value == true
                          ? 'Edit Profile'
                          : 'Profile',
                      style: TextStyle(
                        fontFamily: 'malgun',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () => _showSelectPhotoOptionsTimeline(context),
                      child: Obx(
                        () => Stack(
                          children: [
                            controller.isLoading.value == false
                                ? Container(
                                    height: 200,
                                    width: double.maxFinite,
                                    child: controller.timeline.value != ''
                                        ? Card(
                                            child: CachedNetworkImageWidget(
                                                imageUrl:
                                                    controller.timeline.value,
                                                width: Get.width,
                                                height: 200,
                                                fit: BoxFit.fill,
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.error_outline),
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CupertinoActivityIndicator(
                                                                color: Colors
                                                                    .black,
                                                                radius: 15))))
                                        : Card(
                                            child: Lottie.asset(
                                              'assets/127619-photo-click.json',
                                            ),
                                          ),
                                  )
                                : Container(
                                    child: Center(
                                      child: CupertinoActivityIndicator(
                                        radius: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                child: IconButton(
                                  onPressed: () {
                                    _showSelectPhotoOptionsTimeline(context);
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    size: 30,
                                    Icons.camera_alt,
                                    color: Colors.red,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///TODO: ADD CACHED IMAGE PLACEHOLDER
                    Positioned(
                      bottom: 0,
                      left: MediaQuery.of(context).size.width / 2.9,
                      child: GestureDetector(
                        onTap: () {
                          _showSelectPhotoOptionsProfile(context);
                        },
                        child: Container(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(99)),
                                elevation: 5,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: controller.profile.value != ''
                                      ? CircleAvatar(
                                          backgroundColor: Colors.red.shade900,
                                          maxRadius: 40,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            controller.profile.value,
                                          ),
                                        )
                                      : Container(
                                          width: 50,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(99999),
                                          ),
                                          child: Lottie.asset(
                                              fit: BoxFit.cover,
                                              'assets/107137-add-profile-picture.json'),
                                        ),
                                ))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextFieldWithTitle(
                  title: 'Organization Name *',
                  controller: controller.name,
                  maxLength: 30,
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an organization name';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFieldWithTitle(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an organization description';
                    } else {
                      return null;
                    }
                  },
                  title: 'Organization Description *',
                  maxLength: 120,
                  controller: controller.description,
                  inputType: TextInputType.name,
                ),
                TextFieldWithTitle(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an organization branches';
                    } else {
                      return null;
                    }
                  },
                  title: 'Organization Branches',
                  controller: controller.branches,
                  inputType: TextInputType.name,
                ),
                LocationButton(),
                Container(
                  alignment: Alignment.center,
                  child: Text('Select Amenities *',
                      style: TextStyle(
                        fontFamily: 'malgun',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: MultiSelectContainer(
                        itemsPadding: EdgeInsets.all(12),
                        prefix: MultiSelectPrefix(
                            selectedPrefix: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 22,
                            ),
                            disabledPrefix: Icon(
                              Icons.do_disturb_alt_sharp,
                              size: 14,
                            )),
                        items: ameList,
                        onChange: (allSelectedItems, selectedItem) {
                          setState(() {
                            if (controller.selectedAmenitiesListID
                                .contains(selectedItem)) {
                              // If the item is already selected, remove it only if it is being deselected
                              if (!allSelectedItems.contains(selectedItem)) {
                                controller.selectedAmenitiesListID
                                    .remove(selectedItem);
                              }
                            } else {
                              // If the item is not selected, add it only if it is being selected
                              if (allSelectedItems.contains(selectedItem)) {
                                controller.selectedAmenitiesListID
                                    .add(selectedItem);
                              }
                            }
                            print(selectedItem);
                            print(controller.selectedAmenitiesListID.value);
                          });
                        }),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 14),
                  child: controller.isLoading.value == true
                      ? Center(
                          child: CupertinoActivityIndicator(
                              color: Colors.white, radius: 15),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            controller.isEditable.value == true
                                ? controller.updateOrganisation()
                                : controller.addOrgnition();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.business),
                              SizedBox(width: 8),
                              controller.isEditable.value == false
                                  ? Text(
                                      'Create Organization Profile',
                                      style: TextStyle(fontSize: 14.sp),
                                    )
                                  : Text(
                                      'Update Organization Profile',
                                      style: TextStyle(fontSize: 14.sp),
                                    )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 24.0),
                          ),
                        ),
                )),
                SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ),
    )));
  }
}

class AmenitiesButton extends StatelessWidget {
  var onPressed;
  final IconData iconData;
  final String text;

  AmenitiesButton({
    required this.onPressed,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 14),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(iconData),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
      ),
    );
  }
}

class TextFieldWithTitle extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  int? maxLength;
  final TextInputType inputType;
  final bool obscureText;
  final String? Function(String?)? validator;

  TextFieldWithTitle({
    required this.validator,
    this.maxLength,
    required this.title,
    required this.controller,
    this.inputType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  State<TextFieldWithTitle> createState() => _TextFieldWithTitleState();
}

class _TextFieldWithTitleState extends State<TextFieldWithTitle> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              maxLength: widget.maxLength,
              controller: widget.controller,
              keyboardType: widget.inputType,
              obscureText: widget.obscureText,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: InputBorder.none,
                hintText: "Enter ${widget.title}",
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              onChanged: (value) {
                if (widget.validator != null) {
                  setState(() {
                    _errorMessage = widget.validator!(value);
                  });
                }
              },
              validator: widget.validator,
              // added validator function
              onSaved: (value) {
                widget.controller.text = value!;
              },
            ),
          ),
          if (_errorMessage != null) // display error message if there is one
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class LocationButton extends StatefulWidget {
  @override
  _LocationButtonState createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  String _location = '';
  bool isLoading = false;
  AddOrganizationsEventController controller =
      Get.put(AddOrganizationsEventController());

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _location =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        controller.location.text = _location;
        isLoading = false;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(
            child: CupertinoActivityIndicator(
            radius: 15,
            color: Colors.white,
          ))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Fetch the current location
                    setState(() {
                      isLoading = true;
                    });
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    _getAddressFromLatLng(position);
                    setState(() {
                      controller.latitude = position.latitude;
                      controller.longitude = position.longitude;
                    });
                  },
                  child: Icon(
                    Icons.pin_drop,
                    color: Colors.red,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        controller.location.text.isEmpty
                            ? _location == ''
                                ? 'Location'
                                : _location
                            : controller.location.text,
                        style: _location == ''
                            ? TextStyle(
                                color: Colors.grey[400],
                                fontSize: 15.sp,
                                overflow: TextOverflow.fade,
                              )
                            : TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                overflow: TextOverflow.fade,
                              ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
