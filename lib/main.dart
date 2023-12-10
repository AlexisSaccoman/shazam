import 'dart:io';
import 'package:flutter/material.dart';
import 'pages/Accueil.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final userConnected = false;
  final userIsAdmin = false;
  final username = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(
        userConnected: userConnected,
        userIsAdmin: userIsAdmin,
        username: username,
      ),
    );
  }
}
