// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:meteo/models/geo-location-model.dart';
// import 'package:meteo/models/weather-details-model.dart';
// import 'package:meteo/services/geo-location-service.dart';
// import 'package:meteo/services/weather-details-service.dart';
//
// Future main() async {
//   await dotenv.load(fileName: ".env");
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Future<Geolocation> geoLoc;
//   late Future<WeatherDetails> weatherDetails;
//
//   @override
//   void initState() {
//     super.initState();
//     geoLoc = GeoLocationService.fetchGeoLoc();
//     weatherDetails = WeatherDetailsService.fetchWeatherDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FutureBuilder<Geolocation>(
//               future: geoLoc,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       Text(snapshot.data!.name),
//                       Text(snapshot.data!.country),
//                       Text(snapshot.data!.state),
//                       Text(snapshot.data!.longitude.toString()),
//                       Text(snapshot.data!.latitude.toString()),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//
//                 // Spinner
//                 return const CircularProgressIndicator();
//               },
//             ),
//             FutureBuilder<WeatherDetails>(
//               future: weatherDetails,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       Text(snapshot.data!.name),
//                       Text(snapshot.data!.base),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }
//
//                 // Spinner
//                 return const CircularProgressIndicator();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:meteo/pages/account_page.dart';
// import 'package:meteo/pages/login_page.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// Future<void> main() async {
//   await Supabase.initialize(
//     url: 'https://uuaxmgxynftomlmbhtpd.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1YXhtZ3h5bmZ0b21sbWJodHBkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk0NzQ0NTEsImV4cCI6MjAzNTA1MDQ1MX0.MUlpnQXh8C4lu1diYj26QkdsLzlo6LlQna6U-UuTJoY',
//   );
//   runApp(const MyApp());
// }
//
// final supabase = Supabase.instance.client;
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'World Discover',
//       theme: ThemeData.dark().copyWith(
//         primaryColor: Colors.green,
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.green,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.green,
//           ),
//         ),
//       ),
//       home: supabase.auth.currentSession == null
//           ? const AccountPage()
//           : const LoginPage(),
//     );
//   }
// }
//
// // Gestion erreur login a deplacer dans plus tard
// extension ContextExtension on BuildContext {
//   void showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError
//             ? Theme.of(this).colorScheme.error
//             : Theme.of(this).snackBarTheme.backgroundColor,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:meteo/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

  // TODO: FIX ENV
  // await dotenv.load(fileName: ".env");
  // final String? URL_BAISE = dotenv.env['URL_SUPERBAISE'];
  // final String? ANON_KEY = dotenv.env['ANON_KEY'];

  await Supabase.initialize(
    // url: URL_BAISE!,
    // anonKey: ANON_KEY!,
    url: 'https://uuaxmgxynftomlmbhtpd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1YXhtZ3h5bmZ0b21sbWJodHBkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk0NzQ0NTEsImV4cCI6MjAzNTA1MDQ1MX0.MUlpnQXh8C4lu1diYj26QkdsLzlo6LlQna6U-UuTJoY',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Discover',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// Gestion erreur login a deplacer dans plus tard
extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
