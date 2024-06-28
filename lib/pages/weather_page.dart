import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/services/traduction-weather.dart';

import '../models/geo-location-model.dart';
import '../models/weather-details-model.dart';
import '../services/geo-location-service.dart';
import '../services/request_status.dart';
import '../services/weather-details-service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // POS
 double? _latitude;
 double? _longitude;

  // INPUT
  TextEditingController _specificCityController = TextEditingController();
  TextEditingController _specificCountryController = TextEditingController();

  // GEO
  late Future<Geolocation> geoLoc;

  // WEATHER
  late Future<WeatherDetails> weatherDetails;

  @override
  void initState() {
    super.initState();
    _getUserLocationOnInit();
  }

  Future<void> _getSpecificLocationOnResearch() async {
    String city = _specificCityController.text;
    String country = _specificCountryController.text;

    try {
      Geolocation geoLocation =
          await GeoLocationService.fetchGeoLoc(city, country);

      setState(() {
        _longitude = geoLocation.longitude as double;
        _latitude = geoLocation.latitude as double;
        _specificCityController.clear();
        _specificCountryController.clear();
      });

    } catch (error) {
      print('Error fetching weather data: $error');
    }

  }

  Future<void> _getUserLocationOnInit() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Loca
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    RequestStatus.isLocationDisabled(!serviceEnabled);

    // Aut accés
    permission = await Geolocator.checkPermission();
    RequestStatus.locationPermition(permission);
    RequestStatus.permissionDenied(permission);

    // Actual Pos
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
  }

  @override
  void dispose() {
    _specificCityController.dispose();
    _specificCountryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset(
        'la-meteo.png',
        width: 50,
        height: 50,
      ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),

              (_latitude != null && _longitude != null)?

              FutureBuilder<WeatherDetails>(
                future: WeatherDetailsService.fetchWeatherDetails(_longitude!, _latitude!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 8),

                        // ETAT
                        Text(
                          '${TraductionWeather.traductWeather(snapshot.data!.weatherList[0].description)}',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 16),

                        // TEMP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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

                        // Humi
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.water_outlined, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Humidité: ${snapshot.data!.main.humidity}%',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // ATMO
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.compress, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Pression: ${snapshot.data!.main.pressure} hPa',
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
              )

              : const Center(child: CircularProgressIndicator()),
              // GET MY LOC
              Padding(
                padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: _getUserLocationOnInit,
                  child: const Text('Ma position'),
                ),
              ),

              // GET A LOC

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: _specificCountryController,
                  decoration: const InputDecoration(
                    labelText: 'Pays',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextFormField(
                  controller: _specificCityController,
                  decoration: const InputDecoration(
                    labelText: 'Ville',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _getSpecificLocationOnResearch,
                  child: Text('Autre localisation'),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
