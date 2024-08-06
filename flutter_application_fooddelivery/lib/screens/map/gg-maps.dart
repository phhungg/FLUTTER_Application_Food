import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_/screens/map/covert_coordinates.dart';
import 'package:flutter_application_/screens/map/customer_map.dart';
import 'package:flutter_application_/screens/map/orders_tracking.dart';
import 'package:flutter_application_/screens/map/search_gg_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GGmap extends StatefulWidget {
  static const routeName = "?GGMAP";
  const GGmap({super.key});

  @override
  State<GGmap> createState() => _GGmapState();
}

class _GGmapState extends State<GGmap> {
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) {
        print(error.toString());
      },
    );
    return await Geolocator.getCurrentPosition();
  }

  final Completer<GoogleMapController> _completer = Completer();
  final List<Marker> _marker = [];
  final List<Marker> _markerList = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(10.8230989, 106.6296638),
      infoWindow: InfoWindow(title: "Ho Chi Minh City"),
    ),
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(11.1343, 106.6554),
      infoWindow: InfoWindow(title: "Binh Duong City"),
    ),
  ];
  void initState() {
    super.initState();
    _marker.addAll(_markerList);
  }

  final CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(10.8230989, 106.6296638), zoom: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: (controller) {
          _completer.complete(controller);
        },
        markers: Set<Marker>.of(_marker),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton(
              onPressed: () async {
                getUserCurrentLocation().then((value) async {
                  print("My Location Current $value");
                  _marker.add(
                    Marker(
                      markerId: const MarkerId("3"),
                      position: LatLng(value.latitude, value.longitude),
                      infoWindow:
                          const InfoWindow(title: "My Current Location"),
                    ),
                  );
                  CameraPosition cameraPosition = CameraPosition(
                      target: LatLng(value.latitude, value.longitude),
                      zoom: 13);
                  GoogleMapController controller = await _completer.future;
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition),
                  );
                });
                setState(() {});
              },
              child: const Icon(
                Icons.location_city_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Image.asset("assets/images/ggmapppp.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CovertCoordinates()));
                    },
                    title: const Text("Convert Coordinates"),
                    leading: const Icon(Icons.change_circle),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LocationAutoComplete()));
                    },
                    title: const Text("Location Autocomplete"),
                    leading: const Icon(Icons.search_outlined),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerMap()));
                    },
                    title: const Text("Custom Marker"),
                    leading: const Icon(Icons.directions_car_filled),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrdersTracking()));
                    },
                    title: const Text("Tracking Orders"),
                    leading: const Icon(Icons.online_prediction_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
