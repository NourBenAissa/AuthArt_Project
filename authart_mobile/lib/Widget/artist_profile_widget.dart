import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ArtistProfileWidget extends StatelessWidget {
  String imagePath;
   var currentUser = FirebaseAuth.instance.currentUser;
  ArtistProfileWidget (String image) {
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
        child: (imagePath!='' || imagePath != null)?Image.network(imagePath,fit: BoxFit.cover,width: 128, height: 128,):Image.asset("assets/images/avatar.png",fit: BoxFit.cover, width: 128, height: 128,),

        //child: InkWell(onTap: onClicked),

      ),
    );
  }

  Widget buildEditIcon(Color color) {
    return buildCircle(
      color: Colors.white,

        child: IconButton(
          onPressed: () {
            pickImage();
          },
          icon: Icon(Icons.photo_camera_outlined, size: 28),
        ),
     );
  }

  Widget buildCircle({
    Widget child,

     color: Colors.white,
  })
  {
    return ClipOval(
      child: Container(

        color: Colors.white,
        child: child,
      ),
    );
  }



  void pickImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

    var currentUser = FirebaseAuth.instance.currentUser;

    if (result != null) {
      File file = File(result.files.single.path);

      FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).update({'imagePath': ''});

      Reference imageRef = FirebaseStorage.instance.ref(currentUser.uid+'.jpg');

      await imageRef.putFile(file);

      imagePath = await imageRef.getDownloadURL();
      FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).update({'imagePath': imagePath});
    }
  }
}
