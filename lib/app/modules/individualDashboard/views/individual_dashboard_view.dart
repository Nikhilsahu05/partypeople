import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/modules/individualDashboard/controllers/individual_dashboard_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class IndividualDashboardView extends StatefulWidget {
  const IndividualDashboardView({super.key});

  @override
  State<IndividualDashboardView> createState() =>
      _IndividualDashboardViewState();
}

class _IndividualDashboardViewState extends State<IndividualDashboardView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
              child: Image.asset('assets/side_drawer.png'),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 5.sp),
              child: GestureDetector(
                child: Image.asset(
                  'assets/notification.png',
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFFffa914),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          height: 70,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          color: Color(0xFF5a0404),
          child: GNav(
            padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 6.sp),
            gap: 5,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xFF802a2a),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                margin: EdgeInsets.only(right: 35),
              ),
              GButton(
                icon: Icons.message,
                text: 'Message',
                margin: EdgeInsets.only(left: 45),
              ),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(1, -0.45),
                  radius: 0.9,
                  colors: [
                    const Color(0xffb80b0b),
                    const Color(0xff390202),
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
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.search),
                                              labelText:
                                                  'Search for Party, City or Location',
                                              labelStyle: TextStyle(
                                                  color: Color(0xFF7d7373),
                                                  fontSize: 9.sp)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                    color: Color(0xFFffa914),
                                    borderRadius: BorderRadius.circular(10.sp)),
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Image.asset(
                                  'assets/filter.png',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.08),
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.sp,
                                      backgroundImage: AssetImage(
                                        'assets/img.png',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.sp,
                                    ),
                                    Text(
                                      'City',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.12,
                          top: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(
                        'People Nearby',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 135, 19, 19),
                            Color(0xFF711b1b),
                          ],
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.14,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.08),
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.sp,
                                      backgroundImage:
                                          AssetImage("assets/img.png"),
                                      child: Stack(children: [
                                        Positioned(
                                            top: 0.sp,
                                            right: 0.sp,
                                            child: Icon(
                                              Icons.circle,
                                              color: Colors.red,
                                              size: 14.sp,
                                            )),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 6.sp,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.message_outlined,
                                          size: 13.sp,
                                        ),
                                        SizedBox(
                                          width: 3.sp,
                                        ),
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.03,
                      ),
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                          color: Color(0xFFa22d2d),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Get.find<IndividualDashboardController>()
                                      .switchButtonState();
                                });
                              },
                              child: choiceSelectionButton(
                                buttonState:
                                    Get.find<IndividualDashboardController>()
                                        .buttonState,
                                textVal: 'Individuals',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Get.find<IndividualDashboardController>()
                                      .switchButtonState();
                                });
                              },
                              child: choiceSelectionButton(
                                buttonState:
                                    !Get.find<IndividualDashboardController>()
                                        .buttonState,
                                textVal: 'Organizations',
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.11,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.005),
                      child: Text(
                        'TODAY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.sp, vertical: 16.sp),
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.sp),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 10,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/img.png",
                                      width: 200,
                                      height: 400,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 5.sp),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Column(children: [
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'TODAY - ',
                                              style: TextStyle(fontSize: 7.sp),
                                            ),
                                            Text(
                                              '08:00 PM',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 7.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Text(
                                          'Dance Party at My Home With Music',
                                          style: TextStyle(
                                              color: Color(0xFF564d4d),
                                              fontSize: 8.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.person_outlined,
                                              size: 11.sp,
                                            ),
                                            SizedBox(
                                              width: 3.sp,
                                            ),
                                            Text(
                                              '15/30',
                                              style: TextStyle(fontSize: 8.sp),
                                            ),
                                            SizedBox(
                                              width: 4.sp,
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.08,
                                    right: MediaQuery.of(context).size.width *
                                        0.02,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xFFffa914),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15.sp,
                                            ),
                                            Text(
                                              'Join',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.11,
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.005),
                      child: Text(
                        'TOMORROW',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.sp, vertical: 16.sp),
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.sp),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 10,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/img.png",
                                      width: 200,
                                      height: 400,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 5.sp),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Column(children: [
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'TODAY - ',
                                              style: TextStyle(fontSize: 7.sp),
                                            ),
                                            Text(
                                              '08:00 PM',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 7.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Text(
                                          'Dance Party at My Home With Music',
                                          style: TextStyle(
                                              color: Color(0xFF564d4d),
                                              fontSize: 8.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.person_outlined,
                                              size: 11.sp,
                                            ),
                                            SizedBox(
                                              width: 3.sp,
                                            ),
                                            Text(
                                              '15/30',
                                              style: TextStyle(fontSize: 8.sp),
                                            ),
                                            SizedBox(
                                              width: 4.sp,
                                            ),
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.08,
                                    right: MediaQuery.of(context).size.width *
                                        0.02,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xFFffa914),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15.sp,
                                            ),
                                            Text(
                                              'Join',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class choiceSelectionButton extends StatelessWidget {
  choiceSelectionButton(
      {super.key, required this.buttonState, required this.textVal});
  var buttonState;
  final textVal;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: buttonState == true ? Colors.white : Color(0xFFa22d2d),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          textVal,
          style: TextStyle(
              color: buttonState == true ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp),
        ),
      ),
    );
  }
}
