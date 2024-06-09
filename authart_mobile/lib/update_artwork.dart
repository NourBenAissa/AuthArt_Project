import 'package:another_project/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticationService.dart';
import 'model/artwork.dart';

class UpdateArtworkPage  extends StatefulWidget {
  Artwork artwork;
  UpdateArtworkPage(Artwork art){
    this.artwork=art;
  }
  @override
  State<UpdateArtworkPage> createState() => _UpdateArtworkPageState();
}

class _UpdateArtworkPageState extends State<UpdateArtworkPage> {


  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;



  @override
  Widget build(BuildContext context) {

    descriptionController.text = widget.artwork.desc;
    nameController.text = widget.artwork.Name;
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
                },
              ),
              title: Text('Edit Artwork ',
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

                        //ArtworkWidget("${data['imagePath']}"),
                        SizedBox(height: 30,),
                        Text("Name", style: TextStyle(
                            color: Colors.black, fontSize: 14),),
                        TextFormField(
                          autofocus: false,

                          controller: nameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                           // hintText: (widget.artwork.Name),
                            contentPadding: EdgeInsets.fromLTRB(
                                15, 10, 15, 10),

                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Description ", style: TextStyle(
                            color: Colors.black, fontSize: 14),),

                        // Text(artist.Name, style: TextStyle(color: Colors.black, fontSize: 15),),
                        TextFormField(
                          autofocus: false,
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
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
                              context.read<AuthenticationService>()
                                  .UpdateArtwork(
                                art: widget.artwork,
                                name: nameController.text.trim(),
                                desc: descriptionController.text.trim(),
                              );
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfile(currentUser.uid)));
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

  @override
  void initState() {

  }
}
