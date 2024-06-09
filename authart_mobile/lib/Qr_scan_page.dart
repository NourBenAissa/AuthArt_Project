
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class qrScanPage extends StatefulWidget {

  @override
  State<qrScanPage> createState() => _qrScanPageState();
}

class _qrScanPageState extends State<qrScanPage> {

  final qrkey = GlobalKey(debugLabel: 'QR');
  Barcode barcode;
  QRViewController controller;

  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(bottom: 10,child: buildResult()),
          ],
        ),
      ),
    );

  }


  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid){

      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  Widget buildQrView(BuildContext context) => QRView (
    key:qrkey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Theme.of(context).accentColor,
      borderWidth: 20,
      borderLength: 10,
      borderRadius: 10,
      cutOutSize: MediaQuery.of(context).size.width*0.8,
    ),
  );

  void onQRViewCreated(QRViewController controller){
    setState(() {
      this.controller = controller;

      controller.scannedDataStream.listen((barcode) {
        setState(() {
          this.barcode= barcode;
        });
      });
    });
  }

  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Text(

        barcode != null ? 'Result : ${barcode.code}' : 'Scan a code !',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        maxLines: 3

    ),
  );
}
