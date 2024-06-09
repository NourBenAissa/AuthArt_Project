// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';


class Artist {
  String uid;
  String Name;
  String FName;
  String imagePath;
  String Email,spec,dip;
  List artworks;
  List following;
  List favorits;
  Artist();

  Map<String, dynamic> toJson() => {
    'uid':uid,'name':Name,'familyName':FName,'imagePath':imagePath,'email':Email,'speciality':spec,'diplome':dip,'artwork_list':artworks,'favorits':favorits,
  };

  Artist.fromSnapShot(snapshot) :
        uid = snapshot.data() ['uid'],
        Name = snapshot.data() ['name'],
        FName = snapshot.data() ['familyName'],
        imagePath = snapshot.data() ['imagePath'],
        Email = snapshot.data() ['email'],
        spec = snapshot.data() ['speciality'],
        dip = snapshot.data() ['diplome'],
      artworks = snapshot.data() ['artwork_list'],
        favorits = snapshot.data() ['favorits'];

  Map<String, dynamic> artwork_list_item(String name, String pathImage){
    return {
      'artwork':FieldValue.arrayUnion([
        {
          "name":name,
          "imagePath":pathImage,
        }
      ]),
    };
  }
  Map<String, dynamic> favoris_list_item(String name){
    return {
      'favoris':FieldValue.arrayUnion([
        {
          "name":name,
        }
      ]),
    };
  }
}