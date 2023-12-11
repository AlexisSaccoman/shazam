import 'package:flutter/material.dart';
import 'package:shazam/Vin.dart';
import 'package:shazam/pages/CarteVins.dart';
import 'commentaires.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shazam/Domaine.dart';
import 'package:shazam/typeVin.dart';
import 'package:shazam/Pays.dart';

class DetailsVin extends StatefulWidget {
  final Vin wineData;
  String note;
  final bool userConnected;
  final bool userIsAdmin;
  final String username;

  DetailsVin(this.wineData, this.note, this.userConnected, this.userIsAdmin,
      this.username);

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
    final TextEditingController commentController = TextEditingController();
    double? userRating;
    Color couleur;
    Domaine? dropdownDomaine = Domaine.domaines.first;
    Pays? dropdownPays = Pays.countries.first;
    TypeVin? dropdownTypeVin = TypeVin.wineTypes.first;

    switch (widget.wineData.typeVin['name']) {
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
                    if (widget.userConnected && widget.userIsAdmin)
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                final TextEditingController nomController =
                                    TextEditingController(
                                        text: widget.wineData.nom);
                                final TextEditingController tarifController =
                                    TextEditingController(
                                        text: widget.wineData.tarif.toString());
                                final TextEditingController
                                    millesimeController = TextEditingController(
                                        text: widget.wineData.millesime
                                            .toString());
                                final TextEditingController volumeController =
                                    TextEditingController(
                                        text:
                                            widget.wineData.volume.toString() ==
                                                    "null"
                                                ? ""
                                                : widget.wineData.volume
                                                    .toString());
                                final TextEditingController cepageController =
                                    TextEditingController(
                                        text: widget.wineData.cepage);
                                final TextEditingController
                                    teneurEnAlcoolController =
                                    TextEditingController(
                                        text: widget.wineData.teneurEnAlcool
                                                    .toString() ==
                                                "null"
                                            ? ""
                                            : widget.wineData.teneurEnAlcool
                                                .toString());

                                return AlertDialog(
                                  title: const Text("Modifier un vin"),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            hintText:
                                                'Enter your wine alcohol content',
                                          ),
                                        ),
                                        const SizedBox(height: 2.0),
                                        DropdownButton<Domaine>(
                                          value: dropdownDomaine,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: Domaine.domaines.map((item) {
                                            return DropdownMenuItem<Domaine>(
                                              value: item,
                                              child: Text(item.name),
                                            );
                                          }).toList(),
                                          onChanged: (value) =>
                                              {dropdownDomaine = value},
                                        ),
                                        const SizedBox(height: 8.0),
                                        DropdownButton<Pays>(
                                          value: dropdownPays,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
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
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: TypeVin.wineTypes.map((item) {
                                            return DropdownMenuItem<TypeVin>(
                                              value: item,
                                              child: Text(item.name),
                                            );
                                          }).toList(),
                                          onChanged: (value) =>
                                              {dropdownTypeVin = value},
                                        ),
                                      ],
                                    ),
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
                                          final response = await Vin.updateVin(
                                              widget.wineData.nom,
                                              nomController.text,
                                              tarifController.text,
                                              millesimeController.text,
                                              volumeController.text,
                                              cepageController.text,
                                              teneurEnAlcoolController.text,
                                              dropdownDomaine
                                                  .toString()
                                                  .replaceAll(' ', ''),
                                              dropdownPays
                                                  .toString()
                                                  .replaceAll(' ', ''),
                                              dropdownTypeVin
                                                  .toString()
                                                  .replaceAll(' ', ''));

                                          if (response
                                              .contains("Vin modifié !")) {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CarteVins(
                                                  userConnected:
                                                      widget.userConnected,
                                                  userIsAdmin:
                                                      widget.userIsAdmin,
                                                  username: widget.username,
                                                ),
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('Vin modifié !'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          } else {
                                            // Display error message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(response),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          // Handle exceptions during the deletion process
                                          print("Error: $e");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Erreur pendant la modification !"),
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
                      )
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Note: ${widget.note}",
                      style: const TextStyle(
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
                    return CommentairesListe(
                        commentaires: commentaires,
                        userIsConnected: widget.userConnected,
                        userIsAdmin: widget.userIsAdmin,
                        username: widget.username);
                  } else {
                    return Text("Erreur ! ${snapshot.error.toString()}");
                  }
                },
              ),
              if (widget.userConnected)
                // Username
                TextFormField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    hintText: 'Enter your comment',
                  ),
                ),
              const SizedBox(height: 16.0),
              if (widget.userConnected)
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    userRating =
                        rating; // on sauvegarde la note de l'utilisateur
                  },
                ),
              if (widget.userConnected)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final response =
                            await CommentairesListe.postCommentaire(
                                commentController.text,
                                widget.wineData.nom,
                                widget.username,
                                userRating);

                        if (response.contains("Commentaire ajouté !")) {
                          // Display success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Commentaire ajouté !'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarteVins(
                                      userConnected: widget.userConnected,
                                      userIsAdmin: widget.userIsAdmin,
                                      username: widget.username,
                                    )),
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
                            content: Text("Erreur d'ajout du commentaire !"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text('Send your comment !'),
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
