import 'package:flutter/material.dart';
import 'package:shazam/Vin.dart';
import 'DetailsVin.dart';

class CarteVins extends StatelessWidget {
  // on récupère les données passées en paramètre
  final bool userConnected;
  final bool userIsAdmin;
  Future<List<Vin>> futureVins = Vin.getVins();

  CarteVins({super.key, 
    required this.userConnected,
    required this.userIsAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wine Card'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: FutureBuilder<List<Vin>>(
          future: futureVins,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // until data is fetched, show loader
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              // once data is fetched, display it on screen (call buildPosts())
              final vins = snapshot.data!;
              return ListView.builder(
                itemCount: vins.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Rediriger vers la page de détails du vin
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsVin(vins[index]),
                        ),
                      );
                    },
                    child: _buildWineCard(context, vins[index]),
                  );
                },
              );
            } else {
              // if no data, show simple Text
              return Text("Erreur ! ${snapshot.error.toString()}");
            }
          },
        ),
      ),
    );
  }

  Widget _buildWineCard(BuildContext context, Vin wineData) {
    Color couleur;
    switch (wineData.typeVin['name']) {
      case 'Vin blanc':
        couleur = const Color.fromARGB(255, 173, 184, 0);
        break;
      case 'Vin rouge':
        couleur = const Color.fromARGB(255, 128, 0, 0);
        break;
      case 'Vin rosé':
        couleur = const Color.fromARGB(255, 255, 0, 85);
        break;
      case 'Vin noir':
        couleur = const Color.fromARGB(255, 0, 0, 0);
        break;
      case 'Vin jaune':
        couleur = const Color.fromARGB(255, 255, 255, 0);
        break;

      default:
        couleur = Colors.white; // Couleur par défaut
    }

    return Card(
      child: InkWell(
        onTap: () {
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
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wineData.nom!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      wineData.typeVin['name']!,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildWineRating(5),
                        _buildWinePrice(wineData.tarif!),
                      ],
                    ),
                  ],
                ),
              ),
              if (userConnected && userIsAdmin)
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // Show a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text("Do you want to suppress this wine ?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Vin.deleteVin(wineData.nom!);
                                print("Wine deleted: ${wineData.nom}");
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement;
                              },
                              child: const Text("Confirm"),
                            ),
                          ],
                        );
                      },
                    );
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

  Widget _buildWinePrice(num prix) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(),
      child: Text(
        prix.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildWineRating(double note) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.yellow),
          Text('$note / 5'),
        ],
      ),
    );
  }
}
