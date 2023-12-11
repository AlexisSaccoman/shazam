import 'dart:convert';
import 'package:http/http.dart' as http;

class Vin {
  String? id;
  String? nom;
  num? tarif;
  int? millesime;
  double? volume;
  String? cepage;
  List<dynamic>? allergenes;
  double? teneurEnAlcool;
  dynamic nomDeDomaine;
  dynamic provenance;
  dynamic typeVin;
  String? ean;
  String? note;

  Vin(
      {this.id,
      this.nom,
      this.tarif,
      this.millesime,
      this.volume,
      this.cepage,
      this.allergenes,
      this.teneurEnAlcool,
      this.nomDeDomaine,
      this.provenance,
      this.typeVin,
      this.ean});

  Vin.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    tarif = json['tarif'];
    millesime = json['millesime'];
    volume = json['volume'];
    cepage = json['cepage'];
    allergenes = json['allergenes'];
    teneurEnAlcool = json['teneurEnAlcool'];
    nomDeDomaine = json['nomDeDomaine'];
    typeVin = json['typeVin'];
    ean = json['EAN'];
  }

  static Future<List<Vin>> getVins() async {
    var url = Uri.parse("https://pedago.univ-avignon.fr:3189/findVins");
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final List body = json.decode(response.body);
    return body.map((e) => Vin.fromJson(e)).toList();
  }

  // méthode pour récupérer un vin par son code EAN
  static Future<Vin> getVinByEAN(String ean) async {
    var url =
        Uri.parse("https://pedago.univ-avignon.fr:3189/findVinByEAN?ean=$ean");
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    final body = json.decode(response.body);
    return Vin.fromJson(body);
  }

  //méthode pour supprimer un vin avec son nom
  static Future<String> deleteVin(String nom) async {
    var url =
        Uri.parse("https://pedago.univ-avignon.fr:3189/deleteVin?nom=$nom");
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    return response.body;
  }

  static Future<String> addVin(nom, ean, tarif, millesime, volume, cepage,
      teneurEnAlcool, nomDeDomaine, provenance, typeVin) async {
    var url = Uri.parse(
        "https://pedago.univ-avignon.fr:3189/addVin?nom=$nom&EAN=$ean&tarif=$tarif&millesime=$millesime&volume=$volume&cepage=$cepage&teneurEnAlcool=$teneurEnAlcool&nomDeDomaine=$nomDeDomaine&provenance=$provenance&typeVin=$typeVin");
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    return response.body;
  }

  static Future<String> updateVin(nom, nouveauNom, tarif, millesime, volume,
      cepage, teneurEnAlcool, nomDeDomaine, provenance, typeVin) async {
    var url = Uri.parse(
        "https://pedago.univ-avignon.fr:3189/updateVin?nom=$nom&nouveauNom=$nouveauNom&tarif=$tarif&millesime=$millesime&volume=$volume&cepage=$cepage&teneurEnAlcool=$teneurEnAlcool&nomDeDomaine=$nomDeDomaine&provenance=$provenance&typeVin=$typeVin");
    print(url);
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    return response.body;
  }
}
