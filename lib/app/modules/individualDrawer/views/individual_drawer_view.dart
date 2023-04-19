import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/modules/individualDashboard/views/individual_dashboard_view.dart';
import 'package:sizer/sizer.dart';

class IndividualDrawerView extends StatefulWidget {
  IndividualDrawerView({
    Key? key,
  });

  @override
  State<IndividualDrawerView> createState() => _IndividualDrawerViewState();
}

class _IndividualDrawerViewState extends State<IndividualDrawerView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Get.back(),
            ),
            backgroundColor: Colors.red.shade900,
            elevation: 0,
            title: Text(
              "My Profile",
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
          ),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(children: [
                  CustomOptionWidget(
                    title: 'Edit Profile',
                    icon: Icons.edit,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Frequently Asked Questions',
                    icon: Icons.question_answer,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Need Any Help?',
                    icon: Icons.help_center,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Settings',
                    icon: Icons.settings,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Party History',
                    icon: Icons.history,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Blocked/Reported',
                    icon: Icons.block,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Likes and Views',
                    icon: Icons.view_agenda,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Reminder',
                    icon: Icons.alarm,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Party Planner Toolkit',
                    icon: Icons.stay_primary_portrait,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Feedback and ratings',
                    icon: Icons.feedback,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Previous guests List',
                    icon: Icons.list,
                    onTap: () {},
                  ),
                  CustomOptionWidget(
                    title: 'Contact information',
                    icon: Icons.contact_page,
                    onTap: () {},
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}

class CustomOptionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  CustomOptionWidget({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24.0,
                color: Colors.red.shade900,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16.0,
                color: Colors.grey[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
