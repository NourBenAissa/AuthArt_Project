


import 'package:another_project/Widget/chatpage.dart';
import 'package:another_project/model/message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authenticationService.dart';
import '../model/artwork.dart';
import '../model/pdf_Certificate_api.dart';
import '../model/pdf_api.dart';
import '../update_artwork.dart';



class EditArtworkButton extends StatefulWidget {
  //const FollowButton({Key? key}) : super(key: key);
  //Function() function;


  Color bgColor;
  Color brColor;
  String text;
  Color txtColor;
  String function;
  Artwork _artwork;
  Message _message;

  EditArtworkButton(Color bg,Color br,String txt,Color t, String f, Artwork art){
    this.bgColor=bg;
    this.brColor=br;
    this.text=txt;
    this.txtColor=t;
    this.function=f;
    this._artwork=art;
  }
  @override
  State<EditArtworkButton> createState() => _EditArtworkButtonState();
}

class _EditArtworkButtonState extends State<EditArtworkButton> {


  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextButton(
        onPressed: () async{
          if(widget.function == "edit"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UpdateArtworkPage(widget._artwork)),
            );
          }
          if(widget.function == "contact"){
           Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));


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
          height: 27,
        ),

      ),
    );
  }
}
