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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
              child: const Text('Parametres'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Geolocation button pressed');
              },
              child: const Text('Geolocation'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Weather button pressed');
              },
              child: const Text('Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
