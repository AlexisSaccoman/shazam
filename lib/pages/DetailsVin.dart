import 'package:flutter/material.dart';
import 'package:shazam/Vin.dart';
import 'commentaires.dart';

class DetailsVin extends StatefulWidget {
  final Vin wineData;

  DetailsVin(this.wineData);

  @override
  _DetailsVinState createState() => _DetailsVinState();
}

class _DetailsVinState extends State<DetailsVin> {
  late Future<List<Commentaire>> futureCommentaires;

  @override
  void initState() {
    super.initState();
    futureCommentaires =
        CommentairesListe.getCommentaires(widget.wineData.nom!);
  }

  @override
  Widget build(BuildContext context) {
    Color couleur;
    switch (widget.wineData.typeVin['name']) {
      case 'Vin blanc':
        couleur = const Color.fromARGB(255, 173, 184, 0);
        break;
      case 'Vin rouge':
        couleur = const Color.fromARGB(255, 128, 0, 0);
        break;
      case 'Vin rosé':
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wineData.nom!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWineCircle(couleur),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  'Type: ${widget.wineData.typeVin['name']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailText('Cépage: ${widget.wineData.cepage}'),
                    _buildDetailText('Année: ${widget.wineData.millesime}'),
                    _buildDetailText(
                        'Nom de domaine: ${widget.wineData.nomDeDomaine['name']}'),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Note: 5 / 5',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Prix: ${widget.wineData.tarif}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Commentaire>>(
                future: futureCommentaires,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final commentaires = snapshot.data!;
                    return CommentairesListe(commentaires: commentaires);
                  } else {
                    return Text("Erreur ! ${snapshot.error.toString()}");
                  }
                },
              ),
            ],
          ),
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
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
