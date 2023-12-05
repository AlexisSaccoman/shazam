import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 32.0, 20.0),
                child: Text(
                  "Please log in or sign up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Username TextField
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                ),
              ),
              // Password TextField
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
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
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;

                    // afficher le contenu des champs Username et Password dans la console
                    print("Username: " + username);
                    print("Password: " + password);
                  },
                  child: Text('Login/Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
