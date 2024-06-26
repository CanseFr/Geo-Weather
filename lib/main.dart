import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/models/GeoLocation.dart';


Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'X-Api-Key': 'b0xNipXHc7QidOPhDcuGOg==PZ7OUWlS1DZN3KcI'
  };

  Future<Geolocation> fetchGeoLoc() async {
    final response = await http.get(Uri.parse('https://api.api-ninjas.com/v1/geocoding?city=London&country=England'), headers: requestHeaders);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return Geolocation.fromJson(data[0] as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load GeoLocation');
    }
  }


  @override
  void initState() {
    super.initState();
    geoLoc = fetchGeoLoc();
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
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.name),
                      Text(snapshot.data!.country),
                      Text(snapshot.data!.state),
                      Text( snapshot.data!.longitude.toString() ),
                      Text( snapshot.data!.latitude.toString() ),
                    ],
                  );
                    Text(snapshot.data!.name);
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
