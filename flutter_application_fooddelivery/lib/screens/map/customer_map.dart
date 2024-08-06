import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomerMap extends StatefulWidget {
  const CustomerMap({super.key});

  @override
  State<CustomerMap> createState() => _CustomerMapState();
}

class _CustomerMapState extends State<CustomerMap> {
  final Completer<GoogleMapController> _completer = Completer();
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  Uint8List? marketIcons;
  List<String> images = [
    "assets/images/sedan.png",
    "assets/images/sedan.png",
    "assets/images/sedan.png",
    "assets/images/sedan.png",
    "assets/images/sedan.png",
    "assets/images/sedan.png",
  ];
  final List<Marker> _marker = [];
  final List<LatLng> latng = [
    const LatLng(10.8230989, 106.6296638),
    const LatLng(16.0544471, 108.2021113),
    const LatLng(21.0277644, 105.8341598),
    const LatLng(11.1343972, 106.6624231),
    const LatLng(10.8230989, 107.6296638),
  ];
  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  loadData() async {
    for (int index = 0; index < latng.length; index++) {
      final Uint8List markerIcons =
          await getBytesFromAssets(images[index], 100);
      _marker.add(
        Marker(
            markerId: MarkerId(index.toString()),
            icon: BitmapDescriptor.fromBytes(markerIcons),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                latng[index],
              );
            },
            position: latng[index],
            infoWindow: InfoWindow(title: "This is a title $index")),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(10.8230989, 106.6296638), zoom: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Marker"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_marker),
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove;
            },
            onTap: (argument) {
              _customInfoWindowController.hideInfoWindow;
            },
            onMapCreated: (comtroller) {
              _customInfoWindowController.googleMapController = comtroller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          )
        ],
      ),
    );
  }
}
