import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CovertCoordinates extends StatefulWidget {
  const CovertCoordinates({super.key});

  @override
  State<CovertCoordinates> createState() => _CovertCoordinatesState();
}

class _CovertCoordinatesState extends State<CovertCoordinates> {
  String convertedAddress = "";
  String getCoordinatesFromAddress = "";
  Future<String> getAddressFromCoodinates(
      double latitude, double longitude) async {
    List<Placemark> placeMarkers =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placemark = placeMarkers[0];
    convertedAddress =
        "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}";
    return convertedAddress;
  }

  Future<List<Location>> getcoordinatesFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    getCoordinatesFromAddress = locations.toString();
    return locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Convert",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              convertedAddress,
              style: TextStyle(fontSize: 17),
            ),
            SelectableText(
              getCoordinatesFromAddress,
              style: TextStyle(fontSize: 17),
            ),
            GestureDetector(
              onTap: () async {
                getAddressFromCoodinates(10.8230989, 106.6296638);
                getcoordinatesFromAddress("Ho Chi Minh City");
                setState(() {});
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    "Convert",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
