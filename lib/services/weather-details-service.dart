import 'dart:convert';
import '../models/weather-details-model.dart';
import 'package:http/http.dart' as http;

class WeatherDetailsService {
  static Future<WeatherDetails> fetchWeatherDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=51.5073219&lon=-0.1276474&appid=912ea2507df16681dfeac8634f83f4ff'));
    if (response.statusCode == 200) {
      return WeatherDetails.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
