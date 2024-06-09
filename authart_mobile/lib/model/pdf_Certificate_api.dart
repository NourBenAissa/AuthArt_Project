import 'dart:io';
import 'dart:typed_data';
import 'package:another_project/model/artist.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
//import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'artwork.dart';

class PdfCertificateApi {
  static Future<File> generate(Artwork artwork, Artist artist, Uint8List list, Uint8List art_list)async {
    final pdf = Document();
    //final imagePng = ( await rootBundle.load("assets/images/certif_header.png")).buffer.asUint8List();
    pdf.addPage(Page(
      build: (context) =>
      //Center(child: Text(text,style: TextStyle(fontSize: 48))),
      Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTitle(),
              SizedBox(height: 10),
              buildCopie(artwork),
              SizedBox(height: 10),
              buildArtist(artist, list),
              SizedBox(height: 10),
              buildArtwork(artwork),
              SizedBox(height: 10),
              buildArtworkPreview(art_list,artwork),
            ]
        ),
      ),

    ));
    return saveDocument(name: 'Certificate.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({ String name,Document pdf})async{
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }
  static Future openFile(File file)async{
    final url = file.path;
    await OpenFile.open(url);
  }

  static Widget buildTitle() {
    return
      Center (
          child: Text('Artwork  Authenticity  Certificate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
      );

  }

  static Widget buildCopie(Artwork artwork) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Code : "/*+artwork.uuid+artwork.version.toString()*/, style: TextStyle(fontSize: 15)),
        Text("Copie N°:"/*+artwork.version.toString()+'/10'*/, style: TextStyle(fontSize: 15)),

      ],
    );
  }
  static Widget buildArtwork(Artwork artwork){
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1
            ),
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
          ),

          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "    ",
                  style: TextStyle(
                      color: PdfColors.black,
                      fontSize: 18)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                      "Released on :",
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 20)
                  ),
                  SizedBox(height: 15),
                  Text(
                      artwork.date,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 14)
                  ),
                  SizedBox(height: 15),
                  Text(
                      "Technic :",
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 20)
                  ),
                  SizedBox(height: 15),
                  Text(
                      artwork.type,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 14)
                  ),
                  SizedBox(height: 20),
                  (artwork.state == "own")?Text(
                      "Current owner : "+artwork.creator,
                      style: TextStyle(
                          color: PdfColors.grey,
                          fontSize: 14)
                  ):Text(
                      "Current owner : sold",
                      style: TextStyle(
                          color: PdfColors.grey,
                          fontSize: 14)
                  ),
                ],
              ),
              SizedBox(width: 90),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                        "Sizes",
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 20)
                    ),
                    SizedBox(height: 15),
                    Text(
                        "Width : "+artwork.width,
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 14)
                    ),
                    SizedBox(height: 15),
                    Text(
                        "Height : "+artwork.height,
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 14)
                    ),
                    SizedBox(height: 15),
                    Text(
                        "Depth : "+artwork.depth,
                        style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 14)
                    ),
                    SizedBox(height: 15),
                  ]
              ),
            ],
          ),

        ),
        Positioned(
            left: 50,
            top: 12,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: PdfColors.white,
              child: Text(
                'Artwork Details',
                style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 15),
              ),
            )),
      ],
    );
  }
  static Widget buildArtworkPreview(Uint8List art_list, Artwork artwork){
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 170,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: PdfColors.white,
                //color: Color.fromARGB(255, 51, 204, 255),
                width: 1),
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
          ),

          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "    ",
                  style: TextStyle(
                      color: PdfColors.white,
                      fontSize: 18)
              ),
              Image(MemoryImage(art_list)),
              SizedBox(width: 120),
              buildQRCode(artwork),
            ],
          ),

        ),
        Positioned(
            left: 50,
            top: 12,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: PdfColors.white,
              child: Text(
                'Artwork Preview',
                style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 15),
              ),
            )),
      ],
    );
  }
  static Widget buildArtist(Artist artist, Uint8List list) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 170,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1),
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
          ),

          child: Row(
            children: [
              Text(
                  "    ",
                  style: TextStyle(
                      color: PdfColors.white,
                      fontSize: 18)
              ),
              Image(MemoryImage(list)),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                      "Name : "+artist.Name,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18)
                  ),
                  SizedBox(height: 20,width: 20),
                  Text(
                      "Family Name : "+artist.FName,
                      style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18)
                  ),
                ],
              ),
            ],
          ),

        ),
        Positioned(
            left: 50,
            top: 12,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: PdfColors.white,
              child: Text(
                'Artist',
                style: TextStyle(
                    color: PdfColors.black,
                    fontSize: 15),
              ),
            )),
      ],
    );
  }
  static Widget buildQRCode(Artwork artwork) {
    return Column(
      children: [
        SizedBox(height: 25),
        Text('Scan To Verify', style: TextStyle(fontSize: 15),),
        SizedBox(height: 5),
        Container(
          height: 75,
          width: 75,
          child: BarcodeWidget(
              data: artwork.uuid,
              barcode: Barcode.qrCode()
          ),
        ),

      ],
    );
  }
}