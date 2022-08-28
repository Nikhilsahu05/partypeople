import 'package:geolocator/geolocator.dart';

import '../models/geometry.dart';
import '../models/location.dart';
import '../models/place.dart';

class Getit{
  static Place getG( Position currentLocation){

    return Place(name: null,
      geometry: Geometry(location: Location(
          lat: currentLocation.latitude, lng: currentLocation.longitude,),),);
  }
}