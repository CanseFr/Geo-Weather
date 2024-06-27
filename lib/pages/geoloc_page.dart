
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeolocPage extends StatefulWidget {
  const GeolocPage({super.key});

  @override
  State<GeolocPage> createState() => _GeolocPageState();
}

class _GeolocPageState extends State<GeolocPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GeoLoc')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Column(children: [
            Text("GeoLoc Page")
          ],),

        ],
      ),
    );
  }
}