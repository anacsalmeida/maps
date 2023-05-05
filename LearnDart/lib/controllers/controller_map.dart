import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:learning_dart/service/register_user.dart';

class ControllerMapPage {
  //variáveis
  String tileLayers = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  List<String> domains = ['a', 'b', 'c'];
  List<Marker> markers = [];
  VoidCallback? updateState;
  List<CircleMarker> circle = [];
  List<Polyline> polynine = [];
  double latitude = 0.0;
  double longitude = 0.0;
  double latitudeDestiny = 0.0;
  double longitudeDestiny = 0.0;
  bool checkPoint = false;
  String name = '';
  String? url;

  //controllers
  MapController controllerMap = new MapController();
  ServiceUser serviceUser = ServiceUser();

  //actions
  Future<void> onMapCreate() async {
    await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await Geolocator.getCurrentPosition().then((result) {
        controllerMap.move(LatLng(result.latitude, result.longitude), 17.0);
        latitude = result.latitude;
        longitude = result.longitude;
        markers.add(Marker(
            point: LatLng(result.latitude, result.longitude),
            builder: (ctx) => const Icon(
                  Icons.person,
                  color: Colors.red,
                )));
        updateState?.call();
      }).catchError((res) => print(res));
    }
  }

  Future<void> userUid() async {
    await serviceUser.user().then((response) {
      final data = response['DATA'];
      name = data['name'];
      url = data['photoUrl'];
    }).catchError((error) => {print(error)});
  }

  void clearMap() {
    polynine.clear();
    circle.clear();
  }

  Future<void> circleMap(LatLng latLng) async {
    double metters = await Geolocator.distanceBetween(
        latitude, longitude, latLng.latitude, latLng.longitude);
    Fluttertoast.showToast(
        msg: "Distancia é de: ${metters} metros",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 18.0);
    circle.clear();
    circle.add(CircleMarker(
        point: latLng, radius: 60.0, color: Colors.blue.withOpacity(0.2)));
    updateState?.call();
  }

  Future<PolylineResult> polinynes(LatLng latlng) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBwj59LaciWtmrvWE0U7-fJ4LSQn6jsaRg",
      PointLatLng(latlng.latitude, latlng.longitude),
      PointLatLng(latitudeDestiny, longitudeDestiny),
      travelMode: TravelMode.driving,
    );
    return result;
  }

  Future<void> addPolyInMap(LatLng latLng) async {
    List<LatLng> points = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBwj59LaciWtmrvWE0U7-fJ4LSQn6jsaRg",
      PointLatLng(latitude, longitude),
      PointLatLng(latLng.latitude, latLng.longitude),
      travelMode: TravelMode.driving,
    );
    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
    }
    checkPoint = true;
    if (markers.length > 1) {
      markers.removeLast();
      updateState?.call();
    }
    polynine.clear();
    polynine.add(Polyline(
        points: points,
        color: Colors.blue.withOpacity(0.6),
        strokeWidth: 10.0));
    markers.add(Marker(
        builder: (ctx) => const Icon(
              Icons.location_pin,
              color: Colors.black,
              size: 30,
            ),
        point: LatLng(latLng.latitude, latLng.longitude)));
    latitudeDestiny = points.last.latitude;
    longitudeDestiny = points.last.longitude;

    double heading = SphericalUtils.computeHeading(
        Point(points[0].latitude, points[0].longitude),
        Point(points[1].latitude, points[1].longitude));
    controllerMap.rotate(heading * (-1));
    updateState?.call();
  }

  Future<void> navigateInMap(double lat, double lng) async {
    List<LatLng> points = [];
    PolylineResult result = await polinynes(LatLng(lat, lng));
    polynine.clear();
    updateState?.call();
    checkPoint = true;
    for (var item in result.points) {
      points.add(LatLng(item.latitude, item.longitude));
    }
    polynine
        .add(Polyline(points: points, color: Colors.blue, strokeWidth: 15.0));
    double heading = SphericalUtils.computeHeading(
        Point(points[0].latitude, points[0].longitude),
        Point(points[1].latitude, points[1].longitude));
    controllerMap.rotate(heading * (-1));
    updateState?.call();
  }
}
