import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/city_wise_party_controller.dart';

class CityWisePartyView extends GetView<CityWisePartyController> {
  const CityWisePartyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.183, -0.74),
            end: Alignment(1.071, -0.079),
            colors: [
              const Color(0xffd10e0e),
              const Color(0xff870606),
              const Color(0xff300202)
            ],
            stops: [0.0, 0.564, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 160,
                          height: 43,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(9.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 18),
                                blurRadius: 11,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // GetStorage().remove('token');
                            // Get.offAllNamed(Routes.HOME);
                          },
                          child: Container(
                            height: 40,
                            width: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xffffa914),
                              borderRadius: BorderRadius.circular(9.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 18),
                                  blurRadius: 11,
                                ),
                              ],
                            ),
                            child:
                                Center(child: Image.asset('assets/filter.png')),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'DELHI (NCR) TODAY',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 13.sp,
                        color: const Color(0xffffffff),
                        letterSpacing: 0.16,
                        height: 1.375,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 91,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: BoxDecoration(
                              color: const Color(0xff3c0202),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(0, 21),
                                  blurRadius: 50,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sports Meet in Galaxy Field',
                                      style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 11.sp,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      softWrap: false,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Jan 12, 2019',
                                          style: TextStyle(
                                            fontFamily: 'Muli',
                                            fontSize: 7.sp,
                                            color: const Color(0xffffffff),
                                          ),
                                          softWrap: false,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Greenfields, Sector 42, Faridabad',
                                          style: TextStyle(
                                            fontFamily: 'Muli',
                                            fontSize: 7.sp,
                                            color: const Color(0xffffffff),
                                          ),
                                          softWrap: false,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              child: Image.asset('assets/imgParty.png'))
                        ],
                      ),
                    )
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: 1,
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         height: 100,
                    //         width: 100,
                    //         color: Colors.red,
                    //       );
                    //     })
                  ],
                ),
              ),
              Positioned(
                top: 45,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DRAWER);
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                top: 45,
                right: 10,
                child: Image.asset(
                  'assets/bell.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff5A0404),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: 79,
                decoration: BoxDecoration(
                  /// color: Color(0xff3B0101),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: TextButton.icon(
                      onPressed: () {
                        Get.offAndToNamed(Routes.DASHBORD);
                      },
                      icon: Icon(Icons.home, color: Color(0xff7D7373)),
                      label: Text(
                        "Home".tr,
                        style:
                            TextStyle(color: Color(0xff7D7373), fontSize: 7.sp),
                      )),
                ),
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Color(0xff7D7373),
                  ),
                  label: Text(
                    "".tr,
                    style: TextStyle(color: Colors.white, fontSize: 7.sp),
                  )),
              SizedBox(
                width: 10,
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat,
                    color: Color(0xff7D7373),
                  ),
                  label: Text(
                    "".tr,
                    style: TextStyle(color: Colors.white, fontSize: 7.sp),
                  )),
              TextButton.icon(
                  onPressed: () {
                    Get.toNamed(Routes.PROFILE);
                  },
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xff7D7373),
                  ),
                  label: Text(
                    "".tr,
                    style: TextStyle(color: Colors.white, fontSize: 7.sp),
                  )),
            ],
          ),
        ),
        shape: const CircularNotchedRectangle(),
        elevation: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-event');
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffFFA914),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
