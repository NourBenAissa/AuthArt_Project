import 'package:another_project/sign_up_artist_page.dart';
import 'package:another_project/sign_up_page.dart';
import 'package:another_project/subscription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChoicePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.blueAccent.shade100,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                    SizedBox(height: 30,),
                    SizedBox(
                      height: 100,
                      child: Column(

                      ),

                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        children: const [
                          Text(
                            "Who Are You ?  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/artist.png'),
                          iconSize: 140
                          ,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpArtistPage()));
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/images/normal_user.png'),
                          iconSize: 140,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpPage()));
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}