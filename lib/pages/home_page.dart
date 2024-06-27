import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meteo/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'account_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;
  String _buttonText = "Login";
  Session? _session;

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _session = data.session;
        _buttonText = _session != null ? "Logout" : "Login";
      });
    });
    super.initState();
  }

  Future<void> _handleSignOut() async {
    await supabase.auth.signOut();
    setState(() {
      _session = null;
      _buttonText = "Login";
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Discover'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // LOGIN & LOGOUT

                ElevatedButton(
                  onPressed: () {
                    if (_session == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else {
                      _handleSignOut();
                    }
                  },
                  child: Text(_buttonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _session == null ? Colors.blue : Colors.red,
                  ),
                ),

                // Option

                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );
                  },
                  icon: Icon(Icons.settings),
                  tooltip: 'Paramètres',
                ),
              ],
            ),

            // App

            Expanded(
              child: _session == null
                  ? Center(
                child: Text(
                  'Veuillez vous identifier pour utiliser l\'application',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bouton Geolocation
                  Column(
                    children: [
                      Image.asset(
                        'google-maps.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          print('Geolocation button pressed');
                        },
                        child: const Text('Geolocation'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Bouton Weather
                  Column(
                    children: [
                      Image.asset(
                        'la-meteo.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          print('Weather button pressed');
                        },
                        child: const Text('Weather'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
