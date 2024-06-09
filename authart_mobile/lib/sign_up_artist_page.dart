import 'package:another_project/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticationService.dart';


class SignUpArtistPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familyNameController = TextEditingController();
  final TextEditingController diplomeController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


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
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                    SizedBox(
                      height: 100,
                      child: Column(
                        children: const [
                          Text(
                            "Hello There !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "First time ? Well you have chosen the right app",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "First Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value ){
                        if(value.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                             return "Please enter correct name ";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      controller: familyNameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Family Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value ){
                        if(value.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return "Please enter correct familyname ";
                        }else{
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      controller: diplomeController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Diplome",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value ){
                        if(value.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return "Please enter correct dipmole ";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      controller: specialityController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Speciality",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value ){
                        if(value.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return "Please enter correct speciality ";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20,),
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
                      validator: (value ){
                        if(value.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)){
                          return "Please enter correct email form ";
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      controller: password1Controller,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                        validator: (value ) {
                          if (value.isEmpty) {
                            return "Please confirm your password";
                          } else if (value.length < 6) {
                            return "minimum password length is 6";
                          } else {
                            return null;
                          }
                        }
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      controller: passwordController,
                      //keyboardType: TextInputType.password,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                        validator: (value ) {
                           if (value != password1Controller.text.trim()) {
                            return "Please confirm your password correctly";
                          } else {
                            return null;
                          }
                        }
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
                         if(formKey.currentState.validate()){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                           context.read<AuthenticationService>().signUpArtist(
                             email: emailController.text.trim(),
                             password: passwordController.text.trim(),
                             name: nameController.text.trim(),
                             familyName: familyNameController.text.trim(),
                             diplome : diplomeController.text.trim(),
                             speciality : specialityController.text.trim(),
                           );

                         }

                        },
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ! "),
                        GestureDetector(onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInPage()),
                          );
                        },
                          child: Text("SignIn",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:15,
                              color: Colors.blueAccent.shade100,

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
