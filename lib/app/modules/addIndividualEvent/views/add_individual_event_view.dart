import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../ImageCrop/iimageCrop.dart';
import '../controllers/add_individual_event_controller.dart';

class AddIndividualEventView extends GetView<AddIndividualEventController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx((() => controller.isLoading.value == false
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                    child: Text(
                                  'Individuals',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 18,
                                    color: const Color(0xff3a3732),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: false,
                                )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed('/add-organizations-event');
                                },
                                child: Container(
                                  height: 35,
                                  width: 130,
                                  child: Center(
                                    child: Text(
                                      'Organizations',
                                      style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 18,
                                        color: const Color(0xfffffdfb),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/mice.png'),
                            Text(
                              'Host New Event  ',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 22,
                                color: const Color(0xffc40d0d),
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: false,
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.sendRequst();
                          },
                          child: Container(
                            height: 34,
                            width: 73,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(168, 147, 0, 0),
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x1b000000),
                                  offset: Offset(0, 5),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'POST',
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 15,
                                  color: const Color(0xffffffff),
                                ),
                                softWrap: false,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Obx(() => AddIndividualEventController.count.value != 0
                        ? ShowPic()
                        : Container()),
                    TextField(
                      controller: controller.title,
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 37,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '| Add title',
                        hintStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 37,
                          color: const Color(0x8c7d7373),
                        ),
                      ),
                    ),
                    TextField(
                      controller: controller.description,
                      minLines: 1,
                      maxLines: 5,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        color: const Color(0xff7d7373),
                      ),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.menu_sharp,
                          color: Color(0xffB8B2B2),
                          size: 14,
                        ),
                        border: InputBorder.none,
                        hintText: 'Add description',
                        hintStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          color: const Color(0xff7d7373),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // AddIndividualEventController.picture == null
                        await Get.to(() => GetCropedImg());
                        AddIndividualEventController.count.value = 7;
                        //controller.co
                        // : null;
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: const Color(0x247d7373),
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(
                                  width: 1.0, color: const Color(0x24707070)),
                            ),
                            child: Icon(
                              Icons.image,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add cover photo',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 18,
                              color: const Color(0xff7d7373),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: false,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Date and Time',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.getStartDate(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () => controller.getStartDate(context),
                              keyboardType: TextInputType.datetime,
                              controller: controller.startDate,
                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'party Starte Date',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //controller.getEndDate(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () => controller.getEndDate(context),
                              controller: controller.endDate,

                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'party End Date',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.getStartTime(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () => controller.getStartTime(context),
                              controller: controller.startTime,
                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'party Starte Time',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.getEndTime(context);
                          },
                          child: Container(
                            width: 150,
                            child: TextField(
                              onTap: () {
                                controller.getEndTime(context);
                              },
                              controller: controller.endTime,

                              minLines: 1,
                              maxLines: 1,
                              //enabled: false,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: const Color(0xff035DC4),
                                  size: 18,
                                ),
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff035DC4)),
                                ),

                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff035DC4),
                                      width: 1.0),
                                ),
                                hintText: 'party End Time',
                                hintStyle: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 14,
                                  color: const Color(0xff035DC4),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add location',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onTap: () {
                        controller.getLocation(context);
                      },
                      controller: AddIndividualEventController.location,

                      minLines: 1,
                      maxLines: 1,
                      //enabled: false,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 14,
                        color: const Color(0xff035DC4),
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.gps_fixed,
                          color: const Color(0xff035DC4),
                          size: 18,
                        ),
                        //border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff035DC4)),
                        ),

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff035DC4), width: 1.0),
                        ),
                        hintText: 'Select your live location on google',
                        hintStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          color: const Color(0xff035DC4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.celebration,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'party type',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => DropdownButton<String>(
                          value: controller.partyType.value,
                          hint: Text('Select your party type',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              )),
                          icon: const Icon(Icons.arrow_downward,
                              color: Color(0xff035DC4)),
                          style: const TextStyle(color: Color(0xff035DC4)),
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            width: Get.width,
                            color: const Color(0xff035DC4),
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.partyType.value = newValue;
                            }
                          },
                          items: <String>[
                            'Music event',
                            'Light show',
                            'Neon party'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    color: const Color(0xff035DC4),
                                  )),
                            );
                          }).toList(),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GroupButton(
                      isRadio: false,
                      onSelected: (string, index, isSelected) {
                        print('$index button is selected');
                        if(isSelected){
                          controller.genderList.add(index + 1);
                        }
                        else{
                          controller.
                          genderList.remove(index + 1);
                        }
                      },
                      maxSelected: 4,
                      buttons: [
                        "Male",
                        "Female",
                        "Couple",
                        "Other",
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.group,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Age group',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: controller.startPeopleAge,
                            minLines: 1,
                            maxLines: 1,
                            //enabled: false,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff035DC4),
                            ),
                            decoration: InputDecoration(
                              //border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff035DC4)),
                              ),

                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xff035DC4), width: 1.0),
                              ),
                              hintText: 'Start People Age',
                              hintStyle: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: TextField(
                            keyboardType: TextInputType.number,

                            controller: controller.endPeopleAge,

                            minLines: 1,
                            maxLines: 1,
                            //enabled: false,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14,
                              color: const Color(0xff035DC4),
                            ),
                            decoration: InputDecoration(
                              //border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff035DC4)),
                              ),

                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xff035DC4), width: 1.0),
                              ),
                              hintText: 'End people Age',
                              hintStyle: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 14,
                                color: const Color(0xff035DC4),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'party People Limit',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller.peopleLimit,
                        minLines: 1,
                        maxLines: 1,
                        //enabled: false,
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 14,
                          color: const Color(0xff035DC4),
                        ),
                        decoration: InputDecoration(
                          //border: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff035DC4)),
                          ),

                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xff035DC4), width: 1.0),
                          ),
                          hintText: 'Limit',
                          hintStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 14,
                            color: const Color(0xff035DC4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'party Status',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => controller.partyStatusChange.value != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                title: const Text('Full',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14,
                                      color: Color(0xff035DC4),
                                    )),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.Full,
                                  groupValue: controller.character,
                                  onChanged: (SingingCharacter? value) {
                                    controller.character = value!;
                                    controller.partyStatus.text = 'Full';
                                    controller.partyStatusChange.value = 'Full';
                                    print(controller.partyStatus.text);
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Awaited',
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 14,
                                    color: Color(0xff035DC4),
                                  ),
                                ),
                                leading: Radio<SingingCharacter>(
                                  value: SingingCharacter.Awaited,
                                  groupValue: controller.character,
                                  onChanged: (SingingCharacter? value) {
                                    controller.character = value!;
                                    controller.partyStatusChange.value =
                                        'Awaited';
                                    controller.partyStatus.text = "Awaited";
                                    print(controller.partyStatus.text);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container()),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color(0x247d7373),
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                width: 1.0, color: const Color(0x24707070)),
                          ),
                          child: Icon(
                            Icons.group_add_rounded,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Invite people',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: const Color(0xff7d7373),
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: false,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 27,
                          width: 63,
                          decoration: BoxDecoration(
                            color: const Color(0xe5035dc4),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Center(
                              child: Text(
                            'invite',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 13,
                              color: const Color(0xffffffff),
                            ),
                            softWrap: false,
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ))),
    );
  }
}

class ShowPic extends StatelessWidget {
  const ShowPic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('show pic');
    return AddIndividualEventController.picture != null
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 245,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Image.file(
              AddIndividualEventController.picture!,
              fit: BoxFit.cover,
            ),
          )
        : Container();
  }
}
