import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VisitInfoView extends StatefulWidget {
  const VisitInfoView({super.key});

  @override
  State<VisitInfoView> createState() => _VisitInfoViewState();
}

class _VisitInfoViewState extends State<VisitInfoView> {
  @override
  Widget build(BuildContext context) {
    var tabBarItem = TabBar(
      indicatorColor: Color(0xFF6e87f7),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 3.sp,
      labelColor: Color(0xFF323232),
      unselectedLabelColor: Color(0xFFc4c4c4),
      tabs: [
        Tab(
          child: Text(
            'Visitors',
          ),
        ),
        Tab(
          text: 'Visited',
        ),
        Tab(
          text: 'Liked',
        ),
      ],
    );

    var listItem = ListView.builder(
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return profileContainer(userName: 'Bennn', time: '09:09');
      },
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shape:
              Border(bottom: BorderSide(color: Color(0xFFc4c4c4), width: 1.sp)),
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            alignment: Alignment.centerLeft,
            enableFeedback: true,
            icon: Icon(Icons.arrow_back_ios),
            color: Color(0xFF4b4b4b),
            onPressed: () {},
            iconSize: 16.sp,
          ),
          titleSpacing: 0,
          elevation: 0,
          title: Text(
            'Visit Info',
            style: TextStyle(color: Color(0xFF4b4b4b), fontSize: 20.sp),
          ),
          bottom: tabBarItem,
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  'Only shows visitors from the past month',
                  style: TextStyle(fontSize: 10.sp, color: Color(0xFFc4c4c4)),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Expanded(child: listItem),
              ],
            ),
            listItem,
            listItem,
          ],
        ),
      ),
    );
  }
}

class profileContainer extends StatelessWidget {
  profileContainer({required this.userName, required this.time});

  String userName;
  String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.sp,
                backgroundImage: AssetImage("assets/img.png"),
                child: Stack(children: [
                  Positioned(
                    bottom: 3.sp,
                    child: CircleAvatar(
                        radius: 6.sp,
                        backgroundImage: AssetImage('assets/indian_flag.png')),
                  ),
                ]),
              ),
              SizedBox(
                width: 15.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Color(0xFF434343),
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'DUMMY TEXT',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Color(0xFF434343),
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 10.sp, color: Color(0xFFc4c4c4)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Color(0xFFc4c4c4),
          height: 0.4.sp,
          width: MediaQuery.of(context).size.width * 0.73,
        )
      ],
    );
  }
}
