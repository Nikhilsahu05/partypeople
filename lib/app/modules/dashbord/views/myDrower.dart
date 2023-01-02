// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/routes/app_pages.dart';

// ignore: camel_case_types
class myDrawer extends StatelessWidget {
  const myDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("Apana City"),
              accountEmail: Text("apanacity1@gmail.com"),
              currentAccountPicture:
                  CircleAvatar(backgroundImage: AssetImage("assets/aa.png"))),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("My Profile"),
            onTap: () {
              Get.toNamed(Routes.CUST_PROFILE);
            },
          ),
          ListTile(
            leading: Icon(Icons.location_city_outlined),
            title: Text("My Account"),
            onTap: () {
              // Get.to(LoginDemo());
            },
          ),
          ListTile(
            leading: Icon(Icons.location_city_outlined),
            title: Text("Feedback"),
            onTap: () {
              // Get.to(Enquiry());
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text("Contack us"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text("Are you a vendor?"),
          )
        ],
      ),
    );
  }
}
