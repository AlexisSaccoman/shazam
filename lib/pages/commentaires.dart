// commentaires.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Commentaire {
  String? message;
  String? date;
  dynamic? utilisateur;
  dynamic? vin;
  List<String>? responses;

  Commentaire({
    this.message,
    this.date,
    this.utilisateur,
    this.vin,
  });

  Commentaire.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    utilisateur = json['utilisateur'];
    vin = json['vin'];
  }
}

class CommentairesListe extends StatelessWidget {
  final List<Commentaire> commentaires;

  CommentairesListe({required this.commentaires});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Commentaires:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: commentaires.map((commentaire) {
            return CommentaireCard(commentaire: commentaire);
          }).toList(),
        ),
      ],
    );
  }

  static Future<List<Commentaire>> getCommentaires(nom) async {
    var url = Uri.parse(
        "https://pedago.univ-avignon.fr:3189/findCommentaireByVinName?nom=${nom}");
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final List body = json.decode(response.body);
    return body.map((e) => Commentaire.fromJson(e)).toList();
  }
}

class CommentaireCard extends StatefulWidget {
  final Commentaire commentaire;

  CommentaireCard({required this.commentaire});

  @override
  _CommentaireCardState createState() => _CommentaireCardState();
}

class _CommentaireCardState extends State<CommentaireCard> {
  bool showReponses = false;

  @override
  Widget build(BuildContext context) {
    print(widget.commentaire.date);
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //widget.commentaire.utilisateur['pseudoUser'],
                  widget.commentaire.message!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.commentaire.date!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.commentaire.message!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //if (widget.commentaire.utilisateur?.isAdmin == true)
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    // Afficher une boîte de dialogue de confirmation
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmation"),
                          content: const Text(
                              "Voulez-vous supprimer ce commentaire?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Annuler"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Implémentez la logique de suppression ici
                                // Par exemple, vous pouvez supprimer le commentaire de la liste
                                // setState(() {
                                //   widget.commentaire.reponses
                                //       .clear(); // Supprime également les réponses associées
                                // });
                                Navigator.of(context).pop();
                              },
                              child: const Text("Supprimer"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                // if (widget.commentaire.responses!.)
                //   ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         showReponses = !showReponses;
                //       });
                //     },
                //     child: Text(
                //         showReponses ? 'Cacher Réponses' : 'Voir Réponses'),
                //   ),
              ],
            ),
            // if (showReponses)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: widget.commentaire.reponses.map((reponse) {
            //       return CommentaireCard(commentaire: reponse);
            //     }).toList(),
            //   ),
          ],
        ),
      ),
    );
  }
}
