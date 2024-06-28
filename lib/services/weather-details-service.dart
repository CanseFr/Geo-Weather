import 'dart:convert';
import '../models/weather-details-model.dart';
import 'package:http/http.dart' as http;

final String API_KEY = '912ea2507df16681dfeac8634f83f4ff';
// final String? API_KEY = dotenv.env['METEO_API_KEY'];

class WeatherDetailsService {

  static Future<WeatherDetails> fetchWeatherDetails(double lon, double lat) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=' + API_KEY));
    if (response.statusCode == 200) {
      return WeatherDetails.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load weather');
    }
  }

}
