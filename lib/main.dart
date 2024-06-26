import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meteo/models/geo-location-model.dart';
import 'package:meteo/models/weather-details-model.dart';
import 'package:meteo/services/geo-location-service.dart';
import 'package:meteo/services/weather-details-service.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Geolocation> geoLoc;
  late Future<WeatherDetails> weatherDetails;

  @override
  void initState() {
    super.initState();
    geoLoc = GeoLocationService.fetchGeoLoc();
    weatherDetails = WeatherDetailsService.fetchWeatherDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Geolocation>(
              future: geoLoc,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.name),
                      Text(snapshot.data!.country),
                      Text(snapshot.data!.state),
                      Text(snapshot.data!.longitude.toString()),
                      Text(snapshot.data!.latitude.toString()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // Spinner
                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder<WeatherDetails>(
              future: weatherDetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.name),
                      Text(snapshot.data!.base),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // Spinner
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
