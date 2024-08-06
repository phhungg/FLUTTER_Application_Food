import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrdersTracking extends StatefulWidget {
  const OrdersTracking({Key? key}) : super(key: key);

  @override
  State<OrdersTracking> createState() => _OrdersTrackingState();
}

const String ggApikey = 'AIzaSyAxqYDENOB9GtJjEzyupSsH6iELZZK3yUA';

class _OrdersTrackingState extends State<OrdersTracking> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(10.8230989, 106.6296638);
  static const LatLng destination = LatLng(10.9197, 106.6638);
  List<LatLng> polylineCoordinates = [];
  void getpolypoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
            ggApikey,
            PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
            PointLatLng(destination.latitude, destination.longitude));
    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach(
        (PointLatLng points) => polylineCoordinates.add(
          LatLng(points.latitude, points.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getpolypoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          "Track Order",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(sourceLocation.latitude, sourceLocation.longitude),
              zoom: 15),
          polylines: {
            Polyline(
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
            ),
          },
          markers: {
            Marker(
                markerId: MarkerId("source"),
                position:
                    LatLng(sourceLocation.latitude, sourceLocation.longitude)),
            Marker(
                markerId: MarkerId("destination"),
                position: LatLng(destination.latitude, destination.longitude)),
          }),
    );
  }
}
