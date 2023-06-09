import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/place.dart';
import '../models/place_search.dart';


class PlacesService {
  final key = 'AIzaSyAtcMBkZAsqimEm7BOvZ-sHvfYXXMfffT0';

  Future<List<PlaceSearch>> getAutocomplete(String? search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    //string to uri
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);

    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String? placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    print(response.body);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(
      double? lat, double? lng, String? placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
