// ignore_for_file: must_be_immutable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PopularPartyPreview extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  int index;
  bool isPopularParty;

  PopularPartyPreview(
      {required this.data, required this.index, required this.isPopularParty});

  @override
  State<PopularPartyPreview> createState() => _PopularPartyPreviewState();
}

class _PopularPartyPreviewState extends State<PopularPartyPreview> {
  var amenitiesTitle = [''];
  var jsonAddAmenitiesData;
  List<MultiSelectCard> amenitiesListOthers = [];

  getAmenities() async {
    http.Response response = await http.get(
        Uri.parse('https://manage.partypeople.in/v1/party/party_amenities'),
        headers: {
          'x-access-token': GetStorage().read("token").toString(),
        });
    var jsonData = jsonDecode(response.body);
    print(response.body);
    setState(() {
      jsonAddAmenitiesData = jsonData['data'];
      amenitiesTitle.clear();

      for (var ix = 0; ix < jsonData['data'][3].length; ix++) {
        setState(() {
          for (var i = 0; i < 5; i++) {
            setState(() {
              amenitiesListOthers.add(MultiSelectCard(
                  value: '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}',
                  label:
                  '${jsonAddAmenitiesData[ix]['amenities'][i]['name']}'));
              amenitiesListOthers.reversed;
            });
          }
        });
      }
      print(amenitiesTitle);
    });
  }

  @override
  void initState() {
    getAmenities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage('assets/a.jpeg'), fit: BoxFit.fill)),
                width: Get.width,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Dance Party at My Home With Music",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'malgun',
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "When an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries but also the leap into",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'malgun',
                  fontSize: 16,
                  color: Color(0xff7D7373),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              BoostButton(label: 'Boost Post', onPressed: () {

              }),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  color: Colors.red,
                ),
                title: Text(
                  "14 May, 2022 to 14 May 2022",
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text("09:30 PM to 11:30 PM"),
              ),
              ListTile(
                leading: Icon(
                  Icons.pin_drop,
                  color: Colors.red,
                ),
                title: Text(
                  "Jabalpur",
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text("Manohar street , House No 22 Near, MD house"),
              ),
              ListTile(
                leading: Container(
                    width: 27, child: Image.asset("assets/party.png")),
                title: Text(
                  "House Party ",
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  "Female , Couple",
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Colors.red,
                ),
                title: Text(
                  'Age',
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text(
                  "18 To 35 ",
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                title: Text(
                  'People Limit',
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text(
                  "30  ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrganizationProfileButton extends StatefulWidget {
  final Function onPressed;

  OrganizationProfileButton({required this.onPressed});

  @override
  _OrganizationProfileButtonState createState() =>
      _OrganizationProfileButtonState();
}

class _OrganizationProfileButtonState extends State<OrganizationProfileButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
    Tween<double>(begin: 1.0, end: 0.95).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _animationController.forward();
      },
      onTapUp: (_) {
        _animationController.reverse();
        widget.onPressed();
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: Transform.scale(
        scale: _animation.value,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffFF4D4D),
                Color(0xffFF0000),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Edit Party',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class TitleAnswerWidget extends StatelessWidget {
  final String title;
  final String answer;

  TitleAnswerWidget({required this.title, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.red.withOpacity(0.2),
            ),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

// class SelectedAmenities extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Selected Amenities',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black.withOpacity(0.7),
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: GridView.builder(
//                 itemCount: selectedAmenities.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 2.5,
//                 ),
//                 itemBuilder: (BuildContext context, int index) {
//                   return TitleAnswerWidget(
//                     title: 'Amenity ${index + 1}',
//                     answer: selectedAmenities[index],
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             OrganizationProfileButton(
//               onPressed: () {
//                 // Do something when the button is pressed
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class BoostButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BoostButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.red.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flash_on, color: Colors.white),
          SizedBox(width: 8),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
