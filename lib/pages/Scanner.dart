import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'DetailsVin.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wine Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Scanner un code-barres'),
            ),
            Text('Barcode Result: $result'),
          ],
        ),
      ),
    );
  }

  Future scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Annuler', true, ScanMode.BARCODE);

    setState(() {
      result = barcodeScanRes;
    });
  }
}


/*
// Vérifiez si le code est dans la base de données (remplacez ceci par votre logique)
                bool isInDatabase = true;

                if (isInDatabase) {
                  // Affichez les détails du vin dans une nouvelle fenêtre

                  // Passez les données du vin à la nouvelle fenêtre
                  final List<Map<String, dynamic>> wineData = [
                    {
                      'couleur': 'blanc',
                      'titre': 'Sancerre, Domaine Vacheron',
                      'type': 'Vin Blanc',
                      'note': 4.5,
                      'prix': '20 \$',
                    },
                  ];
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsVin(wineData[0])),
                  );
                } else {
                  // Affichez un message si le code n'est pas dans la base de données
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Code non trouvé dans la base de données.'),
                    ),
                  );
                }
                
 */