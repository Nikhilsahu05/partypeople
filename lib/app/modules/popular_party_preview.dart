// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/modules/subscription/views/subscription_view.dart';

class PopularPartyPreview extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var data;

  bool isPopularParty;

  PopularPartyPreview({required this.data, required this.isPopularParty});

  @override
  State<PopularPartyPreview> createState() => _PopularPartyPreviewState();
}

class _PopularPartyPreviewState extends State<PopularPartyPreview> {
  var amenitiesTitle = [''];
  var jsonAddAmenitiesData;

  List<String> allAmenities = [];

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
                        image: NetworkImage(
                            'https://manage.partypeople.in/${widget.data['cover_photo']}'),
                        fit: BoxFit.fill)),
                width: Get.width,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "${widget.data['title']}",
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
                "${widget.data['description']}",
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
              BoostButton(
                  label: 'Boost Post',
                  onPressed: () {
                    Get.to(SubscriptionView(
                        id: widget.data['id'], data: widget.data));
                  }),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.calendar_month,
                  color: Colors.red,
                ),
                title: Text(
                  "${widget.data['start_date']} to ${widget.data['end_date']}",
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text(
                    "${widget.data['start_time']} to ${widget.data['end_time']}"),
              ),
              ListTile(
                leading: Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  "${widget.data['gender']}"
                      .replaceAll('[', '')
                      .replaceAll(']', ''),
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
                  "${widget.data['start_age']} To ${widget.data['end_age']} ",
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
                  "${widget.data['person_limit']}",
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.local_offer,
                  color: Colors.red,
                ),
                title: Text(
                  'Offers',
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text(
                  "${widget.data['offers']}",
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.monetization_on,
                  color: Colors.red,
                ),
                title: Text(
                  'Entry Fees',
                  style: TextStyle(fontFamily: 'malgun', fontSize: 17),
                ),
                subtitle: Text(
                  "Ladies - ${widget.data['ladies']}\n Couples - ${widget.data['couples']}\n Stag - ${widget.data['stag']}\n Others - ${widget.data['others']}",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding:
              //   const EdgeInsets.symmetric(horizontal: 28.0, vertical: 0),
              //   child: Container(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "Selected Amenities",
              //       textAlign: TextAlign.left,
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //           fontFamily: 'malgun',
              //           fontSize: 18),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 20,
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
