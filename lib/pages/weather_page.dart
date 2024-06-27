import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/services/traduction-weather.dart';

import '../models/weather-details-model.dart';
import '../services/weather-details-service.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  String? _latitude;
  String? _longitude;

  late Future<WeatherDetails> weatherDetails;


  @override
  void initState() {
    super.initState();
    _getLocation().then((_) {
      weatherDetails = WeatherDetailsService.fetchWeatherDetails(_longitude!, _latitude!);
    });
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Loca activé ?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Autoriz accés
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    // Actual Pos
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Bouton pour obtenir la localisation
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('Get Location'),
            ),
            const SizedBox(height: 20),
            // FutureBuilder pour afficher les détails météo
            FutureBuilder<WeatherDetails>(
              future: weatherDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  // Affichage des informations météo
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Ico
                      Image.asset(
                        'meteo-ico/${snapshot.data!.weatherList[0].icon}.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 16),

                      // Ville
                      Text(
                        '${snapshot.data!.name}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      // ETAT
                      Text(
                        '${TraductionWeather.traductWeather(snapshot.data!.weatherList[0].description)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),

                      // TEMP
                      Row(
                        children: [
                          const Icon(Icons.thermostat_outlined, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            '${TraductionWeather.kelvinToCelsius(snapshot.data!.main.temp)} °C',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Humidité
                      Row(
                        children: [
                          const Icon(Icons.water_outlined, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Humidity: ${snapshot.data!.main.humidity}%',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Pression atmosphérique
                      Row(
                        children: [
                          // const Icon(Icons.barometer_outlined, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Pressure: ${snapshot.data!.main.pressure} hPa',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}