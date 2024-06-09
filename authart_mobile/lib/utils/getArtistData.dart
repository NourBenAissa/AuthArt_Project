import 'package:another_project/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widget/artist_profile_widget.dart';
import '../Widget/artwork_list_item.dart';
import '../Widget/buttonWidget.dart';
import '../Widget/profile_widget.dart';
import '../dashboard.dart';
import '../model/artwork.dart';
import 'getUserData.dart';

class GetArtistProfile extends StatefulWidget {
  final String artistName;
  final String artistEmail;
  final String imagePath;
  final String artistFName;
  GetArtistProfile({Key key, this.artistName, this.artistEmail, this.imagePath, this.artistFName}) : super(key: key);

  @override
  State<GetArtistProfile> createState() => _GetArtistProfileState();
}

class _GetArtistProfileState extends State<GetArtistProfile> {
  List<Object> _ArtworkList = [];

  @override
  void didChangeDependencies() {
    getArtworkList();
  }

  @override
  Widget build(BuildContext context) {
    getArtworkList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          IconButton(
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25,),
              ClipOval(
                child: Image.network(widget.imagePath,fit: BoxFit.cover,width: 128, height: 128,),
              ),
              SizedBox(height: 10,),
              Text(
                widget.artistName+" "+widget.artistFName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blueAccent.shade100,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                widget.artistEmail,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {},
                child: Text("  Folow  ",style: TextStyle(color: Colors.white,fontSize: 18),),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RatingButton(context, '0','Folowers'),
                  RatingButton(context,'0','Artworks'),
                  RatingButton(context,'0','Likes'),
                ],
              ),
              SizedBox(height: 20),
              buildAbout(),
              SizedBox(height: 25,),
              buildArtworkList(),
            ],
          ),
        ),),
      /*body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ArtistProfileWidget(imagePath),
          const SizedBox(height: 24,),
          Column(
            children: [
              Text(
                artistName+" "+artistFName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4,),
              Text(
                artistEmail,
                style: TextStyle( color: Colors.grey,),
              ),
            ],
          ),
        ],
      ),*/
    );
  }

  Widget RatingButton(BuildContext context, String value, String text){
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget buildAbout(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'About',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            'Certified Artist from Beaux Arts Nabeul with 10 years experience in painting and a small online shop',
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );


  }

  Widget buildArtworkList() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 350,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black26,
                //color: Color.fromARGB(255, 51, 204, 255),
                width: 1),
            borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle,
          ),

          child: SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount:  _ArtworkList.length,
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, _)=> SizedBox(width: 10),
              itemBuilder: (context, index){
                return ArtworkListItem(_ArtworkList[index] as Artwork);
              },
              //padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Positioned(
            left: 50,
            top: 12,
            child: Container(
              padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
              color: Colors.white,
              child: Text(
                'ArtWorks',
                style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }

  Future getArtworkList() async {
    var data = await FirebaseFirestore.instance.collection('Artworks').where('creator',isEqualTo: widget.artistName).get();

    setState((){
      _ArtworkList = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });
  }


}