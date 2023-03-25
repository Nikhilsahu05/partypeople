// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pertypeople/app/select_photo_options_screen.dart';

import '../../addOrganizationsEvent/controllers/add_organizations_event_controller.dart';
import '../controllers/add_organizations_event2_controller.dart';

//
// class AddOrganizationsEvent2View
//     extends GetView<AddOrganizationsEvent2Controller> {
//
class AddOrganizationsEvent2View extends StatefulWidget {
  bool isPopular;

  AddOrganizationsEvent2View({required this.isPopular});

  @override
  State<AddOrganizationsEvent2View> createState() =>
      _AddOrganizationsEvent2ViewState();
}

class _AddOrganizationsEvent2ViewState
    extends State<AddOrganizationsEvent2View> {
  @override
  void initState() {
    print('is this popular party ::: ${widget.isPopular}');
    super.initState();
  }

  String? _currentAddress;
  Position? _currentPosition;

  final cropKey = GlobalKey<CropState>();
  File? _image;

  _pickImageProfile(ImageSource source) async {
    print("Picking Image");
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        print("Image profile ==> ${controller.profile?.path}");

        _image = img;
        controller.profile = _image;
        print("Image profile ==> ${controller.profile?.path}");
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    print('Croped Image');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
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
                        'Host New Event',
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
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => _showSelectPhotoOptionsProfile(context),
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.maxFinite,
                          child: controller.profile != null
                              ? Card(
                                  child: Image.file(controller.profile!,
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
                                _showSelectPhotoOptionsProfile(context);
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
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWithTitle(
                title: 'Party Title',
                controller: controller.title,
                inputType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an party title';
                  } else {
                    return null;
                  }
                },
              ),
              TextFieldWithTitle(
                title: 'Party Description',
                controller: controller.description,
                inputType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an party description';
                  } else {
                    return null;
                  }
                },
              ),
              widget.isPopular == false
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getStartDate(context);
                                },
                                child: TextFieldWithTitle(
                                  title: 'Start Date',
                                  passGesture: () {
                                    controller.getStartDate(context);
                                  },
                                  controller: controller.startDate,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an start date';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getEndDate(context);
                                },
                                child: TextFieldWithTitle(
                                  title: 'End Date',
                                  passGesture: () {
                                    controller.getEndDate(context);
                                  },
                                  controller: controller.endDate,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an end date';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getStartTime(context);
                                },
                                child: TextFieldWithTitle(
                                  passGesture: () {
                                    controller.getStartTime(context);
                                  },
                                  title: 'Start Time',
                                  controller: controller.startTime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an start time';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  controller.getEndTime(context);
                                },
                                child: TextFieldWithTitle(
                                  passGesture: () {
                                    controller.getEndTime(context);
                                  },
                                  title: 'End Date',
                                  controller: controller.endTime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an end time';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
              LocationButton(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'malgun',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: GroupButton(
                  isRadio: false,
                  onSelected: (string, index, isSelected) {
                    print('$index button is selected');
                    print('$index button is selected');
                    if (isSelected) {
                      controller.genderList.add(string);
                    } else {
                      controller.genderList.remove(string);
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
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: 'Start Age',
                      controller: controller.startPeopleAge,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an start age';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: 'End Age',
                      inputType: TextInputType.number,
                      controller: controller.endPeopleAge,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an end age';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              TextFieldWithTitle(
                title: 'Party People Limit',
                controller: controller.peopleLimit,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter people limit';
                  } else {
                    return null;
                  }
                },
              ),
              TextFieldWithTitle(
                title: 'Offers',
                controller: controller.offersText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter offers';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: 'Ladies Fees',
                      inputType: TextInputType.number,
                      controller: controller.ladiesPrice,
                      validator: (value) {},
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: 'Stag Fees',
                      controller: controller.stagPrice,
                      inputType: TextInputType.number,
                      validator: (value) {},
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWithTitle(
                      title: 'Couple Fees',
                      inputType: TextInputType.number,
                      controller: controller.couplesPrice,
                      validator: (value) {},
                    ),
                  ),
                  Expanded(
                    child: TextFieldWithTitle(
                      title: 'Others Fees',
                      inputType: TextInputType.number,
                      controller: controller.othersPrice,
                      validator: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: AmenitiesButton()),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AmenitiesButton extends StatelessWidget {
  AddOrganizationsEvent2Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        controller.sendRequst();
      },
      icon: Icon(
        Icons.grid_view,
        color: Colors.white,
      ),
      label: Text(
        'Select Amenities',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        minimumSize: Size(180, 50),
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
  var passGesture;

  TextFieldWithTitle({
    required this.validator,
    this.passGesture,
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
              fontFamily: 'malgun',
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
              onTap: widget.passGesture,
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
