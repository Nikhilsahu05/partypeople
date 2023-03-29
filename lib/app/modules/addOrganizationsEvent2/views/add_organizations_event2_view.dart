// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pertypeople/app/select_photo_options_screen.dart';
import 'package:pertypeople/cached_image_placeholder.dart';

import '../../../testing_screen.dart';
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
  final cropKey = GlobalKey<CropState>();

  Future<String?> savePhotoToFirebase(
      String tokenId, File photo, String imageName) async {
    try {
      setState(() {
        controller.isLoading.value = true;
      });
      await FirebaseAuth.instance.signInAnonymously();

      // Initialize Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;

      // Create a reference to the photo in Firebase Storage
      Reference photoRef =
          storage.ref().child('$tokenId/PartyPost/$imageName.jpg');

      // Upload the photo to Firebase Storage
      await photoRef.putFile(photo);

      // Get the download URL for the photo
      String downloadURL = await photoRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error saving photo to Firebase Storage: $e');
      return null;
    }
  }

  _pickImageProfile(ImageSource source) async {
    print("Picking Image");
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        savePhotoToFirebase(
                GetStorage().read('token'), img!, 'HostedEventPhoto')
            .then((value) {
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

  AddOrganizationsEvent2Controller controller =
      Get.put(AddOrganizationsEvent2Controller());

  fillFieldPreFilled() async {
    controller.timeline.value = '${controller.getPrefiledData['cover_photo']}';
    controller.title.text = controller.getPrefiledData['title'];
    controller.description.text = controller.getPrefiledData['description'];
    controller.mobileNumber.text = controller.getPrefiledData['phone_number'];
    controller.startDate.text = controller.getPrefiledData['start_date'];
    controller.endDate.text = controller.getPrefiledData['end_date'];
    controller.startTime.text = controller.getPrefiledData['start_time'];
    controller.endTime.text = controller.getPrefiledData['end_time'];
    controller.peopleLimit.text = controller.getPrefiledData['person_limit'];
    controller.genderList = [controller.getPrefiledData['gender']];
    controller.startPeopleAge.text = controller.getPrefiledData['start_age'];
    controller.endPeopleAge.text = controller.getPrefiledData['end_age'];
    controller.offersText.text = controller.getPrefiledData['offers'];
    controller.ladiesPrice.text = controller.getPrefiledData['ladies'];
    controller.stagPrice.text = controller.getPrefiledData['stag'];
    controller.othersPrice.text = controller.getPrefiledData['others'];
    controller.couplesPrice.text = controller.getPrefiledData['couples'];
  }

  nonField() {
    setState(() {
      controller.timeline.value = '';
      controller.title.text = '';
      controller.description.text = '';
      controller.mobileNumber.text = '';
      controller.startDate.text = '';
      controller.endDate.text = '';
      controller.startTime.text = '';
      controller.endTime.text = '';
      controller.peopleLimit.text = '';
      controller.startPeopleAge.text = '';
      controller.endPeopleAge.text = '';
      controller.offersText.text = '';
      controller.ladiesPrice.text = '';
      controller.stagPrice.text = '';
      controller.othersPrice.text = '';
      controller.couplesPrice.text = '';
    });
  }

  @override
  void initState() {
    if (controller.isEditable.value == true) {
      fillFieldPreFilled();
    } else {
      nonField();
    }
    print("Caling fill data");
    // fillFieldPreFilled();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Obx(
          () => SingleChildScrollView(
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
                              child: controller.timeline.value != ''
                                  ? Card(
                                      child: CachedNetworkImageWidget(
                                          imageUrl: controller.timeline.value,
                                          width: Get.width,
                                          height: 300,
                                          fit: BoxFit.fill,
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                                  radius: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                          placeholder: (context, url) => Center(
                                              child: CupertinoActivityIndicator(
                                                  color: Colors.black,
                                                  radius: 15))))
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile Number',
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
                            controller: controller.mobileNumber,
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                  height: 5,
                                  width: 5,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/indian_flag.png',
                                    ),
                                  )),
                              prefixText: ' +91 ',
                              prefixStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 18),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: InputBorder.none,
                              hintText: "Enter Mobile Number",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                            onChanged: (value) {},

                            // added validator function
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.isPopular.value == false
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
                                      title: 'End Time',
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
                      'Who can join',
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
        ));
  }
}

class AmenitiesButton extends StatelessWidget {
  AddOrganizationsEvent2Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Get.to(AmenitiesPartyScreen());
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
  final int? maxlength;
  final TextInputType inputType;
  final bool obscureText;
  final String? Function(String?)? validator;
  var passGesture;

  TextFieldWithTitle({
    required this.validator,
    this.passGesture,
    this.maxlength,
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
              maxLength: widget.maxlength,
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

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position!.latitude, position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _location =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
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
            color: Colors.black,
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
