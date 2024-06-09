// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';


class Artwork {
  String Name;
  String creator;
  String desc;
  String imagePath;
  String type;
  String state;
  String date;
  String width,height,depth,weight;
  int likes;
  int version;
  String uuid;
  Artwork();


  Map<String, dynamic> toJson() => {
    'uuid':uuid,'name':Name,'version':version,'creator':creator,'imagePath':imagePath,'desc':desc,'likes':likes,
    'type':type,'state':state,'date':date,'width':width,'height':height,'depth':depth,'weight':weight,
  };

  Artwork.fromSnapShot(snapshot) :
        uuid = snapshot.data() ['uuid'],
        Name = snapshot.data() ['name'],
        version = snapshot.data() ['version'],
        creator = snapshot.data() ['creator'],
        desc = snapshot.data() ['desc'],
        likes = snapshot.data() ['likes'],
        type = snapshot.data() ['type'],
        state = snapshot.data() ['state'],
        width = snapshot.data() ['width'],
        height = snapshot.data() ['height'],
        depth = snapshot.data() ['depth'],
        weight = snapshot.data() ['weight'],
        date = snapshot.data() ['date'],
        imagePath = snapshot.data() ['imagePath'];


}