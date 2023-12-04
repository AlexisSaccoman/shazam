import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In / Register'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 32.0, 20.0),
                child: const Text(
                  "Please log in or sign up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Username TextField
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                ),
              ),
              // Password TextField
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true, // Pour masquer le texte du mot de passe
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                ),
              ),
              // Login/Register Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Action à effectuer lors du clic sur le bouton
                  },
                  child: const Text('Login/Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

