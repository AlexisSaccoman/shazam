import 'package:flutter/material.dart';
import 'package:shazam/Vin.dart';
import 'DetailsVin.dart';
import 'package:shazam/Note.dart';
import 'package:shazam/Domaine.dart';
import 'package:shazam/typeVin.dart';
import 'package:shazam/Pays.dart';

class CarteVins extends StatelessWidget {
  // on récupère les données passées en paramètre
  bool userConnected;
  bool userIsAdmin;
  String username;
  String note = "Pas encore noté !";
  Future<List<Vin>> futureVins = Vin.getVins();

  CarteVins({super.key, 
    required this.userConnected,
    required this.userIsAdmin,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    Domaine? dropdownDomaine =
        Domaine.ARLenoble; // valeurs par défaut des listes déroulantes
    Pays? dropdownPays = Pays.France;
    TypeVin? dropdownTypeVin = TypeVin.VinBlanc;
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
                          builder: (context) => DetailsVin(vins[index], note,
                              userConnected, userIsAdmin, username),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.wine_bar),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final TextEditingController nomController =
                    TextEditingController(text: "");
                final TextEditingController eanController =
                    TextEditingController(text: "");
                final TextEditingController tarifController =
                    TextEditingController(text: "");
                final TextEditingController millesimeController =
                    TextEditingController(text: "");
                final TextEditingController volumeController =
                    TextEditingController(text: "");
                final TextEditingController cepageController =
                    TextEditingController(text: "");
                final TextEditingController teneurEnAlcoolController =
                    TextEditingController(text: "");

                return AlertDialog(
                  title: const Text("Ajouter un vin"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nomController,
                        decoration: const InputDecoration(
                          labelText: 'Wine name',
                          hintText: 'Enter your wine name',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        controller: eanController,
                        decoration: const InputDecoration(
                          labelText: 'Wine EAN',
                          hintText: 'Enter your EAN code',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        controller: tarifController,
                        decoration: const InputDecoration(
                          labelText: 'Wine price',
                          hintText: 'Enter your wine price',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        controller: millesimeController,
                        decoration: const InputDecoration(
                          labelText: 'Wine vintage',
                          hintText: 'Enter your wine vintage',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        controller: volumeController,
                        decoration: const InputDecoration(
                          labelText: 'Wine volume',
                          hintText: 'Enter your wine volume',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        controller: cepageController,
                        decoration: const InputDecoration(
                          labelText: 'Wine variety',
                          hintText: 'Enter your wine variety',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        controller: teneurEnAlcoolController,
                        decoration: const InputDecoration(
                          labelText: 'Wine alcohol content',
                          hintText: 'Enter your wine alcohol content',
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      DropdownButton<Domaine>(
                        value: dropdownDomaine,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: Domaine.domaines.map((item) {
                          return DropdownMenuItem<Domaine>(
                            value: item,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (value) => {dropdownDomaine = value},
                      ),
                      const SizedBox(height: 8.0),
                      DropdownButton<Pays>(
                        value: dropdownPays,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: Pays.countries.map((item) {
                          return DropdownMenuItem<Pays>(
                            value: item,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          dropdownPays = value;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      DropdownButton<TypeVin>(
                        value: dropdownTypeVin,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: TypeVin.wineTypes.map((item) {
                          return DropdownMenuItem<TypeVin>(
                            value: item,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (value) => {dropdownTypeVin = value},
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Annuler"),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          final response = await Vin.addVin(
                              nomController.text,
                              eanController.text,
                              tarifController.text,
                              millesimeController.text,
                              volumeController.text,
                              cepageController.text,
                              teneurEnAlcoolController.text,
                              dropdownDomaine.toString().replaceAll(' ', ''),
                              dropdownPays.toString().replaceAll(' ', ''),
                              dropdownTypeVin.toString().replaceAll(' ', ''));

                          if (response.contains("Vin ajouté !")) {
                            Navigator.of(context).pop();
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
                            // Display success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vin ajouté !'),
                                backgroundColor: Colors.green,
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
                          // Handle exceptions during the deletion process
                          print("Error: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Erreur pendant la modification !"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text("Enregistrer"),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  Widget _buildWineCard(BuildContext context, Vin wineData) {
    Color couleur;
    switch (wineData.typeVin['name']) {
      case 'Vin blanc' || 'Vin Blanc':
        couleur = const Color.fromARGB(255, 173, 184, 0);
        break;
      case 'Vin rouge' || 'Vin Rouge':
        couleur = const Color.fromARGB(255, 128, 0, 0);
        break;
      case 'Vin rosé' || 'Vin Rose':
        couleur = const Color.fromARGB(255, 255, 0, 85);
        break;
      case 'Vin noir' || 'Vin Dessert':
        couleur = const Color.fromARGB(255, 0, 0, 0);
        break;
      case 'Vin jaune' || 'Vin Mousseux':
        couleur = const Color.fromARGB(255, 255, 255, 0);
        break;

      default:
        couleur = Colors.blue; // Couleur par défaut
    }

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsVin(
                    wineData,
                    wineData.note ?? "Pas encore noté !",
                    userConnected,
                    userIsAdmin,
                    username)),
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
                        _buildWineRating(wineData),
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

  Future<String> _getWineRating(String nom) async {
    // Assuming Note.getNote returns a Future<Note>
    Note? noteData = await Note.getNote(nom);

    if (noteData != null) {
      return '${noteData.nbEtoiles} / 5';
    } else {
      return 'Pas encore noté !';
    }
  }

  Widget _buildWineRating(Vin wineData) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.yellow),
          FutureBuilder<String>(
            future: _getWineRating(wineData.nom!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                wineData.note = snapshot.data!;
                return Text(snapshot.data!);
              } else {
                return const Text("Pas encore noté !");
              }
            },
          ),
        ],
      ),
    );
  }
}
