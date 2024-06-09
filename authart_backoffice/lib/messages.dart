// @dart=2.9

import 'package:authart_backoffice/Widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/Artwork.dart';
import 'moderators_page.dart';


class Chat extends StatefulWidget {
  //const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Object> _ModeratorsList = [];

  @override
  void didChangeDependencies() {
    getArtworksList();
  }

  Future getArtworksList() async {
    var data = await FirebaseFirestore.instance.collection('Moderators').get();

    setState((){
      _ModeratorsList = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Header("Moderators "),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Moderators(),
                    ),

                  ],
                ),
              ),

            ],
          ),
        )
    );
  }

}
