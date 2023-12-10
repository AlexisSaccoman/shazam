import 'dart:convert';
import 'package:shazam/pages/CarteVins.dart';

import 'Accueil.dart';
import 'package:flutter/material.dart';
import 'package:shazam/Utilisateur.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In / Register'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                ),
              ),
              // Password TextField
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true, // Pour masquer le texte du mot de passe
                  decoration: const InputDecoration(
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

                    try {
                      final response =
                          await Utilisateur.login(username, password);

                      if (response
                          .contains("Vous êtes maintenant connecté !")) {
                        // Display success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vous êtes maintenant connecté !'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Extract user information from the response
                        final userInfo = json.decode(response)['user'];
                        final bool userConnected = userInfo['isConnected'];
                        final bool userIsAdmin = userInfo['isAdmin'];
                        final String username = userInfo['identifiant'];

                        // Navigate to the next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarteVins(
                              userConnected: userConnected,
                              userIsAdmin: userIsAdmin,
                              username: username,
                            ),
                          ),
                        );
                      } else {
                        // Display error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (e) {
                      // Handle exceptions during the login process
                      print("Error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Erreur pendant le login !"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String username = usernameController.text;
                    String password = passwordController.text;

                    try {
                      // Call the login function
                      final response =
                          await Utilisateur.register(username, password);

                      if (response == "Utilisateur ajouté !") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Vous êtes maintenant inscrit !'),
                                backgroundColor: Colors.green));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(response),
                            backgroundColor: Colors.red));
                      }
                    } catch (e) {
                      print("Error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Erreur pendant le login !"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
