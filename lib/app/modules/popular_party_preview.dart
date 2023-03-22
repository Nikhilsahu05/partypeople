// ignore_for_file: must_be_immutable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pertypeople/app/modules/edit_party_screen.dart';
import 'package:pertypeople/app/modules/subscription/views/subscription_view.dart';
import 'package:share_plus/share_plus.dart';

class PopularPartyPreview extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  int index;
  bool isPopularParty;

  PopularPartyPreview(
      {required this.data, required this.index, required this.isPopularParty});

  @override
  State<PopularPartyPreview> createState() => _PopularPartyPreviewState();
}

class _PopularPartyPreviewState extends State<PopularPartyPreview> {
  var amenitiesTitle = [''];
  var jsonAddAmenitiesData;
  List<MultiSelectCard> amenitiesListOthers = [];

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

      for (var ix = 0; ix < jsonData['data'][3].length; ix++) {
        setState(() {
          for (var i = 0; i < 5; i++) {
            setState(() {
              amenitiesListOthers.add(MultiSelectCard(
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                      '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
              amenitiesListOthers.reversed;
            });
          }
        });
      }
      print(amenitiesTitle);
    });
  }

  @override
  void initState() {
    getAmenities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        Container(
                          height: 250,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://manage.partypeople.in/${widget.data['cover_photo']}'))),
                        ),
                        Container(
                          height: 50,
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.red.shade900,
                                )),
                            trailing: Container(
                              height: 100,
                              width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Share.share('${widget.data['title']}');
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.share,
                                            color: Colors.black,
                                          ))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          width: double.maxFinite,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "${widget.data['title']}",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "${widget.data['description']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                '${widget.data['view']} Views',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 18,
                                  color: const Color(0xff7d7373),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                '${widget.data['like']}  Likes',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 18,
                                  color: const Color(0xff7d7373),
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                              ),
                            ],
                          ),
                        ]),
                  ),
                  ListTile(
                    enabled: true,
                    leading: Icon(Icons.date_range, color: Colors.red.shade900),
                    title: Text(
                      "${DateFormat.yMEd().format(DateTime.parse(widget.data['start_date']))} to ${DateFormat.yMEd().format(DateTime.parse(widget.data['end_date']))}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    enabled: true,
                    leading: Icon(Icons.timer, color: Colors.red.shade900),
                    title: Text(
                      "${widget.data['start_time']} to ${widget.data['end_time']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    enabled: true,
                    leading: Icon(Icons.person, color: Colors.red.shade900),
                    title: Text(
                      "AGE :${widget.data['start_age']} - ${widget.data['end_age']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    enabled: true,
                    leading: Icon(Icons.person, color: Colors.red.shade900),
                    title: Text(
                      "Persons Limit :${widget.data['person_limit']}",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: MultiSelectContainer(
                        maxSelectableCount: 0,
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
                  widget.data['papular_status'] != '1'
                      ? Center(
                          child: GestureDetector(
                            onTap: () async {
                              // showCustomDialog(context);
                              Get.to(SubscriptionView(
                                id: widget.data['id'],
                                data: widget.data,
                              ));
                            },
                            child: Container(
                              width: 180,
                              height: 60,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-1.183, -0.74),
                                    end: Alignment(1.071, -0.079),
                                    colors: [
                                      Colors.pink,
                                      Colors.purple,
                                      Colors.pink,
                                    ],
                                    stops: [0.0, 0.564, 1.0],
                                  ),
                                  borderRadius: BorderRadius.circular(45)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 35,
                                        child:
                                            Image.asset('assets/shuttle.png')),
                                    Text(
                                      "Boost Post".toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.29,
                right: 10,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(EditProfileScreen(
                          isPopularParty: widget.isPopularParty,
                          editProfileData: widget.data));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(40)),
                        width: 75,
                        child: Center(
                            child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ))),
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
