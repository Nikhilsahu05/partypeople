import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/modules/chatScreen/views/chat_screen_view.dart';
import 'package:pertypeople/app/modules/individualDashboard/controllers/individual_dashboard_controller.dart';
import 'package:pertypeople/app/modules/individualDrawer/views/individual_drawer_view.dart';
import 'package:pertypeople/app/modules/individualNotificationScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:like_button/like_button.dart';

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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          title: GestureDetector(
            onTap: () => Get.to(
              IndividualDrawerView(),
              duration: Duration(milliseconds: 500),
              transition: Transition.leftToRight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
              child: Image.asset('assets/side_drawer.png'),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 5.sp),
              child: GestureDetector(
                onTap: () => Get.to(
                  IndividualNotificationScreen(),
                  duration: Duration(milliseconds: 500),
                  transition: Transition.rightToLeft,
                ),
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
            tabs: [
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
                  text: 'Chat',
                  margin: EdgeInsets.only(left: 45),
                  onPressed: () {
                    Get.to(
                      ChatScreenView(),
                      duration: Duration(milliseconds: 500),
                      transition: Transition.downToUp,
                    );
                  }),
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
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.065),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: Get.height * 0.02),
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                      ),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                Get.width * 0.03,
                                                Get.height * 0.01),
                                            icon: Icon(Icons.search),
                                            hintText:
                                                'Search for Party, City or Location',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10.sp)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.005),
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
                    Container(
                      height: MediaQuery.of(context).size.width * 0.27,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.08),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {},
                              child: CityCard(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.11,
                          bottom: MediaQuery.of(context).size.height * 0.01),
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
                      height: MediaQuery.of(context).size.width * 0.27,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) => GestureDetector(
                              onTap: () {},
                              child: NearbyPeopleProfile(),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.03,
                      ),
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                          color: Color(0xFFa22d2d),
                          borderRadius: BorderRadius.circular(100.sp)),
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
                              child: ChoiceSelectionButton(
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
                              child: ChoiceSelectionButton(
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
                        top: Get.height * 0.005,
                      ),
                      child: Text(
                        'TODAY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: Get.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.09,
                        bottom: Get.width * 0.05,
                      ),
                      height: Get.width * 0.42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return partyCard(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.11,
                        top: Get.height * 0.005,
                      ),
                      child: Text(
                        'TOMORROW',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: Get.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.09,
                        bottom: Get.width * 0.05,
                      ),
                      height: Get.width * 0.42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return partyCard(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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

  GestureDetector partyCard(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.width * 0.02,
        ),
        width: MediaQuery.of(context).size.width * 0.38,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF802a2a),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
          image: DecorationImage(
              image: AssetImage('assets/img.png'), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                height: Get.width * 0.19,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp)),
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
                        style: TextStyle(color: Colors.red, fontSize: 7.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.width * 0.008,
                  ),
                  Text(
                    'Dance Party at My Home With Music',
                    style: TextStyle(color: Color(0xFF564d4d), fontSize: 7.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person_outlined,
                        size: 11.sp,
                      ),
                      SizedBox(
                        width: Get.width * 0.008,
                      ),
                      Text(
                        '15/30',
                        style: TextStyle(fontSize: 7.sp),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(right: Get.width * 0.028),
                  height: MediaQuery.of(context).size.width * 0.052,
                  width: MediaQuery.of(context).size.width * 0.135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.sp),
                    color: const Color(0xFFffa914),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15.sp,
                      ),
                      Text(
                        'Join',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                      SizedBox(
                        width: 3.sp,
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
  }
}

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Get.width * 0.0045),
            decoration: BoxDecoration(
                border: Border.all(
                  width: Get.width * 0.004,
                  color: Color(0xFFf69416),
                ),
                borderRadius: BorderRadius.circular(100.sp),
                color: Colors.white),
            child: CircleAvatar(
              radius: Get.width * 0.067,
              backgroundImage: AssetImage(
                'assets/a.jpeg',
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            'City',
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }
}

class NearbyPeopleProfile extends StatelessWidget {
  const NearbyPeopleProfile({
    super.key,
  });

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.015,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Container(
                width: Get.width * 0.151,
                height: Get.width * 0.151,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: Get.width * 0.005,
                    color: Color(0xFFe3661d),
                  ),

                  borderRadius: BorderRadius.circular(100.sp), //<-- SEE HERE
                ),
                child: Padding(
                  padding: EdgeInsets.all(Get.width * 0.006),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/img.png'),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Icon(
                    Icons.message,
                    size: MediaQuery.of(context).size.height * 0.02,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Text(
                    'Name',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: Get.height * 0.001,
            right: -Get.height * 0.006,
            child: Container(
              width: Get.height * 0.032,
              height: Get.height * 0.032,
              padding: EdgeInsets.only(
                left: Get.height * 0.0045,
                top: Get.height * 0.00045,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100.sp),
              ),
              child: LikeButton(
                onTap: onLikeButtonTapped,
                circleColor:
                    CircleColor(start: Colors.white, end: Color(0xFFe3661d)),
                size: Get.height * 0.022,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Color(0xFFf9090a) : Colors.white,
                    size: Get.height * 0.022,
                  );
                },
                bubblesColor: BubblesColor(
                  dotPrimaryColor: Color(0xff0099cc),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceSelectionButton extends StatelessWidget {
  ChoiceSelectionButton(
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
