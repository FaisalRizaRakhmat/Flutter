import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  GoogleMapController.init();
  final GoogleMapOverlayController controller =
  GoogleMapOverlayController.fromSize(width: 300.0, height: 200.0);
  final Widget mapWidget = GoogleMapOverlay(controller: controller);
  runApp(MaterialApp(
    home: new Scaffold(
      appBar: AppBar(title: const Text('Google Maps demo')),
      body: MapsDemo(mapWidget, controller.mapController),
    ),
    navigatorObservers: <NavigatorObserver>[controller.overlayController],
  ));
}

class MapsDemo extends StatelessWidget {
  MapsDemo(this.mapWidget, this.controller);

  final Widget mapWidget;
  final GoogleMapController controller;

  @override
  Widget build(BuildContext context) {

    controller.animateCamera(CameraUpdate.newCameraPosition(
      new CameraPosition(
        //bearing: 270.0,
        target: LatLng(51.5160895, -0.1294527),
        tilt: 30.0,
        zoom: 10.0,
      ),
    ));

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: mapWidget),
          RaisedButton(
            child: const Text('Go to London'),
            onPressed: () {
              controller.animateCamera(CameraUpdate.newCameraPosition(
                new CameraPosition(
                  bearing: 270.0,
                  target: LatLng(51.5160895, -0.1294527),
                  tilt: 30.0,
                  zoom: 17.0,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}