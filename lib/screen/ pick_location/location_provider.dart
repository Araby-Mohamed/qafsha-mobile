import 'dart:async';
import 'dart:io';

import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

class LocationProvider extends ChangeNotifier {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  String _address;
  String get address => _address;
  set setAddress(String newVlu) {
    _address = newVlu;
    notifyListeners();
  }

  Set<Marker> markers = Set();

  resetMarkers() {
    markers = Set();
    notifyListeners();
  }

  double _lat, _lng;

  get lat => _lat;

  get lng => _lng;

  set setLat(double newLat) {
    _lat = newLat;
    print('newLat => $newLat');
    notifyListeners();
  }

  set setLng(double newLng) {
    _lng = newLng;
    print('newLat => $newLng');
    notifyListeners();
  }

  getPermission() async {
    loc.Location location = new loc.Location();

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    loc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print('location => ${_locationData.longitude}');
    setLat = _locationData.latitude;
    setLng = _locationData.longitude;
    getAddressFromLatLng();
  }

  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;
  Future<void> getCurrentPosition() async {
    // final hasPermission = await _handlePermission();
    // print('hasPermission => $hasPermission');
    // if (!hasPermission) {
    //   return;
    // }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('position => ${position.latitude}, lng => ${position.longitude}');
    // final position = await _geoLocatorPlatform.getCurrentPosition();
    setLat = position.latitude;
    setLng = position.longitude;
    getAddressFromLatLng();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    // serviceEnabled = await _geoLocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _openLocationSettings();
      showToast(message: _kLocationServicesDisabledMessage);
      return false;
    }

    permission = await _geoLocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geoLocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(message: _kPermissionDeniedMessage);

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showToast(message: _kPermissionDeniedForeverMessage);

      _openLocationSettings();
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    showToast(message: _kPermissionGrantedMessage);
    return true;
  }

  void _openLocationSettings() async {
    final opened = await _geoLocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    showToast(message: displayValue);
  }

  void drawPinOnMapCreated(
      {@required String lat,
      @required String lng,
      @required Completer<GoogleMapController> mapController}) async {
    resetMarkers();
    CameraPosition cPosition = CameraPosition(
      zoom: 15,
      bearing: 5,
      target:
          LatLng(double.parse(lat.toString()), double.parse(lng.toString())),
    );
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    markers.addAll([
      Marker(
        markerId: MarkerId('value'),
        position:
            LatLng(double.parse(lat.toString()), double.parse(lng.toString())),
      ),
    ]);
    notifyListeners();
  }

  getAddressFromLatLng() async {
    final coordinates = new Coordinates(_lat, _lng);

    var awaitaddresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    print('1 => ${awaitaddresses[0].addressLine}');
    print('2 => ${awaitaddresses[0].countryName}');
    print('3 => ${awaitaddresses[0].locality}');
    print('4 => ${awaitaddresses[0].subAdminArea}');
    print('5 => ${awaitaddresses[0].adminArea}');
    print('6 => ${awaitaddresses[0].subLocality}');
    setAddress = awaitaddresses[0].subAdminArea ??
        '' + awaitaddresses[0].adminArea + " " + awaitaddresses[0].countryName;
  }

  void locationApi({
    @required BuildContext context,
    @required String lat,
    @required String lng,
    @required String address,
  }) async {
    displayCustomCircular(context);
    var body = {
      "lat": _lat,
      "lng": _lng,
      "address": address,
    };
    Response response = await DioHelper.pastData(
        url: EndPoints.setLocation, data: body, withAuth: true);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      showToast(message: response.data['message']);
      Navigator.pop(context);
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = '';
      response.data['errors'].forEach((k, v) {
        for (String mess in v) {
          error += mess + "\n";
        }
      });
      showFlushBar(context: context, message: error);
    } else {}
  }
}
