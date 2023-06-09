import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../controllers/dashbord_controller.dart';

class DashbordView extends GetView<DashbordController> {
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
                              child: Center(
                                  child: Image.asset('assets/filter.png')),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        width: Get.width,
                        child: Obx(() => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,

                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.getCitys.length + 1,
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            // Get.toNamed(Routes.CITY_WISE_PARTY,
                                            //     arguments: controller
                                            //         .getCitys[index + 1].id);
                                            Get.toNamed(Routes.SUBSCRIPTION);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SizedBox(
                                                  height: 60,
                                                  width: 60,
                                                  child: Image.asset(
                                                      'assets/nearby.png'),
                                                ),
                                              ),
                                              Text(
                                                "Near By"
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: 'malgun',
                                                  fontSize: 7.sp,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  height: 1.25,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                softWrap: true,
                                              ),
                                            ],
                                          )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            controller.getTodayIndParty(
                                                city: controller
                                                    .getCitys[index - 1].id);
                                            controller.getTodayOrgParty(
                                                city: controller
                                                    .getCitys[index - 1].id);
                                            controller.getTommarowOrgPrty(
                                                city: controller
                                                    .getCitys[index - 1].id);
                                            controller.getTommarowIndPrty(
                                                city: controller
                                                    .getCitys[index - 1].id);
                                            // controller.getAllCitys();
                                            controller.nearByUsers(
                                                city: controller
                                                    .getCitys[index - 1].id);
                                            // Get.toNamed(Routes.SUBSCRIPTION);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: CircleAvatar(
                                                    radius: 100,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      // ignore: prefer_interpolation_to_compose_strings
                                                      'http://app.partypeople.in/' +
                                                          controller
                                                              .getCitys[
                                                                  index - 1]
                                                              .image,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                controller
                                                    .getCitys[index - 1].name
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: 'malgun',
                                                  fontSize: 7.sp,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  height: 1.25,
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                softWrap: true,
                                              ),
                                            ],
                                          )),
                                    );
                            })),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'People nearby ',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 15.sp,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 90,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(126, 167, 46, 46),
                        ),
                        child: Obx(() => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,

                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.nearByUser.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          controller.nearByUser[index]
                                                      ['profile_picture'] !=
                                                  ''
                                              ? CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      ('http://app.partypeople.in/${controller.nearByUser[index]['profile_picture']}')))
                                              : Image.asset('assets/Image.png'),
                                          // Image.asset('assets/Image.png'),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            controller.nearByUser[index]
                                                    ['first_name']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'malgun',
                                              fontSize: 7.sp,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              height: 1.25,
                                            ),
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        false),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            })),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Color(0xffA72E2E),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Obx(
                                () => controller.isindividualSelected.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Individuals',
                                              style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontSize: 15.sp,
                                                color: const Color(0xff3a3732),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: false,
                                            )),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.isindividualSelected
                                                  .value = false;
                                              controller.count.value = 8;
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 130,
                                              child: Center(
                                                child: Text(
                                                  'Organizations',
                                                  style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontSize: 15.sp,
                                                    color:
                                                        const Color(0xfffffdfb),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              print("individual");
                                              controller.isindividualSelected
                                                  .value = true;
                                              controller.count.value = 9;
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 130,
                                              child: Center(
                                                child: Text(
                                                  'Individuals',
                                                  style: TextStyle(
                                                    fontFamily: 'Oswald',
                                                    fontSize: 15.sp,
                                                    color:
                                                        const Color(0xfffffdfb),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Organizations',
                                              style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontSize: 15.sp,
                                                color: const Color(0xff3a3732),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              softWrap: false,
                                            )),
                                          ),
                                        ],
                                      ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'TODAY',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 15.sp,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Obx(() => controller.count.value != 0
                          ? TodayData(
                              controller: controller,
                            )
                          : Container()),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'TOMORROW',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 15.sp,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Obx(() => controller.count.value != 0
                          ? TommarowData(
                              controller: controller,
                            )
                          : Container()),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'My Party',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 15.sp,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Obx(() => controller.count.value != 0
                          ? UserData(
                              controller: controller,
                            )
                          : Container()),
                    ],
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ORGANIZATION_MENU,
                          arguments: controller.data);
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
          )),
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
                  color: Color(0xff3B0101),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Home".tr,
                        style: TextStyle(color: Colors.white, fontSize: 6.sp),
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

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DashbordController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: Get.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,

          // physics: NeverScrollableScrollPhysics(),
          itemCount: controller.isindividualSelected.value
              ? controller.getindividualData?.data.length ?? 0
              : controller.getGrupData?.data.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.VIEW_EVENT,
                      arguments: controller.isindividualSelected.value
                          ? controller.getindividualData!.data[index]
                          : controller.getGrupData!.data[index]);
                },
                child: Stack(
                  children: [
                    Container(
                      height: 160,
                      width: 171,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13.0),
                        child: Image.network(
                          controller.isindividualSelected.value
                              ? 'http://app.partypeople.in/${controller.getindividualData!.data[index].coverPhoto}'
                              : 'http://app.partypeople.in/${controller.getGrupData!.data[index].coverPhoto}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 171,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 20.0, right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 6.sp,
                                        color: const Color(0xff564d4d),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'TODAY - ',
                                        ),
                                        TextSpan(
                                          text: controller
                                                  .isindividualSelected.value
                                              ? controller.getindividualData!
                                                  .data[index].startTime
                                              : controller.getGrupData!
                                                  .data[index].startTime,
                                          style: TextStyle(
                                            color: const Color(0xffc40d0d),
                                          ),
                                        ),
                                      ],
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    softWrap: false,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    controller.isindividualSelected.value
                                        ? controller.getindividualData!
                                            .data[index].title
                                        : controller
                                            .getGrupData!.data[index].title,
                                    style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 13.sp,
                                      color: const Color(0xff564d4d),
                                      height: 1.25,
                                    ),
                                    textHeightBehavior: TextHeightBehavior(
                                        applyHeightToFirstAscent: false),
                                    softWrap: false,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.account_box,
                                        color: const Color(0xff564d4d),
                                        size: 10,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: 59,
                              height: 22,
                              decoration: BoxDecoration(
                                color: const Color(0xffffa914),
                                borderRadius: BorderRadius.circular(11.0),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xffffffff)),
                              ),
                              child: Center(
                                child: Text(
                                  'Join',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 9.sp,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: false,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class TodayData extends StatelessWidget {
  const TodayData({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DashbordController controller;

  int getNum() {
    if (controller.isindividualSelected.value) {
      return controller.toDayPertyIndividual!.length;
    } else {
      return controller.toDayPertyOrgination!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return getNum() > 0
        ? Container(
            height: getNum() > 0 ? 160 : 0,
            width: Get.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,

                // physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        ///
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 160,
                            width: 171,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0),
                              child: Image.network(
                                controller.isindividualSelected.value
                                    ? 'http://app.partypeople.in/${controller.toDayPertyIndividual![index].coverPhoto}'
                                    : 'http://app.partypeople.in/${controller.toDayPertyOrgination![index].coverPhoto}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Stack(
                              children: [
                                Container(
                                  height: 80,
                                  width: 171,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 20.0, right: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 7.sp,
                                              color: const Color(0xff564d4d),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'TODAY - ',
                                              ),
                                              TextSpan(
                                                text: controller
                                                        .isindividualSelected
                                                        .value
                                                    ? controller
                                                        .toDayPertyIndividual![
                                                            index]
                                                        .startTime
                                                    : controller
                                                        .toDayPertyOrgination![
                                                            index]
                                                        .startTime,
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xffc40d0d),
                                                ),
                                              ),
                                            ],
                                          ),
                                          textHeightBehavior:
                                              TextHeightBehavior(
                                                  applyHeightToFirstAscent:
                                                      false),
                                          softWrap: false,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller.isindividualSelected.value
                                              ? controller
                                                  .toDayPertyIndividual![index]
                                                  .title
                                              : controller
                                                  .toDayPertyOrgination![index]
                                                  .title,
                                          style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 13.sp,
                                            color: const Color(0xff564d4d),
                                            height: 1.25,
                                          ),
                                          textHeightBehavior:
                                              TextHeightBehavior(
                                                  applyHeightToFirstAscent:
                                                      false),
                                          softWrap: false,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.account_box,
                                              color: const Color(0xff564d4d),
                                              size: 10,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 59,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffa914),
                                      borderRadius: BorderRadius.circular(11.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xffffffff)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Join',
                                        style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontSize: 9.sp,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("No Event Found",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold)),
          );
  }
}

