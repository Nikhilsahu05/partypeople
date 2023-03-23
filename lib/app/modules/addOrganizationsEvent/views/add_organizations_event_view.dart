// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

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

  var amenitiesTitle = [''];
  List amenitiesIndexes = [];
  List selectedItemsAmenities = [];
  var jsonAddAmenitiesData;
  bool isLoading = false;

  getAmenities() async {
    setState(() {
      isLoading == true;
    });
    http.Response response = await http.get(
        Uri.parse(
            'https://manage.partypeople.in/v1/party/organization_amenities'),
        headers: {
          'x-access-token':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjUsImlhdCI6MTY3NTg2NTkxMH0.UAqwef4sbcFd2lt1gAaFPZU9KYg72tjrtqkWKc5Dq2M',
        });
    var jsonData = jsonDecode(response.body);
    print(response.body);
    setState(() {
      jsonAddAmenitiesData = jsonData['data'];
      amenitiesTitle.clear();
      for (var i = 0; i < jsonData['data'].length; i++) {
        setState(() {
          amenitiesList.add(MultiSelectCard(
              value: jsonAddAmenitiesData[i]['name'],
              label: jsonAddAmenitiesData[i]['name']));
        });
      }
      print(amenitiesTitle);
    });
    setState(() {
      isLoading == false;
    });
  }

  List<MultiSelectCard> amenitiesList = [];

  @override
  void initState() {
    getAmenities();
    _handleLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Obx(
      () => isLoading == true
          ? Center(
              child:
                  CupertinoActivityIndicator(color: Colors.white, radius: 15),
            )
          : Container(
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
                              fontSize: 26,
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
                            onTap: () =>
                                _showSelectPhotoOptionsTimeline(context),
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.maxFinite,
                                  child: controller.isEditable.value == true
                                      ? controller.timelinePicture?.path == null
                                          ? Card(
                                              child: Image.network(
                                                  'https://manage.partypeople.in/${controller.timeline}',
                                                  fit: BoxFit.fill),
                                            )
                                          : Card(
                                              child: Image.file(
                                                controller.timelinePicture!,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                      : controller.timelinePicture != null
                                          ? Card(
                                              child: Image.file(
                                                  controller.timelinePicture!,
                                                  fit: BoxFit.fill),
                                            )
                                          : Card(
                                              child: Lottie.asset(
                                                'assets/127619-photo-click.json',
                                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(99)),
                                      elevation: 5,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: controller.isEditable.value ==
                                                true
                                            ? controller.profilePicture?.path ==
                                                    null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.red.shade900,
                                                    maxRadius: 40,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      'https://manage.partypeople.in/${controller.profile}',
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.red.shade900,
                                                    maxRadius: 40,
                                                    backgroundImage: FileImage(
                                                        controller
                                                            .profilePicture!))
                                            : controller.profilePicture != null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.red.shade900,
                                                    maxRadius: 40,
                                                    backgroundImage: FileImage(
                                                        controller
                                                            .profilePicture!))
                                                : Container(
                                                    width: 50,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              99999),
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
                        title: 'Organization Name',
                        controller: controller.name,
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
                        title: 'Organization Description',
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
                        child: Text('Select Amenities',
                            style: TextStyle(
                              fontFamily: 'malgun',
                              fontSize: 18,
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
                              itemsPadding: EdgeInsets.all(10),
                              prefix: MultiSelectPrefix(
                                  selectedPrefix: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  disabledPrefix: Icon(
                                    Icons.do_disturb_alt_sharp,
                                    size: 14,
                                  )),
                              items: amenitiesList,
                              onChange: (allSelectedItems, selectedItem) {
                                setState(() {
                                  selectedItemsAmenities.add(selectedItem);
                                  print(amenitiesList);

                                  for (var i = 0;
                                      i < amenitiesList.length;
                                      i++) {
                                    if (amenitiesList[i].label ==
                                        selectedItem.toString()) {
                                      print(i);
                                      controller.selectedAmenitiesListID
                                          .add((i + 1).toString());

                                      print(amenitiesList[i].label);
                                    }
                                  }
                                });
                              }),
                        ),
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 14),
                        child: ElevatedButton(
                          onPressed: () {
                            if (timelineImage == null) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Please add timeline image",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (profileImage == null) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Please add profile image",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (controller.name.text.isEmpty) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Please enter a valid name",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (controller.description.text.isEmpty) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Please enter a valid organization description",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (controller.branches.text.isEmpty) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Please enter a valid branches",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (controller.location.text.isEmpty) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Please enter a valid location",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else if (amenitiesList.isEmpty) {
                              // Show a GetX Snackbar if the text field controller is empty
                              Get.snackbar(
                                "Error",
                                "Select at least 1 amenities",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else {
                              controller.addOrgnition();
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.business),
                              SizedBox(width: 8),
                              Text(
                                'Create Organization Profile',
                                style: TextStyle(fontSize: 16),
                              ),
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
  final TextInputType inputType;
  final bool obscureText;
  final String? Function(String?)? validator;

  TextFieldWithTitle({
    required this.validator,
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
              fontSize: 18,
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
              controller: widget.controller,
              keyboardType: widget.inputType,
              obscureText: widget.obscureText,
              style: TextStyle(
                fontSize: 16,
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
    await placemarkFromCoordinates(position!.latitude, position!.longitude)
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
                  },
                  child: Text('Get Location'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
                        _location == '' ? 'Location' : _location,
                        style: _location == ''
                            ? TextStyle(
                                color: Colors.grey[400],
                                fontSize: 18.0,
                                overflow: TextOverflow.ellipsis,
                              )
                            : TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
