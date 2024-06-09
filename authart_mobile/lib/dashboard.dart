import 'package:another_project/Artworks_page.dart';
import 'package:another_project/searchPage.dart';
import 'package:another_project/settings.dart';
import 'package:another_project/userProfile.dart';
import 'package:another_project/utils/getProfileData.dart';
import 'package:another_project/utils/getUserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';

import 'Widget/artwork_list_item.dart';
import 'Widget/circle_list_item.dart';
import 'Widget/search_result.dart';
import 'Widget/search_widget.dart';
import 'authenticationService.dart';
import 'model/artist.dart';
import 'model/artwork.dart';
class Dashboard extends StatefulWidget {

  @override
  State<Dashboard> createState() => _Dashboard();
}



class _Dashboard extends State<Dashboard> {
  var currentUser = FirebaseAuth.instance.currentUser;
  List<Object> _ArtistsList = [];
  List<Object> _ArtworkList = [];
  List<Object> _MostLikedArtworksList = [];
  String query='';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getArtistsList();
    getArtworkList();
    getMostLikedArtworksList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile(currentUser.uid)),
            );
          },
          icon: Icon(Icons.person, size: 30),
        ),
        backgroundColor: Colors.grey.shade50,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {

              dynamic conversationObject = {
                'appId': '2a66fb5c5e839235f8d2e1388124798fa',
              };

              KommunicateFlutterPlugin.buildConversation(conversationObject)
                  .then((clientConversationId) {
                print("Conversation builder success : " + clientConversationId.toString());
              }).catchError((error) {
                print("Conversation builder error : " + error.toString());
              });


            },
            icon: new Image.asset('assets/images/chatbot.png', height: 27,width: 27,),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
                //SearchResult()
              );
            },
            icon: Icon(Icons.search, size: 30),
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Artists",
                    style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 140,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white,
                        //color: Color.fromARGB(255, 51, 204, 255),
                        width: 0),
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),

                  ///
                  ///       Artist List View
                  ///
                  child:
                  SizedBox(
                    height: 140,
                    child: ListView.separated(
                      itemCount:  _ArtistsList.length,
                      padding: EdgeInsets.all(20),
                      separatorBuilder: (context, _)=> SizedBox(width: 15),
                      itemBuilder: (context, index){
                        return CircleListItem(_ArtistsList[index] as Artist);
                      },
                      //padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,

                    ),
                  ),

                ),

              ],
            ),

            ///      Newest Artworks

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Newest Artworks",
                    style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  //Icon(Icons.arrow_forward),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ArtworkPage()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward)
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 350,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white,
                        //color: Color.fromARGB(255, 51, 204, 255),
                        width: 0),
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),
                  /// ArtWorks List View

                  child:
                  SizedBox(
                    height: 350,
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

              ],
            ),

            /// Most Liked Artworks

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Most Liked Artworks",
                    style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ArtworkPage()),
                        );
                      },
                      icon: Icon(Icons.arrow_forward)
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 350,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.white,
                        //color: Color.fromARGB(255, 51, 204, 255),
                        width: 0),
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                  ),
                  child: SizedBox(
                    height: 350,
                    child: ListView.separated(
                      itemCount:  _MostLikedArtworksList.length,
                      padding: EdgeInsets.all(16),
                      separatorBuilder: (context, _)=> SizedBox(width: 10),
                      itemBuilder: (context, index){
                        return ArtworkListItem(_MostLikedArtworksList[index] as Artwork);
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Most Liked Artworks",
                    style: TextStyle(fontSize: 20,color: Colors.grey.shade50,fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getArtistsList() async {
    var data = await FirebaseFirestore.instance.collection('Artists').get();

    setState((){
      _ArtistsList = List.from(data.docs.map((doc) => Artist.fromSnapShot(doc)));
    });
  }

  Future getArtworkList() async {
    var data = await FirebaseFirestore.instance.collection('Artworks').orderBy('date').get();

    setState((){
      _ArtworkList = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });
  }

  Future getMostLikedArtworksList() async {
    var data = await FirebaseFirestore.instance.collection('Artworks').get();

    setState((){
      _MostLikedArtworksList = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });
  }


}
