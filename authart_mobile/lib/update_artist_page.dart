import 'package:another_project/model/artist.dart';
import 'package:another_project/sign_in_page.dart';
import 'package:another_project/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widget/artist_profile_widget.dart';
import 'Widget/profile_widget.dart';
import 'authenticationService.dart';


class UpdateArtistPage extends StatefulWidget {
Artist artist;


  @override
  State<UpdateArtistPage> createState() => _UpdateArtistPageState();
}

class _UpdateArtistPageState extends State<UpdateArtistPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController familyNameController = TextEditingController();

  final TextEditingController diplomeController = TextEditingController();

  final TextEditingController specialityController = TextEditingController();

  var currentUser = FirebaseAuth.instance.currentUser;





  /*Artist artist = new Artist();
  getUser() async{
    var usersnap = await FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).get();
    artist = usersnap.data() as Artist;
    nameController.text = artist.Name;
    familyNameController.text = artist.FName;
  }*/
  @override
  Widget build(BuildContext context) {

    CollectionReference artists = FirebaseFirestore.instance.collection('Artists');
    nameController.text=widget.artist.Name;
    familyNameController.text=widget.artist.FName;

    return FutureBuilder(
        future: artists.doc(currentUser.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;

                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              UserProfile(currentUser.uid)),
                        );
                      },ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
                    ),
                    title: Text('Edit Profile',
                      style: TextStyle(color: Colors.black87, fontSize: 23),),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              ArtistProfileWidget("${data['imagePath']}"),
                              SizedBox(height: 30,),
                              Text("Name", style: TextStyle(
                                  color: Colors.black, fontSize: 14),),
                              TextFormField(
                                autofocus: false,
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      15, 10, 15, 10),

                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("Family Name", style: TextStyle(
                                  color: Colors.black, fontSize: 14),),

                              TextFormField(
                                autofocus: false,
                                controller: familyNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      15, 10, 15, 10),
                                ),
                              ),

                              SizedBox(height: 20,),
                              Text("Diplome ", style: TextStyle(
                                  color: Colors.black, fontSize: 14),),

                              // Text(artist.Name, style: TextStyle(color: Colors.black, fontSize: 15),),
                              TextFormField(
                                autofocus: false,
                                controller: diplomeController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      15, 10, 15, 10),

                                ),
                              ),
                              SizedBox(height: 20,),
                              Text("Speciality", style: TextStyle(
                                  color: Colors.black, fontSize: 14),),
                              TextFormField(
                                autofocus: false,
                                controller: specialityController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.fromLTRB(
                                      15, 10, 15, 10),

                                ),
                              ),
                              SizedBox(height: 80,),
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  minWidth: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfile(currentUser.uid)));
                                    context.read<AuthenticationService>()
                                        .UpdateArtist(
                                      name: nameController.text.trim(),
                                      familyName: familyNameController.text
                                          .trim(),
                                      diplome: diplomeController.text.trim(),
                                      speciality: specialityController.text
                                          .trim(),
                                    );
                                  },
                                  child: Text(
                                    "Update",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                );
              }
              return CircularProgressIndicator(color: Colors.white,);
            },
    );
  }

}
