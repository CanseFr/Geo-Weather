import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meteo/models/geo-location-model.dart';

class GeoLocationService {

  // TODO : GET FROM .env
  static String URL_GEO = "https://api.api-ninjas.com/v1/";
  static final HTTP_HEADER_KEY = 'X-Api-Key';
  static final HTTP_HEADER_VALUE = 'b0xNipXHc7QidOPhDcuGOg==PZ7OUWlS1DZN3KcI';

  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    HTTP_HEADER_KEY: HTTP_HEADER_VALUE,
  };

  static Future<Geolocation> fetchGeoLoc(String city, String country) async {
    final response = await http.get(
        Uri.parse(URL_GEO + 'geocoding?city=' + city + '&country=' + country),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return Geolocation.fromJson(data[0] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load GeoLocation');
    }
  }

  static Future<Geolocation> fetchGetReverseGeoCoding(
      double lon, double lat) async {
    final response = await http.get(
        Uri.parse(URL_GEO + 'reversegeocoding?lat=$lat&lon=$lon'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return Geolocation.fromJson(data[0] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Reverse GeoLocation');
    }
  }

  static bool checkIfCityExist(List<Geolocation> list, Geolocation newGeo ){
    for(var l in list){
      if(l.state == newGeo.state &&  l.country == newGeo.country){
        return true;
      }
    }
    return false;
  }
}
