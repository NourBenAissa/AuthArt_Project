
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AddArtwork.dart';
import '../Widget/artist_profile_widget.dart';
import '../Widget/artwork_list_item.dart';
import '../Widget/buttonWidget.dart';
import '../Widget/profile_widget.dart';
import '../dashboard.dart';
import '../model/artwork.dart';
import 'getArtistData.dart';
class GetUserData extends StatefulWidget {
  final String documentId;
  const GetUserData(this.documentId);
  @override
  State<GetUserData> createState() => _GetUserData();
}



class _GetUserData extends State<GetUserData> {

  var currentUser = FirebaseAuth.instance.currentUser;
  List<Object> _ArtworkList = [];
  String name;
  @override
  void didChangeDependencies() {
    getArtworkList();
    getCreator();
  }
  final user_data = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          ///
          ///
          ///                       Retrieve Artist Data from table artists
          ///
          ///
          CollectionReference artists = FirebaseFirestore.instance.collection('Artists');
          return FutureBuilder<DocumentSnapshot>(
            future: artists.doc(currentUser.uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                //return Text("Document does not exist");
                /// Retriving user data from google
                return Scaffold(

                  appBar: AppBar(
                    //iconTheme: IconThemeData(color: Colors.black),
                   /* leading: BackButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },

                    ),*/
                    elevation: 0,
                    //backgroundColor: Colors.transparent,

                  ),
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [

                      ProfileWidget(user_data.photoURL),
                      const SizedBox(height: 24,),
                      Column(
                        children: [
                          Text(
                            user_data.displayName,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            user_data.email,
                            style: TextStyle( color: Colors.grey,),
                          ),
                          const SizedBox(height: 20,),

                        ],
                      ),
                      Center(child: buildUpradeButton(),),
                    ],
                  ),
                );




              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
                return Scaffold(


                  appBar: AppBar(
                   /* iconTheme: IconThemeData(color: Colors.black),
                    leading: BackButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },

                    ),*/

                    elevation: 0,
                    backgroundColor: Colors.transparent,

                  ),
                  body: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [

                      ArtistProfileWidget("${data['imagePath']}"),
                      const SizedBox(height: 24,),
                      Column(
                        children: [
                          Text(
                            "${data['name']}"" "+"${data['familyName']}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            "${data['email']}",
                            style: TextStyle( color: Colors.grey,),
                          ),
                        ],
                      ),
                      Center(child: buildArtworkButton(),),


                      Stack(
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
                            /// ArtWorks List View

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
                                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                color: Colors.white,
                                child: Text(
                                  'My ArtWorks',
                                  style: TextStyle(color: Colors.black45, fontSize: 15),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),

                );
              }

              return CircularProgressIndicator(color: Colors.white,);
            },
          );

        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              /*leading: BackButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },

              ),*/
              elevation: 0,
              backgroundColor: Colors.transparent,
             /* actions: const [
                IconButton(
                  icon: Icon(Icons.menu),
                ),
              ],*/
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [

                ProfileWidget("${data['imagePath']}"),
                const SizedBox(height: 24,),
                Column(
                  children: [
                    Text(
                      "${data['name']}"" "+"${data['familyName']}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      "${data['email']}",
                      style: TextStyle( color: Colors.grey,),
                    ),
                    const SizedBox(height: 20,),

                  ],
                ),
                Center(child: buildUpradeButton(),),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator(color: Colors.white,));
      },
    );
  }



  Widget buildUpradeButton() {
    return ButtonWidget(
      text: 'Upgrade to pro',
      onClicked: () {},
    );
  }
  Widget buildArtworkButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddArtwork()),
          );
        },
        child: Text("Add Artwork")
    );
  }

  Future getArtworkList() async {
    var data = await FirebaseFirestore.instance.collection('Artworks').where('creator',isEqualTo: currentUser.uid).get();

    setState((){
      _ArtworkList = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });
  }
  void getCreator() {

    FirebaseFirestore.instance
        .collection('Artists')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      name ='${documentSnapshot.data() ["name"]}';

    });
  }



}