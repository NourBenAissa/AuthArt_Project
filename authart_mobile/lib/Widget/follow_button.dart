
import 'package:another_project/AddArtwork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../update_artist_page.dart';



class FollowButton extends StatefulWidget {
  //const FollowButton({Key? key}) : super(key: key);
  Function() func;
  Color bgColor;
  Color brColor;
  String text;
  Color txtColor;
  String function;
  String uid;
  FollowButton(Color bg,Color br,String txt,Color t, String f, String uid, Function func){
    this.bgColor=bg;
    this.brColor=br;
    this.text=txt;
    this.txtColor=t;
    this.function=f;
    this.uid=uid;
    this.func=func;
  }
  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  var userData = {};

  followArtist(){
    FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).update(
        {'followings': FieldValue.arrayUnion([widget.uid])}) ;
    FirebaseFirestore.instance.collection('Artists').doc(widget.uid).update({'followers' : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser.uid])});
  }
  followUser(){
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).update(
        {'followings': FieldValue.arrayUnion([widget.uid])})  ;
  }
  unfollowUser(){
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).update(
        {'followings': FieldValue.arrayRemove([widget.uid])});
  }
  unfollowArtist(){
    FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).update(
        {'followings': FieldValue.arrayRemove([widget.uid])})  ;
    FirebaseFirestore.instance.collection('Artists').doc(widget.uid).update({'followers' : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser.uid])});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: TextButton(
        onPressed: () {
          widget.func;
          ///todo adding a 1 to followers in artist doc
          if(widget.function == 'Up'){

          }else if(widget.function == 'Add'){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddArtwork()),
            );
          }else if(widget.function == "update"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateArtistPage()),
            );
          }else if(widget.function == 'follow_user'){
            followUser();
          }else if(widget.function == 'follow_artist'){
            followArtist();
          }else if(widget.function == 'unfollow_artist'){
            unfollowArtist();
          }else if(widget.function == 'unfollow_artist'){
            unfollowArtist();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: widget.brColor),
            borderRadius: BorderRadius.circular(5),

          ),
          alignment: Alignment.center,
          child: Text(widget.text , style:  TextStyle(color: widget.txtColor, fontWeight: FontWeight.bold),),
          width: 250,
          height: 30,
        ),

      ),
    );
  }
}
