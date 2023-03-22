// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var data;
  bool isNotification = false;

  getAllNotification() async {
    http.Response response = await http.post(
        Uri.parse(
            'http://manage.partypeople.in/v1/notification/get_all_notification'),
        headers: {"x-access-token": GetStorage().read('token')});

    print(response.body);

    setState(() {
      data = jsonDecode(response.body);
      if (data['message'] == 'Notification Not Found.') {
        setState(() {
          isNotification = false;
        });
      } else {
        setState(() {
          isNotification = true;
        });
      }

      print(data['data'].length);
    });
  }

  @override
  void initState() {
    getAllNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        backgroundColor: Colors.red.shade900,
      ),
      body: isNotification == false
          ? Container(
              child: Center(
                child: Text("No Notification Found"),
              ),
            )
          : data['data'].length == 0
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: data['data'].length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text(
                            '${data['data'][index]['notification_title']}'),
                        subtitle: Text(
                            '${data['data'][index]['notification_message']}'),
                        tileColor: Colors.grey.shade200,
                      ),
                    );
                  }),
    );
  }
}
