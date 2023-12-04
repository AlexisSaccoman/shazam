import 'package:flutter/material.dart';
import 'DetailsVin.dart';

class CarteVins extends StatelessWidget {
  final List<Map<String, dynamic>> vins = [
  {
    'couleur': 'blanc',
    'titre': 'Sancerre, Domaine Vacheron',
    'type': 'Vin Blanc',
    'note': 4.5,
    'prix': '20 \$',
  },
  {
    'couleur': 'rouge',
    'titre': 'Chambertin Grand Cru',
    'type': 'Vin Rouge',
    'note': 3.8,
    'prix': '30 \$',
  },
  {
    'couleur': 'blanc',
    'titre': 'Château Haut-Brion Blanc',
    'type': 'Vin Blanc',
    'note': 4.2,
    'prix': '45 \$',
  },
  {
    'couleur': 'rose',
    'titre': 'Whispering Angel Rosé',
    'type': 'Vin Rosé',
    'note': 4.7,
    'prix': '25 \$',
  },
  {
    'couleur': 'rouge',
    'titre': 'Barolo Riserva',
    'type': 'Vin Rouge',
    'note': 4.6,
    'prix': '50 \$',
  },
  {
    'couleur': 'blanc',
    'titre': 'Meursault Premier Cru',
    'type': 'Vin Blanc',
    'note': 4.8,
    'prix': '55 \$',
  },
  {
    'couleur': 'rouge',
    'titre': 'Opus One',
    'type': 'Vin Rouge',
    'note': 4.9,
    'prix': '150 \$',
  },
  {
    'couleur': 'blanc',
    'titre': 'Cloudy Bay Sauvignon Blanc',
    'type': 'Vin Blanc',
    'note': 4.1,
    'prix': '30 \$',
  },
  {
    'couleur': 'rose',
    'titre': 'Domaines Ott Château de Selle Rosé',
    'type': 'Vin Rosé',
    'note': 4.6,
    'prix': '40 \$',
  },
  {
    'couleur': 'rouge',
    'titre': 'Stag\'s Leap Wine Cellars Cask 23',
    'type': 'Vin Rouge',
    'note': 4.7,
    'prix': '120 \$',
  },
  {
    'couleur': 'blanc',
    'titre': 'Rombauer Vineyards Chardonnay',
    'type': 'Vin Blanc',
    'note': 4.3,
    'prix': '35 \$',
  },
  {
    'couleur': 'jaune',
    'titre': 'Côtes du Jura, Domaine Cabélier',
    'type': 'Vin Jaune',
    'note': 4.6,
    'prix': '19 \$',
  },
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wine Card'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
        child: ListView.builder(
          itemCount: vins.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Rediriger vers la page de détails du vin
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsVin(vins[index])),
                );
              },
              child: _buildWineCard(context, vins[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWineCard(BuildContext context, Map<String, dynamic> wineData) {

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

  return Card(
    child: InkWell(
      onTap: () {
        // Rediriger vers la page de détails du vin
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsVin(wineData)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildWineCircle(couleur),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wineData['titre'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    wineData['type'],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8), // Ajout d'un espace vertical
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildWineRating(wineData['note']),
                      _buildWinePrice(wineData['prix']),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildWineCircle(Color couleur) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: couleur, width: 2.0),
      ),
      child: Center(
        child: Icon(
          Icons.wine_bar,
          color: couleur,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildWinePrice(String prix) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
      ),
      child: Text(
        prix,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildWineRating(double note) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Text('${note} / 5'),
        ],
      ),
    );
  }
}