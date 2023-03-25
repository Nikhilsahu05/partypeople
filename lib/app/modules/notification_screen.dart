// // ignore_for_file: prefer_typing_uninitialized_variables
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notification"),
//         backgroundColor: Colors.red.shade900,
//       ),
//       body: isNotification == false
//           ? Container(
//               child: Center(
//                 child: Text("No Notification Found"),
//               ),
//             )
//           : data['data'].length == 0
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: data['data'].length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: ListTile(
//                         leading: Icon(Icons.notifications),
//                         title: Text(
//                             '${data['data'][index]['notification_title']}'),
//                         subtitle: Text(
//                             '${data['data'][index]['notification_message']}'),
//                         tileColor: Colors.grey.shade200,
//                       ),
//                     );
//                   }),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> _notifications = [
    "John Doe liked your post.",
    "Jane Smith commented on your photo.",
    "Tom Brown mentioned you in a post.",
    "Mary Green started following you.",
    "David Lee shared a post with you.",
  ];

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
        title: Text("Notifications"),
      ),
      body: data == null
          ? Center(
              child: CupertinoActivityIndicator(
                color: Colors.black,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
                          size: 28.0,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data['data'][index]['notification_title']}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              '${data['data'][index]['notification_message']}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 16.0),
              itemCount: _notifications.length,
            ),
    );
  }
}
