import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import '../services/location.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
      Response response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        print(response.statusCode);
      }

  }
}
