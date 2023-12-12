import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CarteVins.dart';

class Commentaire {
  String? id;
  String? message;
  String? date;
  dynamic? utilisateur;
  dynamic? vin;
  dynamic? note;
  List<String>? responses;

  Commentaire({
    this.message,
    this.date,
    this.utilisateur,
    this.vin,
  });

  Commentaire.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    message = json['message'];
    date = json['date'];
    utilisateur = json['utilisateur'];
    vin = json['vin'];
    note = json['note'].toString();
  }
}

class CommentairesListe extends StatelessWidget {
  List<Commentaire> commentaires;
  final userIsConnected;
  final userIsAdmin;
  final username;

  CommentairesListe(
      {required this.commentaires,
      required this.userIsConnected,
      required this.userIsAdmin,
      required this.username});

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
            return CommentaireCard(
                commentaire: commentaire,
                userIsConnected: userIsConnected,
                userIsAdmin: userIsAdmin,
                username: username,
                commentaireList: this);
          }).toList(),
        ),
      ],
    );
  }

  static Future<List<Commentaire>> getCommentaires(nom) async {
    var url = Uri.parse(
        "https://pedago.univ-avignon.fr:3189/findCommentaireByVinName");
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(<String, String>{
          'nom': nom,
        }));
    final List body = json.decode(response.body);
    return body.map((e) => Commentaire.fromJson(e)).toList();
  }

  static Future<String> postCommentaire(message, nomVin, username, note) async {
    var url = Uri.parse("https://pedago.univ-avignon.fr:3189/addCommentaire");
    var body;
    if (note == null) {
      body = jsonEncode(<String, String>{
        'message': message,
        'nomVin': nomVin,
        'username': username,
      });
    } else {
      body = jsonEncode({
        'message': message,
        'vin': nomVin,
        'id': username,
        'note': note,
      });
    }
    print("$message, $nomVin, $username, $note");
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: body);
    return response.body;
  }

  static Future<String> deleteCommentaire(id) async {
    var url =
        Uri.parse("https://pedago.univ-avignon.fr:3189/deleteCommentaire");
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(<String, String>{
          '_id': id,
        }));
    return response.body;
  }

  static Future<String> updateCommentaire(id, message, note) async {
    var url =
        Uri.parse("https://pedago.univ-avignon.fr:3189/updateCommentaire");
    var body;
    if (note == null ||
        note == "null" ||
        note == "Pas encore noté !" ||
        note == "") {
      body = jsonEncode(<String, String>{
        '_id': id,
        'message': message,
      });
    } else {
      body = jsonEncode(<String, String>{
        '_id': id,
        'message': message,
        'note': note,
      });
    }
    print(url);
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: body);
    return response.body;
  }
}

class CommentaireCard extends StatefulWidget {
  final Commentaire commentaire;
  final userIsConnected;
  final userIsAdmin;
  final username;
  CommentairesListe commentaireList;
  CommentaireCard({
    required this.commentaire,
    required this.userIsConnected,
    required this.userIsAdmin,
    required this.username,
    required this.commentaireList,
  });

  @override
  _CommentaireCardState createState() => _CommentaireCardState();
}

class _CommentaireCardState extends State<CommentaireCard> {
  bool showReponses = false;

  @override
  Widget build(BuildContext context) {
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
                  widget.commentaire.utilisateur['pseudoUser'],
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
                if (widget.userIsConnected && widget.userIsAdmin)
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // Show a confirmation dialog for deletion
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
                                onPressed: () async {
                                  try {
                                    // Call the deleteCommentaire method
                                    final response = await CommentairesListe
                                        .deleteCommentaire(
                                            widget.commentaire.id);

                                    if (response
                                        .contains("Commentaire supprimé !")) {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarteVins(
                                            userConnected:
                                                widget.userIsConnected,
                                            userIsAdmin: widget.userIsAdmin,
                                            username: widget.username,
                                          ),
                                        ),
                                      );
                                      // Display success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Commentaire supprimé !'),
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Erreur pendant la suppression !"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Supprimer"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                if (widget.userIsConnected && widget.userIsAdmin)
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      // Show a dialog for editing the comment
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController commentController =
                              TextEditingController(
                                  text: widget.commentaire.message);
                          final TextEditingController noteController =
                              TextEditingController(
                                  text: widget.commentaire.note == "null"
                                      ? "Pas encore noté !"
                                      : widget.commentaire.note);

                          return AlertDialog(
                            title: const Text("Modifier le commentaire"),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    labelText: 'Comment',
                                    hintText: 'Enter your comment',
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: noteController,
                                  decoration: const InputDecoration(
                                    labelText: 'Note',
                                    hintText: 'Enter your note',
                                  ),
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
                                    // Call the deleteCommentaire method
                                    final response = await CommentairesListe
                                        .updateCommentaire(
                                            widget.commentaire.id,
                                            commentController.text,
                                            noteController.text);

                                    if (response
                                        .contains("Commentaire mis à jour !")) {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CarteVins(
                                            userConnected:
                                                widget.userIsConnected,
                                            userIsAdmin: widget.userIsAdmin,
                                            username: widget.username,
                                          ),
                                        ),
                                      );
                                      // Display success message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Commentaire mis à jour !'),
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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                        },
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
