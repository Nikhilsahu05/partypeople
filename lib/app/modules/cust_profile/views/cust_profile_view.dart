// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';

import '../../dashbord/controllers/dashbord_controller.dart';
import '../controllers/cust_profile_controller.dart';

class CustProfileView extends StatefulWidget {
  String views;
  String likes;
  String orgName;
  String city;
  String timelinePic;
  String organisationDesc;
  String circularDP;
  var amenities;

  CustProfileView(
      {required this.timelinePic,
      required this.circularDP,
      required this.amenities,
      required this.views,
      required this.likes,
      required this.city,
      required this.orgName,
      required this.organisationDesc});

  @override
  State<CustProfileView> createState() => _CustProfileViewState();
}

class _CustProfileViewState extends State<CustProfileView> {
  CustProfileController controller = Get.put(CustProfileController());

  DashbordController dashbordController = Get.find();
  List<MultiSelectCard> listOfAmenities = [];

  addAmentitesToList() {
    for (var i = 0; i < widget.amenities.length; i++) {
      listOfAmenities.add(MultiSelectCard(
          value: '${widget.amenities[i]['name']}',
          label: '${widget.amenities[i]['name']}'));
    }
  }

  @override
  void initState() {
    setState(() {
      addAmentitesToList();
      print(widget.amenities);
      controller.getProfile();
      print(controller.mobileNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          backgroundColor: Colors.red.shade900,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                    child: Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.maxFinite,
                      child: Card(
                        child: Image.network(
                          'https://manage.partypeople.in/${widget.timelinePic}',
                          fit: BoxFit.fill,
                        ),
                        elevation: 5,
                      ),
                    ),
                  ],
                )),
                Positioned(
                  bottom: 15,
                  left: MediaQuery.of(context).size.width * 0.35,
                  child: CircleAvatar(
                    maxRadius: 55,
                    backgroundImage: NetworkImage(
                        'https://manage.partypeople.in/${widget.circularDP}'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
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
                          '${widget.views} Views',
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
                          '${widget.likes}  Likes',
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
            Container(
              padding: EdgeInsets.only(top: 10),
              height: Get.height - 380,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full Name *',
                              style: TextStyle(
                                fontFamily: 'malgunBold',
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: -0.28,
                                height: 1.0714285714285714,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              softWrap: false,
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.orgName.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontFamily: 'malgunBold',
                                  fontSize: 14,
                                  color: Colors.white,
                                  letterSpacing: -0.28,
                                  height: 1.0714285714285714,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                softWrap: false,
                              ),
                              SizedBox(height: 10),
                              Text(
                                controller.mobileNumber.value,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Organization Description',
                              style: TextStyle(
                                fontFamily: 'malgunBold',
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: -0.28,
                                height: 1.0714285714285714,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              softWrap: false,
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.organisationDesc,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Organization Amenities',
                              style: TextStyle(
                                fontFamily: 'malgun',
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: -0.28,
                                height: 1.0714285714285714,
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              softWrap: false,
                            ),
                            SizedBox(height: 10),
                            //widget.amenities.length
                            //widget.amenities[index]['name']
                            Container(
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
                                  items: listOfAmenities,
                                  onChange:
                                      (allSelectedItems, selectedItem) {}),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ]),
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
        boxShadow: [
          BoxShadow(
            color: const Color(0x59000000),
            offset: Offset(-6.123234262925839e-17, 1),
            blurRadius: 27,
          ),
        ],
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
        ],
      ),
    );
  }
}
