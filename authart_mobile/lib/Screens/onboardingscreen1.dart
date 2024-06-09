import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../main.dart';
import 'components/slading_clippers.dart';



class OnboardingScreenOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
           Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image:AssetImage('assets/images/splash.png'),
                  fit: BoxFit.cover,
                )
            ),),
                  Positioned(

                    right: 20,
                    bottom:20,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>AuthenticationWrapper(),
                        ),
                      );
                    },
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),

             ],

          ),



      );



  }
}