import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    getWeatherData(widget.locationWeather);
  }

  String cityName = '';
  int temp = 0;
  int condition = 0;

  void getWeatherData(weatherData) {
    cityName = weatherData['city']['name'];
    double temperature = weatherData['list'][0]['main']['temp'];
    temp = temperature.toInt();
    condition = weatherData['list'][0]['weather'][0]['id'];

    var humidity = weatherData['list'][0]['main']['humidity'];
    print(humidity);

    print('$cityName , $temp , $condition');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('images/sunset.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop)),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(onPressed: () {}, icon: const Icon(Icons.near_me)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((ontext) {
                          return const CityScreen();
                        })));
                      },
                      icon: const Icon(Icons.location_city))
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    cityName,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$temp°',
                        style: const TextStyle(fontSize: 25),
                      ),
                      Text(
                        weather.getWeatherIcon(condition),
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    weather.getMessage(temp),
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
