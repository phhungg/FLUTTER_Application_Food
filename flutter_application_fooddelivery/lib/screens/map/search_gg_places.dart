import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class LocationAutoComplete extends StatefulWidget {
  const LocationAutoComplete({super.key});

  @override
  State<LocationAutoComplete> createState() => _LocationAutoCompleteState();
}

class _LocationAutoCompleteState extends State<LocationAutoComplete> {
  final txtsearch = TextEditingController();
  var uuid = const Uuid();
  final String token = '1234567890';
  List<dynamic> listOfLocation = [];
  @override
  void initState() {
    txtsearch.addListener(() {
      onChange();
    });
    super.initState();
  }

  onChange() {
    placeSuggestion(txtsearch.text);
  }

  void placeSuggestion(String input) async {
    const String apiKey = 'AIzaSyDLA6bTA5YgQGgf97suBzdb8euaLR9O-wU';
    try {
      String baseUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          listOfLocation = json.decode(response.body)['prediction'];
        });
      } else {}
      throw Exception("Fail to load");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          "Location AutoComplete",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: txtsearch,
              decoration: InputDecoration(hintText: "Search Places..."),
              onChanged: (value) {
                setState(() {});
              },
            ),
            Visibility(
              visible: txtsearch.text.isNotEmpty ? false : true,
              child: Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listOfLocation.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {},
                          child: ListTile(
                              title:
                                  Text(listOfLocation[index]['descriptions'])),
                        );
                      })),
            ),
            Visibility(
              visible: txtsearch.text.isEmpty ? true : false,
              child: Container(
                width: 200,
                height: 60,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "My Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
