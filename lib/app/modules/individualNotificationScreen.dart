import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class IndividualNotificationScreen extends StatefulWidget {
  const IndividualNotificationScreen({Key? key}) : super(key: key);

  @override
  _IndividualNotificationScreenState createState() =>
      _IndividualNotificationScreenState();
}

class _IndividualNotificationScreenState
    extends State<IndividualNotificationScreen> {
  var data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
        body: data == null
            ? Center(
                child: CupertinoActivityIndicator(
                  color: Colors.black,
                  radius: Get.width * 0.03,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (BuildContext context, int index) {
                  DateTime notificationCreatedOn = DateTime.parse(
                      data['data'][index]['notification_created_on']);

                  String formattedDateTime = DateFormat('h:mm a, EEE, d/MM/y')
                      .format(notificationCreatedOn);
                  return data['data'] != null
                      ? Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.grey[800],
                                child: Icon(
                                  Icons.notifications,
                                  size: 22.0,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data['data'][index]['notification_title']}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'malgun',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        '${data['data'][index]['notification_message']}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'malgun',
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        '$formattedDateTime',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'malgun',
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 16.0),
                itemCount: data['data'].length,
              ),
      ),
    );
  }
}
