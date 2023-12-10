import 'dart:convert';
import 'package:http/http.dart' as http;

class Note {
  num? nbEtoiles;

  Note({
    this.nbEtoiles,
  });

  Note.fromJson(Map<String, dynamic> json) {
    nbEtoiles = json['nbEtoiles'];
  }

  static Future<dynamic> getNote(nomVin) async {
    var url = Uri.parse(
        "https://pedago.univ-avignon.fr:3189/getMoyenneByVin?vin=$nomVin");
    final response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    if (response.body != "Pas de note trouvée !") {
      return Note.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }
}
