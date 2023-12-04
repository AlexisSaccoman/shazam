import 'package:flutter/material.dart';
import 'CarteVins.dart';
import 'Scanner.dart';
import 'Settings.dart';
import 'Login.dart';


// page d'ACCUEIL


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.3; // 30% de la hauteur totale de l'écran

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8; // 80% de la largeur totale de l'écran

    // minimum size of buttons
    double buttonWidth = 250;
    double buttonHeight = 40;

    // space between buttons
    double spaceBetweenButtons = 20;

    return Scaffold(
      appBar: AppBar(
        title: Text('ShazaMurge'),
      ),
      body: Center(
        
        // container de la page global => décoré avec une image de fond
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("wallpaper_accueil_2.jpg"),
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
                        MaterialPageRoute(builder: (context) => CarteVins()),
                      );
                    },
                    icon: Icon(Icons.wine_bar),
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
                        MaterialPageRoute(builder: (context) => Scanner()),
                      );
                    },
                    icon: Icon(Icons.qr_code),
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
                        MaterialPageRoute(builder: (context) => Settings()),
                      );
                    },
                    icon: Icon(Icons.settings),
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

                  // Buttton => Login/Resgister
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action à effectuer lors du clic sur le bouton => passer à l'écran de login/register
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    icon: Icon(Icons.people),
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
