import 'package:flutter/material.dart';
import 'commentaires.dart';

class DetailsVin extends StatelessWidget {
  final Map<String, dynamic> wineData;

  DetailsVin(this.wineData);

  @override
  Widget build(BuildContext context) {
    Color couleur;
    switch (wineData['couleur']) {
      case 'blanc':
        couleur = Color.fromARGB(255, 173, 184, 0);
        break;
      case 'rouge':
        couleur = const Color.fromARGB(255, 128, 0, 0);
        break;
      case 'rose':
        couleur = const Color.fromARGB(255, 255, 0, 85);
        break;
      case 'noir':
        couleur = const Color.fromARGB(255, 0, 0, 0);
        break;
      case 'jaune':
        couleur = const Color.fromARGB(255, 255, 255, 0);
        break;
      default:
        couleur = Colors.white; // Couleur par défaut
    }

    // Commentaires fictifs pour l'exemple
List<Commentaire> commentaires = [
  Commentaire(
    message: 'Ceci est un commentaire très intéressant.',
    date: '15 avril 2023',
    utilisateur: {'nom': 'Utilisateur1'},
    reponses: [
      Commentaire(
        message: "Merci! Content que vous l'ayez trouvé intéressant.",
        date: '16 avril 2023',
        utilisateur: {'nom': 'Utilisateur4'},
      ),
    ],
  ),
  Commentaire(
    message: 'Je préfère les vins rouges, celui-ci était excellent!',
    date: '18 avril 2023',
    utilisateur: {'nom': 'Utilisateur2'},
    reponses: [
      Commentaire(
        message: 'Les vins rouges sont vraiment spéciaux!',
        date: '19 avril 2023',
        utilisateur: {'nom': 'Utilisateur5'},
      ),
    ],
  ),
  Commentaire(
    message: 'Superbe expérience de dégustation!',
    date: '20 avril 2023',
    utilisateur: {'nom': 'Utilisateur3'},
    reponses: [
      Commentaire(
        message: "Oui, c'était incroyable! Recommande fortement.",
        date: '21 avril 2023',
        utilisateur: {'nom': 'Utilisateur6'},
      ),
      Commentaire(
        message: 'Quel était votre vin préféré?',
        date: '22 avril 2023',
        utilisateur: {'nom': 'Utilisateur7'},
        reponses: [
          Commentaire(
            message: "J'ai adoré le vin rouge!",
            date: '23 avril 2023',
            utilisateur: {'nom': 'Utilisateur8'},
          ),
        ],
      ),
    ],
  ),
];


    return Scaffold(
      appBar: AppBar(
        title: Text(wineData['titre']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWineCircle(couleur),
            SizedBox(height: 16),
            ListTile(
              title: Text(
                'Type: ${wineData['type']}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailText('Cépage: ${wineData['cepage']}'),
                  _buildDetailText('Année: ${wineData['annee']}'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Note: ${wineData['note']} / 5',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Prix: ${wineData['prix']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            CommentairesListe(commentaires: commentaires),
          ],
        ),
      ),
    );
  }

  Widget _buildWineCircle(Color couleur) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: couleur, width: 4.0),
      ),
      child: Center(
        child: Icon(
          Icons.wine_bar,
          color: couleur,
          size: 50,
        ),
      ),
    );
  }

  Widget _buildDetailText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}