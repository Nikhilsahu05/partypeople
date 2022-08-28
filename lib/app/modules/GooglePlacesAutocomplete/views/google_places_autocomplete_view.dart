import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';

import '../../addIndividualEvent/controllers/add_individual_event_controller.dart';
import '../blocs/application_bloc.dart';
import '../controllers/google_places_autocomplete_controller.dart';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class GooglePlacesAutocompleteView extends StatefulWidget {
  GooglePlacesAutocompleteView({Key? key}) : super(key: key);

  @override
  _GooglePlacesAutocompleteView createState() =>
      _GooglePlacesAutocompleteView();
}

class _GooglePlacesAutocompleteView
    extends State<GooglePlacesAutocompleteView> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? locationSubscription;
  StreamSubscription? boundsSubscription;
  final _locationController = TextEditingController();
  static var address = "";
  double googleMapHight = 500.0;

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    AddIndividualEventController.address = "";

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation!.stream.listen((location) {
      if (location != null) {
        _locationController.text = location.name!;
        // address = location.formattedAddress!;
        _goToPlace(location);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds!.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

  @override
  void dispose() {
    // final applicationBloc =
    //     Provider.of<ApplicationBloc>(context, listen: false);
    // applicationBloc.dispose();
    // _locationController.dispose();
    // locationSubscription!.cancel();
    // boundsSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Search by City',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          applicationBloc.searchPlaces(value);
                        }
                      },
                      onChanged: (value) => applicationBloc.searchPlaces(value),
                      onTap: () => applicationBloc.clearSelectedLocation(),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: googleMapHight,
                        child: Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    applicationBloc.currentLocation!.latitude,
                                    applicationBloc.currentLocation!.longitude),
                                zoom: 14,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _mapController.complete(controller);
                              },
                              markers: Set<Marker>.of(applicationBloc.markers!),
                            ),
                            Center(
                              child: //offset icon by 20 to the top
                                  IconButton(
                                icon:
                                    Icon(Icons.my_location, color: Colors.blue),
                                onPressed: () async {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      // if (applicationBloc.searchResults != null &&
                      //     applicationBloc.searchResults!.isNotEmpty)
                      if (applicationBloc.result != null &&
                          applicationBloc.result!.isNotEmpty)
                        Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                backgroundBlendMode: BlendMode.darken)),
                      if (applicationBloc.result != null)
                        Container(
                          height: 300.0,
                          child: ListView.builder(

                            
                              itemCount: applicationBloc.result!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc.result![index].name!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    applicationBloc
                                        .result![index].formattedAddress!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    try {
                                      applicationBloc.setSelectedLocation(
                                          applicationBloc.result![index]);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                );
                              }),
                        ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text('Find Nearest',
                  //       style: TextStyle(
                  //           fontSize: 25.0, fontWeight: FontWeight.bold)),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Wrap(
                  //     spacing: 8.0,
                  //     children: [
                  //       FilterChip(
                  //         label: Text('Campground'),
                  //         onSelected: (val) => applicationBloc.togglePlaceType(
                  //             'campground', val),
                  //         selected: applicationBloc.placeType == 'campground',
                  //         selectedColor: Colors.blue,
                  //       ),
                  //       FilterChip(
                  //           label: Text('Locksmith'),
                  //           onSelected: (val) => applicationBloc
                  //               .togglePlaceType('locksmith', val),
                  //           selected: applicationBloc.placeType == 'locksmith',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Pharmacy'),
                  //           onSelected: (val) => applicationBloc
                  //               .togglePlaceType('pharmacy', val),
                  //           selected: applicationBloc.placeType == 'pharmacy',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Pet Store'),
                  //           onSelected: (val) => applicationBloc
                  //               .togglePlaceType('pet_store', val),
                  //           selected: applicationBloc.placeType == 'pet_store',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Lawyer'),
                  //           onSelected: (val) =>
                  //               applicationBloc.togglePlaceType('lawyer', val),
                  //           selected: applicationBloc.placeType == 'lawyer',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Bank'),
                  //           onSelected: (val) =>
                  //               applicationBloc.togglePlaceType('bank', val),
                  //           selected: applicationBloc.placeType == 'bank',
                  //           selectedColor: Colors.blue),
                  //     ],
                  //   ),
                  // )
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //print current center of map

            final devicePixelRatio = Platform.isAndroid
                ? MediaQuery.of(context).devicePixelRatio
                : 1.0;

            GoogleMapController controller;
            _mapController.future.then(
              (value) => value
                  .getLatLng(ScreenCoordinate(
                    x: (googleMapHight * devicePixelRatio) ~/ 2.0,
                    y: (googleMapHight * devicePixelRatio) ~/ 2.0,
                  ))
                  .then((value) => fatchaddress(value)),
            );
          },
          child: Text('Done'),
        ));
  }

  //print all FetchGeocoder value to console
  // void printAddress(FetchGeocoder value) {
  //   print(value.results);
  //   print("address : " + value.results[3].formattedAddress);
  //   print("address  main : " + value.results[5].formattedAddress);
  //   print("address  sub : " + value.results[6].placeId);

  //   String city = value.results[5].formattedAddress.split(',')[0];

  //   if (JurneyDetailsController.address != "pickup") {
  //     JurneyDetailsController.address == 'From'
  //         ? {
  //             JurneyDetailsController.addresFrom.value =
  //                 value.results[3].formattedAddress,
  //             JurneyDetailsController.cityFrom.value = city,
  //             JurneyDetailsController.locationFrom = LatLng(
  //                 value.results[3].geometry.location.lat,
  //                 value.results[3].geometry.location.lng)
  //           }
  //         : {
  //             JurneyDetailsController.addresTo.value =
  //                 value.results[3].formattedAddress,
  //             JurneyDetailsController.cityTo.value = city,
  //             JurneyDetailsController.locationTo = LatLng(
  //                 value.results[3].geometry.location.lat,
  //                 value.results[3].geometry.location.lng)
  //           };
  //     Get.back();
  //     // value.results.forEach((element) {
  //     //   print("address " + element.formattedAddress);
  //     // });
  //   } else {
  //     SenderPickupPageController.pickUpLatLng = LatLng(
  //         value.results[3].geometry.location.lat,
  //         value.results[3].geometry.location.lng);
  //     SenderPickupPageController.pickUpLocation.value =
  //         value.results[3].formattedAddress;
  //     SenderPickupPageController.city = city;
  //     Get.back();
  //   }
  // }

  void fatchaddress(LatLng center) {
    print(center);
    if (AddIndividualEventController.address.isEmpty) {
      AddIndividualEventController.address =
          '${center.latitude} ${center.longitude}';
    }
    AddIndividualEventController.latLng = center;
    // var addressData = '';
    // var location = Geocoder2.getDataFromCoordinates(
    //     latitude: center.latitude,
    //     longitude: center.longitude,
    //     googleMapApiKey: 'AIzaSyAtcMBkZAsqimEm7BOvZ-sHvfYXXMfffT0');
    // location.then((value) {
    //   addressData = value.address;
    //  // AddIndividualEventController.address = value.address;
    //   print(value.address);
    //   print(value.address);
    // }).catchError((error) {
    //   addressData =
    //       address == '' ? '${center.latitude} ${center.longitude}' : address;
    //   print(addressData);
    //   if(AddIndividualEventController.address.isEmpty){
    //     AddIndividualEventController.address =  '${center.latitude} ${center.longitude}';
    //   }

    //   print(error);
    // });

    Get.back();
  }

  Future<void> _goToPlace(SearchResult place) async {
    double? lat = place.geometry!.location!.lat;
    double? lng = place.geometry!.location!.lng;
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat!, lng!), zoom: 14.0),
      ),
    );
  }
}
