import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'app/modules/addOrganizationsEvent2/controllers/add_organizations_event2_controller.dart';

class Category {
  String id;
  String name;
  List<Amenity> amenities;

  Category({required this.id, required this.name, required this.amenities});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      amenities: (json['amenities'] as List)
          .map((amenity) => Amenity.fromJson(amenity))
          .toList(),
    );
  }
}

class Amenity {
  String id;
  String name;
  String type;
  bool selected;

  Amenity(
      {required this.id,
      required this.name,
      required this.type,
      this.selected = false});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class CategoryList {
  String title;
  List<Amenity> amenities;

  CategoryList({required this.title, required this.amenities});
}

class AmenitiesPartyScreen extends StatefulWidget {
  const AmenitiesPartyScreen({Key? key}) : super(key: key);

  @override
  _AmenitiesPartyScreenState createState() => _AmenitiesPartyScreenState();
}

class _AmenitiesPartyScreenState extends State<AmenitiesPartyScreen> {
  List<Category> _categories = [];
  List<CategoryList> _categoryLists = [];
  AddOrganizationsEvent2Controller controller =
      Get.put(AddOrganizationsEvent2Controller());

  Future<void> _fetchData() async {
    http.Response response = await http.get(
      Uri.parse('https://manage.partypeople.in/v1/party/party_amenities'),
      headers: {
        'x-access-token': GetStorage().read("token").toString(),
      },
    );
    final data = jsonDecode(response.body);
    setState(() {
      if (data['status'] == 1) {
        _categories = (data['data'] as List)
            .map((category) => Category.fromJson(category))
            .toList();

        _categories.forEach((category) {
          _categoryLists.add(CategoryList(
              title: category.name, amenities: category.amenities));
        });
      }
    });
  }

  void _selectAmenity(Amenity amenity) {
    setState(() {
      amenity.selected = !amenity.selected;
      controller.selectedAmenities.add(amenity.id);
      print(amenity.id);

      print(controller.selectedAmenities);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category List'),
      ),
      body: _categoryLists.length == 0
          ? Container(
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                  color: Colors.black,
                ),
              ),
            )
          : Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _categoryLists.length,
                  itemBuilder: (context, index) {
                    final categoryList = _categoryLists[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(categoryList.title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                            spacing: 10.0,
                            children: categoryList.amenities.map((amenity) {
                              return GestureDetector(
                                onTap: () => _selectAmenity(amenity),
                                child: Chip(
                                  label: Text(
                                    amenity.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'malgun'),
                                  ),
                                  backgroundColor: amenity.selected
                                      ? Colors.red
                                      : Colors.grey[400],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                AmenitiesButton()
              ],
            ),
    );
  }
}

class AmenitiesButton extends StatelessWidget {
  AddOrganizationsEvent2Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Get.to(AddAmenitiesParty(
        //     isPopular: false, editProfileData: controller.getPrefiledData));
        controller.sendRequst();
      },
      icon: Icon(
        Icons.grid_view,
        color: Colors.white,
      ),
      label: Text(
        'Create Party',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        minimumSize: Size(180, 50),
      ),
    );
  }
}
