import 'package:flutter/material.dart';
import 'pages/Accueil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final userConnected = false;
  final userIsAdmin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(
        userConnected: userConnected,
        userIsAdmin: userIsAdmin,
      ),
    );
  }
}
