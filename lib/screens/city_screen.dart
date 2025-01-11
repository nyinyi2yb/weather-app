import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import '../services/networking.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = '';
  var data;
  @override
  void initState() {
    super.initState();
  }

  void navigate(data) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return LocationScreen(
        locationWeather: data,
      );
    })));
  }

  getData() async {
    if (city != '') {
      NetworkHelper network = NetworkHelper(
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=ae53f1db2386543336fb431ce6e99c46');
      var data = await network.getData();
      navigate(data);
    } else {
      print('enter your city ...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Choose City'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                getData();
                print('GET DATA');
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  city = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
