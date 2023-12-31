import 'dart:convert';
import 'package:http/http.dart' as http;

class Utilisateur {
  String? id;
  String? nom;
  String? prenom;
  String? isConnected;
  String? isAdmin;

  Utilisateur({
    this.id,
    this.nom,
    this.prenom,
    this.isConnected,
    this.isAdmin,
  });

  Utilisateur.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    prenom = json['prenom'];
    isConnected = json['isConnected'];
    isAdmin = json['isAdmin'];
  }

  static Future<String> login(id, mdp) async {
    var url = Uri.parse("https://pedago.univ-avignon.fr:3189/login");
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'mdp': mdp,
        }));
    return response.body;
  }

  static Future<String> register(id, mdp) async {
    var url = Uri.parse("https://pedago.univ-avignon.fr:3189/register");
    final response = await http.post(url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'mdp': mdp,
        }));
    return response.body;
  }
}
