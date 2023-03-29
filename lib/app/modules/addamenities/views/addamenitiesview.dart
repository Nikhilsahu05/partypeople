// // ignore_for_file: prefer_typing_uninitialized_variables
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:pertypeople/app/modules/addamenities/controllers/addamenitiescontroller.dart';
//
// import '../../addOrganizationsEvent/controllers/add_organizations_event_controller.dart';
//
// class AddAmenities extends StatefulWidget {
//   const AddAmenities({Key? key}) : super(key: key);
//
//   @override
//   State<AddAmenities> createState() => _AddAmenitiesState();
// }
//
// class _AddAmenitiesState extends State<AddAmenities> {
//   var amenitiesTitle = [''];
//   List amenitiesIndexes = [];
//   List selectedItemsAmenities = [];
//   var jsonAddAmenitiesData;
//
//   getAmenities() async {
//     http.Response response = await http.get(
//         Uri.parse(
//             'https://manage.partypeople.in/v1/party/organization_amenities'),
//         headers: {
//           'x-access-token':
//               'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjUsImlhdCI6MTY3NTg2NTkxMH0.UAqwef4sbcFd2lt1gAaFPZU9KYg72tjrtqkWKc5Dq2M',
//         });
//     var jsonData = jsonDecode(response.body);
//     print(response.body);
//     setState(() {
//       jsonAddAmenitiesData = jsonData['data'];
//       amenitiesTitle.clear();
//       for (var i = 0; i < jsonData['data'].length; i++) {
//         setState(() {
//           amenitiesList.add(MultiSelectCard(
//               value: jsonAddAmenitiesData[i]['name'],
//               label: jsonAddAmenitiesData[i]['name']));
//         });
//       }
//       print(amenitiesTitle);
//     });
//   }
//
//   List<MultiSelectCard> amenitiesList = [];
//   AddAmenitiesController addAmenities = Get.put(AddAmenitiesController());
//
//   AddOrganizationsEventController controller =
//       Get.put(AddOrganizationsEventController());
//
//   getAmenitiesNew() async {
//     http.Response response = await http.get(
//         Uri.parse(
//             'https://manage.partypeople.in/v1/party/organization_amenities'),
//         headers: {
//           'x-access-token':
//               'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MjUsImlhdCI6MTY3NTg2NTkxMH0.UAqwef4sbcFd2lt1gAaFPZU9KYg72tjrtqkWKc5Dq2M',
//         });
//     var jsonData = jsonDecode(response.body);
//     print(response.body);
//     setState(() {
//       jsonAddAmenitiesData = jsonData['data'];
//       amenitiesTitle.clear();
//       for (var i = 0; i < jsonData['data'].length; i++) {
//         setState(() {
//           amenitiesList.add(MultiSelectCard(
//               enabled: true,
//               selected: true,
//               value: jsonAddAmenitiesData[i]['name'],
//               label: jsonAddAmenitiesData[i]['name']));
//         });
//       }
//       print(amenitiesTitle);
//     });
//   }
//
//   @override
//   void initState() {
//     getAmenities();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => controller.isLoading.value == true
//             ? Center(child: CircularProgressIndicator())
//             : Container(
//                 height: Get.height,
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/red_background.png"),
//                         fit: BoxFit.fill)),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Container(
//                         alignment: Alignment.center,
//                         child: Text('Select Amenities',
//                             style: TextStyle(
//                               fontFamily: 'malgun',
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 1.0,
//                               color: Colors.white,
//                             )),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                             height: MediaQuery.of(context).size.height * 0.5,
//                             width: MediaQuery.of(context).size.width,
//                             child: MultiSelectContainer(
//                                 prefix: MultiSelectPrefix(
//                                     selectedPrefix: const Padding(
//                                       padding: EdgeInsets.only(right: 20),
//                                       child: Icon(
//                                         Icons.check,
//                                         color: Colors.white,
//                                         size: 14,
//                                       ),
//                                     ),
//                                     disabledPrefix: const Padding(
//                                       padding: EdgeInsets.only(right: 20),
//                                       child: Icon(
//                                         Icons.do_disturb_alt_sharp,
//                                         size: 14,
//                                       ),
//                                     )),
//                                 items: amenitiesList,
//                                 onChange: (allSelectedItems, selectedItem) {
//                                   setState(() {
//                                     selectedItemsAmenities.add(selectedItem);
//                                     print(amenitiesList);
//                                     // print(amenitiesList.contains));
//                                     // print((MultiSelectCard(
//                                     //     value: selectedItem,
//                                     //     label: selectedItem.toString())));
//                                     for (var i = 0;
//                                         i < amenitiesList.length;
//                                         i++) {
//                                       if (amenitiesList[i].label ==
//                                           selectedItem.toString()) {
//                                         print(i);
//                                         controller.selectedAmenitiesListID
//                                             .add((i + 1).toString());
//
//                                         print(amenitiesList[i].label);
//                                       }
//                                     }
//                                   });
//                                 })),
//                       ),
//                       Center(
//                         child: Container(
//                           height: 150,
//                           width: 150,
//                           child: Center(
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red.shade900),
//                               onPressed: () {
//                                 if (controller.isEditable.value == true) {
//                                   controller.updateOrganisation();
//                                 } else {
//                                   controller.addOrgnition();
//                                 }
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   "Finish",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ]),
//               ),
//       ),
//     );
//   }
// }
