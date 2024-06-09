
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/artist.dart';
import '../model/artwork.dart';
import '../model/pdf_Certificate_api.dart';
import '../model/pdf_api.dart';
import '../update_artwork.dart';



class GenerateButton extends StatefulWidget {
  Function() function;


  Color bgColor;
  Color brColor;
  String text;
  Color txtColor;
  Artwork _artwork;
  Uint8List list;
  Uint8List art_list;
  Artist _artist;

  GenerateButton(Color bg,Color br,String txt,Color t, Artwork art, Uint8List list, Uint8List al){
    this.bgColor=bg;
    this.brColor=br;
    this.text=txt;
    this.txtColor=t;
    this._artwork=art;
    this.list = list;
    this.art_list = al;
    //this.function = f ;
    //this._artist=artist;
  }
  @override
  State<GenerateButton> createState() => _GenerateButtonState();
}

class _GenerateButtonState extends State<GenerateButton> {
  var artData = {};
  getArtistData() async {
    var artSnap = await FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).get();
    artData = artSnap.data();
  }

  @override
  void initState() {
    getArtistData();
  }

  @override
  void didChangeDependencies() {
    getArtistData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(bottom: 15),
      child: TextButton(
        onPressed: () async{
          Artist artist = new Artist();
          artist.uid = artData['uid'];
          artist.imagePath = artData['imagePath'];
          artist.Name = artData['name'];
          artist.FName = artData['familyName'];
          var userData = {};
          var artSnap = await FirebaseFirestore.instance.collection('Artworks').doc(widget._artwork.Name).get();
          userData = artSnap.data();
          int v = userData['version'];
          if(v==null){
            v=0;
          }else{
            v=v+1;
          }

          FirebaseFirestore.instance.collection('Artworks').doc(widget._artwork.Name).update({'version' : v});
          final pdfFile = await PdfCertificateApi.generate(widget._artwork,artist, widget.list, widget.art_list);
          PdfApi.openFile(pdfFile);
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: widget.brColor),
            borderRadius: BorderRadius.circular(5),

          ),
          alignment: Alignment.center,
          child: Text(widget.text , style:  TextStyle(color: widget.txtColor, fontWeight: FontWeight.bold),),
          width: 250,
          height: 27,
        ),

      ),
    );
  }
}
