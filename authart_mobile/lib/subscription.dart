import 'package:another_project/sign_in_page.dart';
import 'package:another_project/sign_up_artist_page.dart';
import 'package:another_project/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SubscriptionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                    SizedBox(height: 30,),
                    SizedBox(
                      height: 80,
                      child: Column(
                        children: const [
                          Text(
                            "Subscription ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Our plans ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 250,
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blueAccent,
                                width: 1),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),

                         ///basic plan ///
                          child: SizedBox(height: 10,
                            child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                            Row(
                            children: [
                            Icon(Icons.add_photo_alternate_sharp , color: Colors.red[500]),
                            const Text('  Limited number of artworks (5)'),
                              ],
                            ),
                            Row(
                               children: [
                                 Image.asset('assets/images/ads.png', width: 20,height: 20,),
                                  const Text('  Full ads display '),
                                   ],
                                  ),
                            Row(
                                    children: [
                                      Image.asset('assets/images/xmark.png', width: 20,height: 15,),
                                      const Text('  Comments'),
                                    ],
                                  ),
                            Row(
                                    children: [

                                     Image.asset('assets/images/xmark.png', width: 20,height: 15,),
                                      const Text('  Chat'),
                                    ],
                            ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,

                                    children: [
                                      Material(
                                        elevation: 5,

                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueAccent.shade100,
                                        child: MaterialButton(
                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => SignUpArtistPage()),
                                            );
                                          },
                                          child: Text(
                                            "Go Basic        ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                               ],
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
                                'Basic ',
                                style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                              ),
                            )),
                      ],
                    ),


                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 395,
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.green,
                                width: 1),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),

                          ///Premium  plan
                          child: SizedBox(height: 70,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.add_photo_alternate_sharp , color: Colors.green[500]),
                                    const Text('  Unlimited number of artworks '),
                                  ],
                                ),
                                Row(
                                  children: [

                                    Image.asset('assets/images/pdf.png', width: 20,height: 20,),
                                    const Text('  1 original PDF Authentication '),
                                  ],
                                ),
                                Text('Cetificate for everyArtwork               '),
                                Row(
                                  children: [

                                    Image.asset('assets/images/download.png', width: 20,height: 20,),
                                    const Text('  Print/download 10 times PDF '),
                                  ],
                                ),
                                Text('Authentification Cetificate for           '),
                                Text( 'an artwork                                             '),
                                Row(
                                  children: [
                                    Image.asset('assets/images/noads.png', width: 20,height: 20,),
                                    const Text('  Less ads '),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset('assets/images/check.png', width: 20,height: 20,),
                                    const Text('  Comments'),
                                  ],
                                ),
                                Row(
                                  children: [

                                    Image.asset('assets/images/check.png', width: 20,height: 20,),
                                    const Text('  Chat'),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,

                                  children: [
                                    Material(
                                      elevation: 5,

                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade200,
                                      child: MaterialButton(
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SignUpArtistPage()),
                                          );
                                        },
                                        child: Text(
                                          "Go Premium",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                                'Premium  ',
                                style: TextStyle(color: Colors.green, fontSize: 15),
                              ),
                            )),
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