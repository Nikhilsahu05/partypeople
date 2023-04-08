import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pertypeople/app/modules/popular_party_preview.dart';

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
        Uri.parse('https://manage.partypeople.in/v1/party/party_history'),
        headers: {'x-access-token': GetStorage().read('token')},
        body: {'organization_id': '1'});
    var decodedData = jsonDecode(response.body);
    if (decodedData['status'] == 1) {
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
        appBar: AppBar(
          title: Text("All Parties History"),
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
                : ListView.builder(
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
                        ),
                      );
                    }));
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

  CustomListTile({
    required this.title,
    required this.subtitle,
    required this.leadingImage,
    required this.startDate,
    required this.endDate,
    required this.trailingText,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(leadingImage),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "${DateFormat('EEEE, d MMMM').format(DateTime.parse(startDate))} - ${DateFormat('EEEE, d MMMM').format(DateTime.parse(endDate))}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.0),
        ],
      ),
    );
  }
}
