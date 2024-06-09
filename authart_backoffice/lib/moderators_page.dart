// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'auth_db_services.dart';
import 'models/Moderator.dart';
import 'moderator_info_details.dart';

class Moderators extends StatefulWidget {


  @override
  State<Moderators> createState() => _ModeratorsState();
}

class _ModeratorsState extends State<Moderators> {

  List<Object> _ModeratorsList = [];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familynameController = TextEditingController();

  @override
  void didChangeDependencies() {
    getModeratorsList();
  }

  Future getModeratorsList() async {
    var data = await FirebaseFirestore.instance.collection('Moderators').get();

    setState((){
      _ModeratorsList = List.from(data.docs.map((doc) => Moderator.fromSnapShot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 540,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'View All',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                    onPressed: () {
                      addModerator();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: Icon(Icons.add, color: Colors.white,)
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _ModeratorsList.length,
              itemBuilder: (context, index) => ModeratorsInfoDetail( info: _ModeratorsList[index],),
            ),
          )
        ],
      ),
    );
  }

  Future addModerator() {
    Size size = MediaQuery.of(context).size;
    return showDialog(context: context,
        builder: (context) =>AlertDialog(
          content: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height * (size.height > 770 ? 0.7 : size.height > 670 ? 0.8 : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ADD MODERATOR",
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
                          color: Colors.green,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          labelText: 'Name',

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: familynameController,
                        decoration: InputDecoration(
                          hintText: 'Family Name',
                          labelText: 'Family Name',

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                      ),

                      SizedBox(
                        height: 60,
                      ),

                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.green,
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            context.read<AuthDBServices>().registerModerator(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim(),
                              familyName: familynameController.text.trim(),
                            );
                          },
                          child: Text(
                            "Add",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
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
        ));
  }
}