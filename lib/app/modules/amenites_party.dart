// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'addOrganizationsEvent2/controllers/add_organizations_event2_controller.dart';
import 'addamenities/controllers/addamenitiescontroller.dart';

class AddAmenitiesParty extends StatefulWidget {
  bool isPopular;
  var editProfileData;

  AddAmenitiesParty(
      {Key? key, required this.isPopular, required this.editProfileData})
      : super(key: key);

  @override
  State<AddAmenitiesParty> createState() => _AddAmenitiesPartyState();
}

class _AddAmenitiesPartyState extends State<AddAmenitiesParty> {
  AddOrganizationsEvent2Controller controller =
      Get.put(AddOrganizationsEvent2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.isPopular == true
              ? Text("Edit Amenities")
              : Text("Select Amenities"),
        ),
        body: Obx(
          () => SafeArea(
            child: controller.isLoading.value == true
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: Get.height,
                    child: GridCheck(
                        isPopular: widget.isPopular,
                        editData: widget.editProfileData),
                  ),
          ),
        ));
  }
}

class GridCheck extends StatefulWidget {
  bool isPopular;

  var editData;

  GridCheck({required this.isPopular, required this.editData});

  @override
  State<GridCheck> createState() => _GridCheckState();
}

class _GridCheckState extends State<GridCheck> {
  var amenitiesTitle = [''];
  var jsonAddAmenitiesData;
  List<MultiSelectCard> amenitiesListOthers = [];
  List<MultiSelectCard> amenitiesListMusic = [];
  List<MultiSelectCard> amenitiesListDressCode = [];
  List<MultiSelectCard> amenitiesListDrinks = [];

  getAmenities() async {
    http.Response response = await http.get(
        Uri.parse('https://manage.partypeople.in/v1/party/party_amenities'),
        headers: {
          'x-access-token': GetStorage().read("token").toString(),
        });
    var jsonData = jsonDecode(response.body);
    print(response.body);
    setState(() {
      jsonAddAmenitiesData = jsonData['data'];
      amenitiesTitle.clear();
      for (var ix = 0; ix < jsonData['data'][0].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              i == 3
                  ? amenitiesListMusic.add(MultiSelectCard(
                      enabled: true,
                      selected: true,
                      highlightColor: Colors.red,
                      value:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                      label:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'))
                  : amenitiesListMusic.add(MultiSelectCard(
                      highlightColor: Colors.red,
                      value:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                      label:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      for (var ix = 0; ix < jsonData['data'][1].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              i == 5
                  ? amenitiesListDrinks.add(MultiSelectCard(
                      enabled: true,
                      selected: true,
                      value:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                      label:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'))
                  : amenitiesListDrinks.add(MultiSelectCard(
                      value:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                      label:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      for (var ix = 0; ix < jsonData['data'][2].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              i == 4
                  ? amenitiesListDressCode.add(MultiSelectCard(
                      enabled: true,
                      selected: true,
                      value:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                      label:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'))
                  : amenitiesListDressCode.add(MultiSelectCard(
                      value:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                      label:
                          '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      for (var ix = 0; ix < jsonData['data'][3].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              amenitiesListOthers.add(MultiSelectCard(
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                      '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      print(amenitiesTitle);
    });
  }

  getAmenitiesNew() async {
    amenitiesListOthers.clear();
    amenitiesListDressCode.clear();
    amenitiesListMusic.clear();
    amenitiesListDrinks.clear();
    http.Response response = await http.get(
        Uri.parse('https://manage.partypeople.in/v1/party/party_amenities'),
        headers: {
          'x-access-token': GetStorage().read("token").toString(),
        });
    var jsonData = jsonDecode(response.body);
    print(response.body);
    setState(() {
      jsonAddAmenitiesData = jsonData['data'];
      amenitiesTitle.clear();
      for (var ix = 0; ix < jsonData['data'][0].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              amenitiesListMusic.add(MultiSelectCard(
                  highlightColor: Colors.red,
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                      '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      for (var ix = 0; ix < jsonData['data'][1].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              amenitiesListDrinks.add(MultiSelectCard(
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                      '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      for (var ix = 0; ix < jsonData['data'][2].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              amenitiesListDressCode.add(MultiSelectCard(
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                      '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      for (var ix = 0; ix < jsonData['data'][3].length; ix++) {
        setState(() {
          for (var i = 0; i < jsonData['data'][ix]['amenities'].length; i++) {
            setState(() {
              amenitiesListOthers.add(MultiSelectCard(
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                      '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
            });
          }
        });
      }
      print(amenitiesTitle);
    });
  }

  @override
  void initState() {
    if (widget.editData != '') {
      getAmenities();
    } else {
      getAmenitiesNew();
    }

    super.initState();
  }

  List<String> selectedAmenities = [];

  int selectedCard = 1;

  AddAmenitiesController addAmenitiesController =
      Get.put(AddAmenitiesController());

  AddOrganizationsEvent2Controller controller =
      Get.put(AddOrganizationsEvent2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: jsonAddAmenitiesData == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Text(
                        "Music",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: MultiSelectContainer(
                            suffix: MultiSelectSuffix(
                                selectedSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                disabledSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.do_disturb_alt_sharp,
                                    size: 14,
                                  ),
                                )),
                            items: amenitiesListMusic,
                            onChange: (allSelectedItems, selectedItem) {}),
                      ),
                      Text(
                        "Drinks",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: MultiSelectContainer(
                            suffix: MultiSelectSuffix(
                                selectedSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                disabledSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.do_disturb_alt_sharp,
                                    size: 14,
                                  ),
                                )),
                            items: amenitiesListDrinks,
                            onChange: (allSelectedItems, selectedItem) {}),
                      ),
                      Text(
                        "Dress Code",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: MultiSelectContainer(
                            suffix: MultiSelectSuffix(
                                selectedSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                disabledSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.do_disturb_alt_sharp,
                                    size: 14,
                                  ),
                                )),
                            items: amenitiesListDressCode,
                            onChange: (allSelectedItems, selectedItem) {}),
                      ),
                      Text(
                        "Other Facilites",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: MultiSelectContainer(
                            suffix: MultiSelectSuffix(
                                selectedSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                disabledSuffix: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.do_disturb_alt_sharp,
                                    size: 14,
                                  ),
                                )),
                            items: amenitiesListOthers,
                            onChange: (allSelectedItems, selectedItem) {}),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.isPopular == true) {
                            setState(() {
                              controller.startDate.text =
                                  widget.editData['start_date'];
                              controller.endDate.text =
                                  widget.editData['end_date'];
                              controller.startTime.text =
                                  widget.editData['start_time'];
                              controller.endTime.text =
                                  widget.editData['end_time'];
                            });
                            controller.sendEditParty(widget.editData, context);
                          } else {
                            controller.sendRequst();
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.red,
                          ),
                          width: 130,
                          child: Center(
                            child: Text(
                              widget.editData == '' ? 'Finish' : 'Update',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18,
                                color: const Color(0xffffffff),
                              ),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ])
                  ],
                ),
              ));
  }
}
