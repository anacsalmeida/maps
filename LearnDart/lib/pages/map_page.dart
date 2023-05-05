import 'package:flutter/material.dart';
import 'package:learning_dart/controllers/controller_map.dart';
import 'package:learning_dart/controllers/controllers_login.dart';
import 'package:learning_dart/controllers/controllers_page.dart';
import 'package:learning_dart/pages/authenticator.dart';
import 'dart:async';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ControllerCadastroPage controllerCadastro = new ControllerCadastroPage();
  ControllerLoginPage controllerLogin = new ControllerLoginPage();
  ControllerMapPage controllerMap = new ControllerMapPage();
  StreamSubscription<Position>? listenPosition;

  void updatedState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controllerMap.onMapCreate();
    controllerMap.userUid();
    controllerMap.updateState = updatedState;
    Future.delayed(Duration(minutes: 1), () {
      listenCoordinates();
    });
  }

  void listenCoordinates() {
    listenPosition = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                distanceFilter: 0,
                accuracy: LocationAccuracy.best,
                timeLimit: Duration(seconds: 30)))
        .listen((event) {
      if (controllerMap.checkPoint) {
        controllerMap.navigateInMap(event.latitude, event.longitude);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listenPosition?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
        title: Text(controllerMap.name),
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await controllerLogin.clearStorage();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Authenticator(),
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return controllerMap.url == null
                ? Container(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: ClipOval(
                        child: Image(
                      image: NetworkImage("${controllerMap.url}"),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )),
                  );
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Card(
              elevation: 4,
              child: Container(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(-19.9816, -44.99562),
                    zoom: 13.0,
                    controller: controllerMap.controllerMap,
                    onTap: (tapPosition, point) {
                      controllerMap.circleMap(point);
                      controllerMap.addPolyInMap(point);
                    },
                  ),
                  mapController: controllerMap.controllerMap,
                  layers: [
                    TileLayerOptions(
                        urlTemplate: controllerMap.tileLayers,
                        subdomains: controllerMap.domains),
                    MarkerLayerOptions(markers: controllerMap.markers),
                    CircleLayerOptions(circles: controllerMap.circle),
                    PolylineLayerOptions(
                        polylineCulling: true,
                        polylines: controllerMap.polynine),
                    MarkerLayerOptions(markers: controllerMap.markers),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
