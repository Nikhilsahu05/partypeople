import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:pertypeople/app/modules/addOrganizationsEvent/controllers/add_organizations_event_controller.dart';
import 'package:pertypeople/cached_image_placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../routes/app_pages.dart';
import '../controllers/cust_profile_controller.dart';

class CustProfileView extends StatefulWidget {
  var organizationData;
  String phoneNumber;

  CustProfileView({required this.organizationData, required this.phoneNumber});

  @override
  State<CustProfileView> createState() => _CustProfileViewState();
}

class _CustProfileViewState extends State<CustProfileView> {
  CustProfileController controller = Get.put(CustProfileController());

  // DashbordController dashbordController = Get.find();
  List<MultiSelectCard> listOfAmenities = [];

  getAmenities() async {
    setState(() {
      var jsonAddAmenitiesData =
          widget.organizationData['organization_amenities'];
      listOfAmenities.clear();
      for (var i = 0; i < jsonAddAmenitiesData.length; i++) {
        setState(() {
          listOfAmenities.add(MultiSelectCard(
              value: jsonAddAmenitiesData[i]['name'],
              enabled: true,
              perpetualSelected: true,
              selected: true,
              label: jsonAddAmenitiesData[i]['name']));
        });
      }
    });
  }

  @override
  void initState() {
    getAmenities();
    super.initState();
  }

  AddOrganizationsEventController addOrganizationsEventController =
      Get.put(AddOrganizationsEventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Container(
              child: CachedNetworkImageWidget(
                imageUrl: '${widget.organizationData['timeline_pic']}',
                fit: BoxFit.fill,
                height: 180,
                width: Get.width,
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
                placeholder: (context, url) => Center(
                    child: CupertinoActivityIndicator(
                        color: Colors.black, radius: 15)),
              ),
            ),
            Positioned(
              bottom: 0,
              left: Get.width * 0.4,
              child: ClipOval(
                child: CachedNetworkImageWidget(
                  imageUrl: '${widget.organizationData['profile_pic']}',
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                  placeholder: (context, url) => Center(
                      child: CupertinoActivityIndicator(
                          color: Colors.black, radius: 15)),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.organizationData['name']}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'malgun',
                        fontSize: 18.sp),
                  ),
                  Container(
                    width: Get.width * 0.8,
                    child: Text(
                      "${widget.organizationData['description']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.01,
                          fontSize: 14.sp,
                          fontFamily: 'malgun'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: double.parse(widget.organizationData['rating']),
                    size: 18.sp,
                    color: Colors.orange,
                    borderColor: Colors.orange,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    spacing: .5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.phoneNumber,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'malgun'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.organizationData['branch'] == ''
                        ? 'No Branches'
                        : widget.organizationData['branch'],
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'malgun'),
                  ),
                  LikesAndViewsWidget(
                      likes: int.parse(widget.organizationData['like']),
                      views: int.parse(widget.organizationData['view'])),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.organizationData['city_id'] == '-'
                        ? ''
                        : "${widget.organizationData['city_id']}",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                        fontFamily: 'malgun'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OrganizationProfileButton(
                    onPressed: () {
                      addOrganizationsEventController.isEditable.value = true;

                      Get.toNamed(Routes.ADD_ORGANIZATIONS_EVENT);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Selected Amenities",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'malgun',
                          fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MultiSelectContainer(
                    isMaxSelectableWithPerpetualSelects: true,
                    controller: MultiSelectController(
                        deSelectPerpetualSelectedItems: true),
                    itemsDecoration: MultiSelectDecorations(),
                    itemsPadding: EdgeInsets.all(10),
                    maxSelectableCount: 0,
                    prefix: MultiSelectPrefix(
                        disabledPrefix: Icon(
                      Icons.do_disturb_alt_sharp,
                      size: 14,
                    )),
                    items: listOfAmenities,
                    onChange: (List<dynamic> selectedItems, selectedItem) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
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
                  'Edit Organization Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
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
              fontSize: 15.sp,
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
                fontSize: 14.sp,
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
class LikesAndViewsWidget extends StatelessWidget {
  final int likes;
  final int views;

  LikesAndViewsWidget({required this.likes, required this.views});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4,
        //     offset: Offset(0, 4),
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(
                Icons.favorite,
                size: 28.0,
                color: Colors.red.shade900,
              ),
              SizedBox(height: 8.0),
              Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          Container(
            height: 40.0,
            width: 1.0,
            color: Colors.grey[350],
          ),
          Column(
            children: [
              Icon(
                Icons.people,
                size: 28.0,
                color: Colors.red.shade900,
              ),
              SizedBox(height: 8.0),
              Text(
                views.toString(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
