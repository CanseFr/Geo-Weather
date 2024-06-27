import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meteo/models/geo-location-model.dart';

class GeoLocationService {
  static Future<Geolocation> fetchGeoLoc(String city,String country) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Api-Key': 'b0xNipXHc7QidOPhDcuGOg==PZ7OUWlS1DZN3KcI'
    };
    final response = await http.get(
        Uri.parse(
            'https://api.api-ninjas.com/v1/geocoding?city='+city+'&country=' + country),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return Geolocation.fromJson(data[0] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load GeoLocation');
    }
  }
}
