import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models/geo-location-model.dart';
import '../services/geo-location-service.dart';
import '../services/request_status.dart';

class GeolocPage extends StatefulWidget {
  const GeolocPage({super.key});

  @override
  State<GeolocPage> createState() => _GeolocPageState();
}

class _GeolocPageState extends State<GeolocPage> {
  // POS
  double? _latitude;
  double? _longitude;

  // LISTE CITY
  List<Geolocation> geoList = [];

  // TITLE POS
  Geolocation? _cityName;

  // INPUT
  TextEditingController _specificCityController = TextEditingController();
  TextEditingController _specificCountryController = TextEditingController();

  Future<void> _getSpecificLocationOnResearch() async {
    String city = _specificCityController.text;
    String country = _specificCountryController.text;

    try {
      Geolocation geoLocation =
          await GeoLocationService.fetchGeoLoc(city, country);

      setState(() {
        _latitude = geoLocation.latitude as double;
        _longitude = geoLocation.longitude as double;
        _cityName = geoLocation;

      });
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  Future<void> _getSpecificLocationbySelectList(Geolocation geoLocationSelect) async {

    try {
      Geolocation geoLocation =
      await GeoLocationService.fetchGeoLoc(geoLocationSelect.state, geoLocationSelect.country);

      setState(() {
        _latitude = geoLocation.latitude as double;
        _longitude = geoLocation.longitude as double;
        _cityName = geoLocation;

      });
    } catch (error) {
      print('Error fetching weather data: $error');
    }

  }



  void _addCityToPersonnalList(){
    Geolocation newGeo = new Geolocation(name: "", latitude: 0, longitude: 0, country: _specificCountryController.text.toString(), state: _specificCityController.text.toString());

    if(GeoLocationService.checkIfCityExist(geoList,newGeo) ){
      // Do nothing
    } else {
      setState(() {
        geoList.add(newGeo);
      });
    }

    print(geoList.toString());
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

    Geolocation positionReverse =
        await GeoLocationService.fetchGetReverseGeoCoding(
            position.longitude, position.latitude);

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _cityName = positionReverse;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLocationOnInit();
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
      appBar: AppBar(
        title: Image.asset(
          'google-maps.png',
          width: 50,
          height: 50,
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Text(_cityName?.name ?? 'Loading...',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(_cityName?.state ?? 'Loading...',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(_cityName?.country ?? 'Loading...',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ])),
          Expanded(
              child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                const SizedBox(height: 20),
                (_latitude == null && _longitude == null)
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(_latitude!, _longitude!),
                            initialZoom: 13.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              subdomains: const ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: LatLng(_latitude!, _longitude!),
                                  child: const Icon(Icons.location_on,
                                      color: Colors.red, size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ]))),

          // FIND NEW CITY

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



          // BOTTOM ACTION
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _getSpecificLocationOnResearch,
                  child: Text('Autre localisation'),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: IconButton(
                      onPressed: () {

                        if (_specificCityController.text.isNotEmpty && _specificCountryController.text.isNotEmpty){
                          _addCityToPersonnalList();
                        }

                      },
                      icon: Icon(Icons.add_location),
                      tooltip: 'Ajouter à votre liste',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: IconButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Votre liste"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: geoList.isNotEmpty
                                      ? geoList.map((geo) => StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return GestureDetector(
                                        onTap: () {
                                          _getSpecificLocationbySelectList(geo);
                                          Navigator.of(context).pop();
                                        },
                                        child: ListTile(
                                          title: Text(geo.name),
                                          subtitle: Text(
                                            '${geo.country.toString().toUpperCase()}, ${geo.state[0].toUpperCase() + geo.state.substring(1, geo.state.length)}',
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.visibility, color: Colors.greenAccent,),
                                                onPressed: () {
                                                  _getSpecificLocationbySelectList(geo);
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.redAccent,),
                                                onPressed: () {
                                                  setState(() {
                                                    geoList.remove(geo);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )).toList()

                                      : [
                                    const Text("Vous n'avez pas encore de ville enregistrée"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Fermer'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );


                      },
                      icon: Icon(Icons.view_list),
                      tooltip: 'Consulter votre liste',
                    ),
                  ),
                ],
              )
              ,
            ],
          )

        ],
      ),
    );
  }
}
