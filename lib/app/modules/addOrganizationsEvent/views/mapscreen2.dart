// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen2 extends StatefulWidget {
  @override
  _MapScreen2State createState() => _MapScreen2State();
}

String? currentAddress;

class _MapScreen2State extends State<MapScreen2> {
  late GoogleMapController? mapController;
  LatLng? _center;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _center = LatLng(position.latitude, position.longitude);
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentAddress =
            "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
      print(currentAddress);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _center == null
                ? CircularProgressIndicator()
                : SizedBox(
                    height: 300,
                    width: 350,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center as LatLng,
                        zoom: 11.0,
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            Text('Latitude: ${_currentPosition!.latitude}'),
            Text('Longitude: ${_currentPosition!.longitude}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final selectedLocation = await showDialog<LatLng>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Select Location'),
                    content: Container(
                      height: 300,
                      width: 300,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center as LatLng,
                          zoom: 11.0,
                        ),
                        onTap: (LatLng latLng) {
                          Navigator.of(context).pop(latLng);
                        },
                      ),
                    ),
                  ),
                );

                if (selectedLocation != null) {
                  setState(() {
                    _center = selectedLocation;
                  });
                  _getAddressFromLatLng();
                }
              },
              child: Text('Select Location'),
            ),
            SizedBox(height: 20),
            Text('Address: $currentAddress'),
          ],
        ),
      ),
    );
  }
}
