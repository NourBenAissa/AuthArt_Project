import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widget/profile_widget.dart';
import '../home_page.dart';



class ProfileWrapper extends StatelessWidget {
  var currentUser = FirebaseAuth.instance.currentUser;

  String role() {
    if (FirebaseFirestore.instance.collection('Users')
        .doc(currentUser.uid)
        .get() != null) {
      return "user";
    } else if (FirebaseFirestore.instance.collection('Artists')
        .doc(currentUser.uid)
        .get() != null) {
      return "artist";
    } else {
      return "alela";
    }
  }


  @override
  Widget build(BuildContext context) {
    if (role() == "user") {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(

              onPressed: () {Navigator.push(
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
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [

              ProfileWidget("${documentSnapshot.data()['imagePath']}"),
              const SizedBox(height: 24,),
              Column(
                children: [
                  Text(
                    "${documentSnapshot.data()['Name']}"" "+"${documentSnapshot.data()['familyName']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    "${documentSnapshot.data()['email']}",
                    style: TextStyle( color: Colors.grey,),
                  ),
                ],
              ),
              //Center(child: buildUpradeButton(),),
            ],
          ),
        );
      });
    } else if(role()=="artist"){
      FirebaseFirestore.instance
          .collection('Artists')
          .doc(currentUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(

              onPressed: () {Navigator.push(
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
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [

              ProfileWidget("${documentSnapshot.data()['imagePath']}"),
              const SizedBox(height: 24,),
              Column(
                children: [
                  Text(
                    "${documentSnapshot.data()['Name']}"" "+"${documentSnapshot.data()['familyName']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    "${documentSnapshot.data()['email']}",
                    style: TextStyle( color: Colors.grey,),
                  ),
                ],
              ),
              //Center(child: buildUpradeButton(),),
            ],
          ),
        );
      });
    }
    return Container( child: Text("big alela 12"),);
  }
}

