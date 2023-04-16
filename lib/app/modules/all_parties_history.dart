import 'dart:convert';

import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pertypeople/app/modules/popular_party_preview.dart';
import 'package:sizer/sizer.dart';

class AllPartiesHistory extends StatefulWidget {
  const AllPartiesHistory({Key? key}) : super(key: key);

  @override
  State<AllPartiesHistory> createState() => _AllPartiesHistoryState();
}

class _AllPartiesHistoryState extends State<AllPartiesHistory> {
  var data;
  String status = '0';
  bool isLoading = false;

  getAllPartiesHistory() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.post(
        Uri.parse('http://app.partypeople.in/v1/party/party_history'),
        headers: {'x-access-token': GetStorage().read('token')},
        body: {'organization_id': '1'});
    var decodedData = jsonDecode(response.body);
    if (decodedData['status'] == 1) {
      print('decodedData');
      print(decodedData);
      setState(() {
        data = decodedData['data'];
        status = decodedData['status'].toString();
      });
    } else {
      setState(() {
        status = decodedData['status'].toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getAllPartiesHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: isLoading == true
          ? Center(
          child: CupertinoActivityIndicator(
            radius: 15,
            color: Colors.black,
          ))
          : status == '0'
          ? Center(
        child: Text("No Data Found"),
      )
          : Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(1, -0.45),
                radius: 0.9,
                colors: [
                  const Color(0xff7e160a),
                  const Color(0xff2e0303),
                ],
                stops: [0.0, 1],
                transform: GradientXDTransform(
                  0.0,
                  -1.0,
                  1.23,
                  0.0,
                  -0.115,
                  1.0,
                  Alignment(0.0, 0.0),
                ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(PopularPartyPreview(
                      data: data[index], isPopularParty: false));
                },
                child: CustomListTile(
                  endDate: '${data[index]['end_date']}',
                  startDate: '${data[index]['start_date']}',
                  title: '${data[index]['title']}',
                  subtitle: '${data[index]['description']}',
                  trailingText: "Trailing Text",
                  leadingImage: '${data[index]['cover_photo']}',
                  leadingIcon: Icon(Icons.history),
                  trailingIcon: Icon(Icons.add),
                  city: '${data[index]['city_id']}',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leadingImage;
  final String trailingText;
  final Widget leadingIcon;
  final String startDate;
  final String endDate;
  final Widget trailingIcon;
  final String city;

  CustomListTile({
    required this.title,
    required this.subtitle,
    required this.leadingImage,
    required this.startDate,
    required this.endDate,
    required this.trailingText,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery
              .of(context)
              .size
              .width * 0.08,
          right: MediaQuery
              .of(context)
              .size
              .width * 0.08,
          bottom: MediaQuery
              .of(context)
              .size
              .width * 0.07),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF3c0103),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 110, 19, 9),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .width * 0.07,
                    vertical: MediaQuery
                        .of(context)
                        .size
                        .height * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title.length > 1
                          ? title[0].toUpperCase() + title.substring(1)
                          : title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFFd3b2b1),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0.sp,
                      ),
                    ),

                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Color(0xFFd3b2b1),
                          size: 13.sp,
                        ),
                        SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.015,
                        ),
                        Text(
                          "${DateFormat('MMM d, yyyy').format(DateTime.parse(
                              startDate))}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.25,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image(
                  image: CachedNetworkImageProvider(leadingImage),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
