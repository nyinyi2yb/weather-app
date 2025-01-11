import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/screens/location_screen.dart';

import '../services/location.dart';
import '../services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location currentLocation = new Location();
  late Position position;
  var data;

  void getLocation() async {
    position = await currentLocation.getLocation();
  }

  getData() async {
    CurrentLocation location = CurrentLocation();

    await location.getLocation();

    var lat = location.latitude;
    var long = location.longitude;

    NetworkHelper network = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=ae53f1db2386543336fb431ce6e99c46');

    data = await network.getData();

    print(data['city']['name']);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return LocationScreen(
                        locationWeather: data,
                      );
                    })));
                  },
                  child: const Text('Get Location')),
                  // Text(data['city']['name'])
            ],
          )),
    );
  }
}
