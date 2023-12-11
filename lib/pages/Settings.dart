import 'package:flutter/material.dart';
import 'Accueil.dart';

class Settings extends StatefulWidget {
  final bool userConnected;
  final bool userIsAdmin;
  final String username;

  const Settings(
      {super.key,
      required this.userConnected,
      required this.userIsAdmin,
      required this.username});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Username
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 8.0),

            // Password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 8.0),

            // Confirm Password
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 8.0),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement save logic
                saveSettings();
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 4.0),

            if (widget.userConnected)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        userConnected: false,
                        userIsAdmin: false,
                        username: "",
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Vous êtes maintenant déconnecté !"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Logout'),
              ),
          ],
        ),
      ),
    );
  }

  void saveSettings() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // TODO: Implement your save logic here

    // For demonstration purposes, just print the values
    print('Username: $username');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');
  }
}
