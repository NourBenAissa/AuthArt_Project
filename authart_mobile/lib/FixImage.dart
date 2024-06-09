import 'dart:io';

import 'package:another_project/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticationService.dart';
import 'home_page.dart';
import 'model/artwork.dart';


class FixImage extends StatefulWidget {
  final String artwork_name;

  FixImage({Key key, this.artwork_name}) : super(key: key);

  @override
  State<FixImage> createState() => _FixImageState();
}

class _FixImageState extends State<FixImage> {
  List<Object> art_list = [];

  getArtworkId() async {
    /// trying to add another uid to the artwork
    var artSnap = await FirebaseFirestore.instance.collection('Artworks').get();
    art_list = List.from(artSnap.docs.map((doc) => Artwork.fromSnapShot(doc)));
    String code;
    code = "2022" + (art_list.length).toString();
    FirebaseFirestore.instance.collection('Artworks')
        .doc(widget.artwork_name)
        .update(
        {'uid': code});
  }

  String imagePath;

  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [

              SizedBox(height: 25,),
              Container(
                child: Column(
                  children: [
                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                      child: MaterialButton(
                        child: Text("Pick an Image"),
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        onPressed: () {
                          pickImage();
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent.shade100,
                      child: MaterialButton(
                        child: Text(
                          "Done", style: TextStyle(color: Colors.white),),
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        onPressed: () {
                          if (imagePath != null) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => HomePage()),);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                /*
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          onPressed: () {},
                          color: Colors.blueAccent.shade100,
                          child: Text("Camera",style: TextStyle(color: Colors.white)),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {
                          pickImage();
                        },
                        color: Colors.blueAccent.shade100,
                        child: Text("Gallery",style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image);

    var currentUser = FirebaseAuth.instance.currentUser;
    if (result != null) {
      File file = File(result.files.single.path);

      FirebaseFirestore.instance.collection('Artworks')
          .doc(widget.artwork_name)
          .update({'imagePath': ''});

      Reference imageRef = FirebaseStorage.instance.ref(
          widget.artwork_name + '.jpg');

      await imageRef.putFile(file);

      imagePath = await imageRef.getDownloadURL();
      FirebaseFirestore.instance.collection('Artworks')
          .doc(widget.artwork_name)
          .update({'imagePath': imagePath});
    }
  }

  @override
  void didChangeDependencies() {
    getArtworkId();
  }
}