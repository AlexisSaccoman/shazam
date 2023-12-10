import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../Vin.dart';
import 'DetailsVin.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wine Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: scanBarcode,
              icon: const Icon(Icons.qr_code),
              label: const Text('Scan a barcode'),
            ),
          ],
        ),
      ),
    );
  }

  Future scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Annuler', true, ScanMode.BARCODE);

    setState(() {

      // trouver le vin correspondant au code-barres scanné
      //utiliser la méthode getVin de la classe Vin pour vérifier si le vin existe avec le code EAN scanné puis afficher les détails du vin
      Vin.getVinByEAN(barcodeScanRes).then((value) => {
        if(value == null){
          //afficher un message d'erreur
          result = "This wine doesn't exist in our database"
        }else{
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsVin(value),
          ),
        )
        }
      });
        });
  }
}
