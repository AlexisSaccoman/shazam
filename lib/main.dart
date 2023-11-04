import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

// page d'ACCUEIL
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShazaMurge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 59, 177, 255),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(30.0, 15.0, 32.0, 20.0),
              child: const Text(
                "Welcome to ShazaMurge",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 187, 255, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color.fromARGB(255, 59, 177, 255),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(30.0, 15.0, 32.0, 20.0),
              child: const Text(
                "Please log in or sign up",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 187, 255, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
