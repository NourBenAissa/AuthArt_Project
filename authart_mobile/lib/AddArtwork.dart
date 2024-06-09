

import 'package:another_project/sign_in_page.dart';
import 'package:another_project/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'FixImage.dart';
import 'authenticationService.dart';


class AddArtwork extends StatefulWidget {
  @override
  State<AddArtwork> createState() => _AddArtworkState();
}

class _AddArtworkState extends State<AddArtwork> {
  final TextEditingController WidthController = TextEditingController();

  final TextEditingController depthController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController StateController = TextEditingController();

  final TextEditingController DescriptionController = TextEditingController();

  final TextEditingController WeightController = TextEditingController();

  final TextEditingController DateController = TextEditingController();

  final TextEditingController TypeController = TextEditingController();

  DateTime _dateTime;
  String type='painting';
  String state='own';
  String creator;

  final types = ['painting','sculpture','gravure','Dessin','Caligraphie','typographie','barelief'];
  final states = ['sold','own'];
  final formKey = GlobalKey<FormState>();
  var currentUser = FirebaseAuth.instance.currentUser;
  String artist_name;

  var uuid = Uuid().v1;
  int version = 0;
  @override
  void didChangeDependencies() {
    getCreator();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile(currentUser.uid)),
            );
          },
        ),
      ),
      body: Center(
        //child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children:<Widget> [
                  Flexible(
                    child: SizedBox(
                      height: 50,
                      child: Column(
                        children: const [
                          Text(
                            "Adding Artwork",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Flexible(
                    child: TextFormField(
                      autofocus: false,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Artwork Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value ){
                        if(value.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return "Please enter correct  artwork name ";
                        }else{
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          autofocus: false,
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.account_circle),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Height",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value ){
                            if(value.isEmpty ){
                              return "Please enter a value ";
                            }else{
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          autofocus: false,
                          controller: WidthController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.account_circle),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Width",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value ){
                            if(value.isEmpty ){
                              return "Please enter a value ";
                            }else{
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          autofocus: false,
                          controller: depthController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.account_circle),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Depth",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value ){
                            if(value.isEmpty ){
                              return "Please enter a value ";
                            }else{
                              return null;
                            }
                          },
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 20,),
                  TextFormField(
                    autofocus: false,
                    controller: WeightController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.account_circle),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Weight",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value ){
                      if(value.isEmpty ){
                        return "Please enter a value ";
                      }else{
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 20,),
                  Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                    child: MaterialButton(
                      child: Text(_dateTime == null ? "Pick a Date" : _dateTime.toString()),
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2222)
                        ).then((date) {
                          setState(() {
                            _dateTime=date;
                          });
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    //margin: EdgeInsets.all(16),
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: type,
                        iconSize: 30,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                        items: types.map(buildMenuItem).toList(),
                        onChanged: (value){
                          setState(() {
                            type=value;
                          });
                        },
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                    //margin: EdgeInsets.all(16),
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: state,
                        iconSize: 30,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.grey,),
                        items: states.map(buildMenuItem).toList(),
                        onChanged: (value){
                          setState(() {
                            state=value;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
                  TextFormField(
                    autofocus: false,
                    controller: DescriptionController,
                    //keyboardType: TextInputType.password,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      //prefixIcon: Icon(Icons.vpn_key),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value ){
                      if(value.isEmpty ){
                        return "Please enter a description ";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20,),

                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          context.read<AuthenticationService>().AddArtwork(
                            uuid: uuid.toString(),
                            version: version,
                            name: nameController.text.trim(),
                            width: WidthController.text.trim(),
                            height: heightController.text.trim(),
                            depth: depthController.text.trim(),
                            date: _dateTime.toString(),
                            weight: WeightController.text.trim(),
                            state: state,
                            type: type,
                            desc: DescriptionController.text.trim(),
                            creator: artist_name,
                          );
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  FixImage(artwork_name: nameController.text
                                      .trim(),)),);
                        };

                      },
                      child: Text(
                        "next",
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
        //),
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item){
    return DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle( fontSize: 16, color: Colors.black54),
        )
    );
  }


  void getCreator() {
    FirebaseFirestore.instance
        .collection('Artists')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      artist_name ='${documentSnapshot.data() ['name']}';
    });
  }

}
