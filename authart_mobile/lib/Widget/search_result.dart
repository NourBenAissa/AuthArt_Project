import 'package:another_project/Widget/search_widget.dart';
import 'package:another_project/home_page.dart';
import 'package:another_project/utils/getArtistData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Services/DataServices.dart';

class SearchResult extends StatefulWidget {

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back, size: 30),
        ),
        title: Card(
          child: TextField(
            decoration:InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...'
            ),
            onChanged: (val) {
              setState(() {
                query = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: (query != "" && query != null) ? FirebaseFirestore.instance.collection('Artists')
              .where('name' , isGreaterThanOrEqualTo: query).snapshots()
              : FirebaseFirestore.instance.collection('Artists').snapshots(),
          builder: (context, snapshot){
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child : CircularProgressIndicator())
                : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Container(
                      padding: EdgeInsets.only(top: 16),
                      child : Column(
                        children: [
                          ListTile(
                            title: Text(data['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: CircleAvatar(
                              child: Image.asset("assets/images/avatar.png",width: 100, height: 50, fit: BoxFit.contain,),
                              //child: Image.network(data['imagePath'],width: 100, height: 50, fit: BoxFit.contain,),
                              radius: 40,
                              backgroundColor: Colors.blueAccent.shade100,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                ///
                                /// returning a dialog of an artist
                                ///
                                return showDialog(
                                  context: context,
                                  builder: (context) =>

                                      Center(
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.all(15),
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            height: 300,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[

                                                ClipOval(
                                                  child: Image.network(data['imagePath'],fit: BoxFit.cover,width: 128, height: 128,),
                                                ),
                                                SizedBox(height: 10,),
                                                Text(
                                                  data['name']+" "+data['familyName'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.blueAccent.shade100,
                                                  ),
                                                ),
                                                SizedBox(height: 45,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => GetArtistProfile(artistName: data['name'],artistFName: data['familyName'],imagePath: data['imagePath'],artistEmail: data['email'],),
                                                          ),
                                                        );
                                                        //String name_artist=data['name'];
                                                        //GetArtistProfile(name_artist);
                                                      },
                                                      child: Row(
                                                        children: const [
                                                          Text("See Profile "),
                                                          Icon(Icons.arrow_forward),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                );
                              },
                              icon: Icon(Icons.remove_red_eye_outlined, size: 30, color: Colors.blueAccent.shade100,),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      )
                  );
                }
            );
          }
      ),
    );
  }

  Widget buildsearch() {
    return SearchWidget(
      text: query,
      hinttext: 'Artist Name',
      onChanged: (val) {
        setState(() {
          query=val;
        });
      },
    );
  }

}
