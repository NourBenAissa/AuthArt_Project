import 'dart:typed_data';

import 'package:another_project/Widget/edit_artwork_button.dart';
import 'package:another_project/Widget/generate_button.dart';
import 'package:another_project/model/artwork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../Widget/follow_button.dart';
import '../userProfile.dart';

class GetArtworkData extends StatefulWidget {
  Artwork artwork;
  bool ownership;
  var userData = {};

  GetArtworkData(Artwork art, bool own){
    this.artwork=art;
    this.ownership=own;
  }

  @override
  State<GetArtworkData> createState() => _GetArtworkDataState();

}

class _GetArtworkDataState extends State<GetArtworkData> {
  Uint8List bytes;
  Uint8List artwork_bytes;
  GetImageBytes() async{
    var size = MediaQuery.of(context).size;
    final controller = ScreenshotController();
    final art_controller = ScreenshotController();
    final bytes = await controller.captureFromWidget(buildArtistImage(),);
    final art_bytes = await art_controller.captureFromWidget(
      Container(
        width: double.infinity,
        height: size.height*0.5,
        child: Image(image: NetworkImage(widget.artwork.imagePath),fit: BoxFit.cover),
      ),
    );
    setState(() {
      this.bytes = bytes;
      this.artwork_bytes = art_bytes;
    });

  }

  @override
  void didChangeDependencies() {
    GetImageBytes();
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    if( widget.ownership == false){
      return Scaffold(
        backgroundColor: Colors.white,
        body: buildBodynotowner(),
      );
    }
    if(widget.ownership != false){
      return Scaffold(
        backgroundColor: Colors.white,
        body: buildBodyowner(),
      );
    }
    return CircularProgressIndicator();

  }
  /// Artist that owns the artwork

  Widget buildBodyowner() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height*0.5,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.artwork.imagePath),fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical:30 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserProfile(currentUser.uid)),
                        );
                      },
                    ),
                    Icon(Icons.favorite_outline),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height*0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                      children: [
                        Text(
                          widget.artwork.Name,
                          //"Artwork Name",
                          style: TextStyle(fontSize: 20,height: 1.5, color: Colors.black),

                        ),
                        SizedBox(width: 30,),
                        IconButton(
                          onPressed: (){

                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,)
                      ]
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      buildArtistImage(),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.artwork.creator+"  ",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Properties : ",
                    style: TextStyle(fontSize: 15,height: 1.5),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Width",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.width+" cm",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            "Height",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.height+" cm",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            "Depth",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.depth+" cm",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.weight+" g",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Categorie : ",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      Text(
                        widget.artwork.type,
                        style: TextStyle(fontSize: 15,color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "OwnerShip : ",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      Text(
                        widget.artwork.state,
                        style: TextStyle(fontSize: 15,color: Colors.blueAccent.shade100),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Creation Date : ",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      Text(
                        widget.artwork.date,
                        style: TextStyle(fontSize: 15,color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description : ",
                    style: TextStyle(fontSize: 15,color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.artwork.desc +" ",
                    style: TextStyle(fontSize: 12,color: Colors.black54),
                  ),
                  SizedBox(height: 10),

                  Container(
                    alignment: Alignment.center,
                    child: EditArtworkButton(Colors.blueAccent, Colors.grey,'Edit Artwork',Colors.white ,'edit' ,widget.artwork),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: GenerateButton(Colors.green, Colors.white,'Generate Certificate ',Colors.white,widget.artwork, bytes, artwork_bytes),
                    //EditArtworkButton(Colors.green, Colors.white,'Generate Certificate ',Colors.white ,'generate' ,widget.artwork)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// doesnt own the artwork
  Widget buildBodynotowner() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height*0.6,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.artwork.imagePath),fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical:30 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.arrow_back),
                    Icon(Icons.favorite_outline),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height*0.50),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Container(
                      width: 150,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.artwork.Name,
                    //"Artwork Name",
                    style: TextStyle(fontSize: 20,height: 1.5, color: Colors.black),

                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      buildArtistImage(),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.artwork.creator+"  ",
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Properties : ",
                    style: TextStyle(fontSize: 15,height: 1.5),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                            "Width",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.width+" cm",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            "Height",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.height+" cm",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            "Depth",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.depth+" cm",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Column(
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                          SizedBox(height: 3,),
                          Text(
                            widget.artwork.weight+" g",
                            style: TextStyle(fontSize: 13,color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Categorie : ",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      Text(
                        widget.artwork.type,
                        style: TextStyle(fontSize: 15,color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "OwnerShip : ",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      Text(
                        widget.artwork.state,
                        style: TextStyle(fontSize: 15,color: Colors.blueAccent.shade100),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Creation Date : ",
                        style: TextStyle(fontSize: 15,color: Colors.black),
                      ),
                      Text(
                        widget.artwork.date,
                        style: TextStyle(fontSize: 15,color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description : ",
                    style: TextStyle(fontSize: 15,color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.artwork.desc +" ",
                    style: TextStyle(fontSize: 12,color: Colors.black54),
                  ),
                   (widget.artwork.state == 'sold' )?Text('this artwork is sold', style: TextStyle(fontWeight: FontWeight.normal),):Column(
                     children: [
                       Text("intrested in this artwork ?", style: TextStyle(fontWeight: FontWeight.normal,
                       ),
                       ),
                       SizedBox(height: 5),
                       Container(
                         alignment: Alignment.center,
                         child: EditArtworkButton(Colors.blueAccent, Colors.grey,'Contact Artist',Colors.white ,'contact' ,widget.artwork),
                       ),
                     ],
                   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildArtistImage() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75"),
            fit: BoxFit.cover
        ),
      ),
    );
  }
}
