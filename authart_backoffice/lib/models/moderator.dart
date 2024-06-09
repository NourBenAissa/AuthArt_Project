// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';


class Moderator{
  String Name;
  String fName;
  String imagePath;
  String date;
  Moderator();


  Map<String, dynamic> toJson() => {
    'name':Name,'imagePath':imagePath,
    'date':date,'familyName':fName,
  };

  Moderator.fromSnapShot(snapshot) :
        fName=snapshot.data() ['familyName'],
        Name = snapshot.data() ['name'],
        date = snapshot.data() ['date'],
        imagePath = snapshot.data() ['imagePath'];


}