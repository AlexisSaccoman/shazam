import 'package:flutter/material.dart';
import 'CarteVins.dart';
import 'Scanner.dart';
import 'Settings.dart';
import 'Login.dart';

// page d'ACCUEIL

class Home extends StatelessWidget {
  // on récupère les données passées en paramètre
  final bool userConnected;
  final bool userIsAdmin;
  final String username;

  const Home({super.key, 
    required this.userConnected,
    required this.userIsAdmin,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight =
        screenHeight * 0.3; // 30% de la hauteur totale de l'écran

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth =
        screenWidth * 0.8; // 80% de la largeur totale de l'écran

    // minimum size of buttons
    double buttonWidth = 250;
    double buttonHeight = 40;

    // space between buttons
    double spaceBetweenButtons = 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShazaMurge'),
      ),
      body: Center(
        // container de la page global => décoré avec une image de fond
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wallpaper_accueil_2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Container(
              height: containerHeight, // 30%
              width: containerWidth,
              color: const Color.fromARGB(0, 255, 255, 255),

              // Utilisation de la Column pour aligner les boutons verticalement
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Buttton => Carte des vins
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action à effectuer lors du clic sur le bouton => passer à l'écran de la carte des vins
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarteVins(
                                  userConnected: userConnected,
                                  userIsAdmin: userIsAdmin,
                                  username: username,
                                )),
                      );
                    },
                    icon: const Icon(Icons.wine_bar),
                    label: const Text('Wine menu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(buttonWidth, buttonHeight),
                    ),
                  ),

                  // Espacement vertical de 20 pixels
                  SizedBox(height: spaceBetweenButtons),

                  // Buttton => Scanner
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action à effectuer lors du clic sur le bouton => passer à l'écran de scanner
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Scanner()),
                      );
                    },
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Scanner',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(buttonWidth, buttonHeight),
                    ),
                  ),

                  // Espacement vertical de 20 pixels
                  SizedBox(height: spaceBetweenButtons),

                  // Buttton => Settings
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action à effectuer lors du clic sur le bouton => passer à l'écran de settings
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Settings()),
                      );
                    },
                    icon: const Icon(Icons.settings),
                    label: const Text('Settings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(buttonWidth, buttonHeight),
                    ),
                  ),

                  // Espacement vertical de 20 pixels
                  SizedBox(height: spaceBetweenButtons),
                  if (!userConnected)
                    // Buttton => Login/Resgister
                    ElevatedButton.icon(
                      onPressed: () {
                        // Action à effectuer lors du clic sur le bouton => passer à l'écran de login/register
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      icon: const Icon(Icons.people),
                      label: const Text("Login/Register",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(buttonWidth, buttonHeight),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
