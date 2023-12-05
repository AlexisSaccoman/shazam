// commentaires.dart

import 'package:flutter/material.dart';

class Commentaire {
  final String message;
  final String date;
  final Map<String, dynamic> utilisateur;
  final List<Commentaire> reponses;
  final bool isAdmin;

  Commentaire({
    required this.message,
    required this.date,
    required this.utilisateur,
    this.reponses = const [],
    this.isAdmin = true,
  });
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
        SizedBox(height: 8),
        Column(
          children: commentaires.map((commentaire) {
            return CommentaireCard(commentaire: commentaire);
          }).toList(),
        ),
      ],
    );
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
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.commentaire.utilisateur['nom'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.commentaire.date,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget.commentaire.message,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.commentaire.isAdmin)
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      ),
                    onPressed: () {
                      // Afficher une boîte de dialogue de confirmation
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Voulez-vous supprimer ce commentaire?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Annuler"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Implémentez la logique de suppression ici
                                  // Par exemple, vous pouvez supprimer le commentaire de la liste
                                  setState(() {
                                    widget.commentaire.reponses.clear(); // Supprime également les réponses associées
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text("Supprimer"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                if (widget.commentaire.reponses.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showReponses = !showReponses;
                      });
                    },
                    child: Text(showReponses ? 'Cacher Réponses' : 'Voir Réponses'),
                  ),
              ],
            ),
            if (showReponses)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.commentaire.reponses.map((reponse) {
                  return CommentaireCard(commentaire: reponse);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
