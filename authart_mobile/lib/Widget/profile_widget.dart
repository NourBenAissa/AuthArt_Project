import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  String imagePath;
  ProfileWidget (String image) {
    imagePath=image;
  }

  //VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(color)
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    //final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: (imagePath!=''&& imagePath!=null)?Image.network(imagePath,fit: BoxFit.cover,width: 128, height: 128,):Image.asset("assets/images/avatar.png",fit: BoxFit.cover, width: 128, height: 128,),

        //child: InkWell(onTap: onClicked),

      ),
    );
  }
  /*
  Widget ReturnImage() {
    var currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid)
        .get()
  }

  */

  Widget buildEditIcon(Color color) {
    return buildCircle(
      color: Colors.white,
      all: 2,
      child: buildCircle(
        child: IconButton(
          onPressed: () {
            pickImage();
          },
          icon: Icon(Icons.edit, size: 18),

        ),
        all:1,
        color: color,
      ),);
  }

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  })
  {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }



  void pickImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

    var currentUser = FirebaseAuth.instance.currentUser;

    if (result != null) {
      File file = File(result.files.single.path);

      FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).update({'imagePath': ''});

      Reference imageRef = FirebaseStorage.instance.ref(currentUser.uid+'.jpg');

      await imageRef.putFile(file);

      imagePath = await imageRef.getDownloadURL();
      FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).update({'imagePath': imagePath});
    }
  }
}