class NearByCitys extends StatelessWidget {
  const NearByCitys({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DashbordController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      decoration: BoxDecoration(
        color: Color(0xffA72E2E),
      ),
      child: Obx(() => controller.getCitys.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,

              // physics: NeverScrollableScrollPhysics(),
              itemCount: controller.getCitys.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/cityPic.png',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.getCitys[index].name
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 11.sp,
                              color: Color.fromARGB(255, 255, 255, 255),
                              height: 1.25,
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            softWrap: false,
                          ),
                        ],
                      )),
                );
              })
          : Center()),
    );
  }
}

class TommarowData extends StatelessWidget {
  const TommarowData({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final DashbordController controller;

  int getNum() {
    if (controller.isindividualSelected.value) {
      return controller.tommarowPertyIndividual!.length;
    } else {
      return controller.tommarowPertyOrgination!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return getNum() > 0
        ? Container(
            height: getNum() == 0 ? 0 : 170,
            width: Get.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,

                // physics: NeverScrollableScrollPhysics(),
                itemCount: controller.isindividualSelected.value
                    ? controller.tommarowPertyIndividual!.length
                    : controller.tommarowPertyOrgination!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.VIEW_EVENT,
                          arguments: controller.isindividualSelected.value
                              ? controller.tommarowPertyIndividual![index]
                              : controller.tommarowPertyOrgination![index],
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 160,
                            width: 171,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13.0),
                              child: Image.network(
                                controller.isindividualSelected.value
                                    ? 'http://app.partypeople.in/${controller.tommarowPertyIndividual![index].coverPhoto}'
                                    : 'http://app.partypeople.in/${controller.tommarowPertyOrgination![index].coverPhoto}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Stack(
                              children: [
                                Container(
                                  height: 80,
                                  width: 171,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 20.0, right: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 7.sp,
                                              color: const Color(0xff564d4d),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'TODAY - ',
                                              ),
                                              TextSpan(
                                                text: controller
                                                        .isindividualSelected
                                                        .value
                                                    ? controller
                                                        .tommarowPertyIndividual![
                                                            index]
                                                        .startTime
                                                    : controller
                                                        .tommarowPertyOrgination![
                                                            index]
                                                        .startTime,
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xffc40d0d),
                                                ),
                                              ),
                                            ],
                                          ),
                                          textHeightBehavior:
                                              TextHeightBehavior(
                                                  applyHeightToFirstAscent:
                                                      false),
                                          softWrap: false,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller.isindividualSelected.value
                                              ? controller
                                                  .tommarowPertyIndividual![
                                                      index]
                                                  .title
                                              : controller
                                                  .tommarowPertyOrgination![
                                                      index]
                                                  .title,
                                          style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 13.sp,
                                            color: const Color(0xff564d4d),
                                            height: 1.25,
                                          ),
                                          textHeightBehavior:
                                              TextHeightBehavior(
                                                  applyHeightToFirstAscent:
                                                      false),
                                          softWrap: false,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.account_box,
                                              color: const Color(0xff564d4d),
                                              size: 10,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 59,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffa914),
                                      borderRadius: BorderRadius.circular(11.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xffffffff)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Join',
                                        style: TextStyle(
                                          fontFamily: 'Oswald',
                                          fontSize: 9.sp,
                                          color: const Color(0xffffffff),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("No Event Found",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold)),
          );
  }
}
