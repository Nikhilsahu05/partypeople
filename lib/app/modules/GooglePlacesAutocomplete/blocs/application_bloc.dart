// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../../addIndividualEvent/controllers/add_individual_event_controller.dart';
import '../models/place.dart';
import '../models/place_search.dart';
import '../services/geolocator_service.dart';
import '../services/marker_service.dart';
import '../services/places_service.dart';
import 'getit.dart';
import 'google_place_api.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  List<SearchResult>? result;
  SearchResult selectedResult = SearchResult();
  StreamController<SearchResult>? selectedLocation =
      StreamController<SearchResult>();
  StreamController<LatLngBounds>? bounds = StreamController<LatLngBounds>();
  Place? selectedLocationStatic;
  String? placeType;
  List<Place>? placeResults;
  List<Marker>? markers = [];

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Getit.getG(currentLocation!);
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    // searchResults = await placesService.getAutocomplete(searchTerm);
    if (searchTerm.trim().isNotEmpty) {
      GoogleApi.googlePlace.search.getTextSearch(searchTerm).then((value) {
        result = value!.results;
        // print(searchTerm);
        //print(value.status);
        notifyListeners();
      });
    } else {
      result = null;
      notifyListeners();
    }

    // print(searchResults);

    // GoogleApi.googlePlace.search.getTextSearch(searchTerm).then((value) {
    //   placeResults = value;
    //   notifyListeners();
    // });
  }

  setSelectedLocation(SearchResult placeId) async {
    // var sLocation = await placesService.getPlace(placeId);

    selectedLocation?.add(placeId);
    AddIndividualEventController.address = placeId.formattedAddress!;
    selectedResult = placeId;
    // selectedLocationStatic = sLocation;
    result = null;
    notifyListeners();
  }

  clearSelectedLocation() {
    // selectedLocation?.add(null);
    selectedLocationStatic = null;
    result = null;
    placeType = null;
    notifyListeners();
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }

    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic!.geometry!.location!.lat,
          selectedLocationStatic!.geometry!.location!.lng,
          placeType);
      markers = [];
      if (places.isNotEmpty) {
        var newMarker = markerService.createMarkerFromPlace(places[0], false);
        markers?.add(newMarker);
      }

      var locationMarker =
          markerService.createMarkerFromPlace(selectedLocationStatic!, true);
      markers?.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers!));
      bounds!.add(_bounds!);

      notifyListeners();
    }
  }

  @override
  void dispose() {
    selectedLocation!.close();
    bounds?.close();
    super.dispose();
  }
}
