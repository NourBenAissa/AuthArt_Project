import 'dart:ui';

import 'package:another_project/choice_page.dart';
import 'package:another_project/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticationService.dart';
import 'home_page.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /*return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:AssetImage("assets/images/back.jpg"),
                    fit:BoxFit.cover
              )
            ),
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100,sigmaY: 100)
          ),
          Center(child: Padding(
            padding: EdgeInsets.all(size.height > 400 ? 20 : size.height > 400 ? 10 : 16),
            child: Center(
              child: Card(
                elevation: 4,
                shape: const CircleBorder(

                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: size.height * (size.height > 770 ? 0.7 : size.height > 670 ? 0.8 : 0.9),
                  width: 600,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                                  "SIGN IN",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Container(
                              width: 30,
                              child: Divider(
                                color: Colors.blueAccent.shade100,
                                thickness: 2,
                              ),
                            ),

                            SizedBox(
                              height: 32,
                            ),

                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 32,
                            ),

                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                suffixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 64,
                            ),

                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.shade100,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),

                              child: Center(

                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
              ),
            ),
          )
          ),
        ],
      )
    );*/
   return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      height: 100,
                      child: Column(
                        children:  [
                          Text(
                            "Hello Again !",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Welcome back you have been missed",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      autofocus: false,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      autofocus: false,
                      controller: passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text("                                             Forgot Password ?",textAlign: TextAlign.right,),
                    SizedBox(height: 25,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent.shade100,
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                          ///
                          /// checking if user loged succesfully he will be redirected to the homePage
                          ///
                          var currentUser = FirebaseAuth.instance.currentUser;
                          if(currentUser.uid!=null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          }
                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Container(
                          width: 40,
                          child: Divider(
                            color: Colors.blueAccent.shade100,
                            thickness: 2,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text("or continue with"),
                        SizedBox(width: 8,),
                        Container(
                          width: 40,
                          child: Divider(
                            color: Colors.blueAccent.shade100,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/icon_google.png'),
                          iconSize: 60,
                          onPressed: () {
                            context.read<AuthenticationService>().googleLogin();
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/images/icon_facebook.png'),
                          iconSize: 60,
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ! "),
                        GestureDetector(onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChoicePage()),
                          );
                        },
                          child: Text("SignUp",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:15,
                              color: Colors.blue.shade500,

                            ),
                          ),
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