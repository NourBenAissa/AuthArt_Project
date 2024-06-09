import 'package:another_project/model/artist.dart';
import 'package:another_project/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'dashboard.dart';
import 'home_page.dart';

class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              //SearchResult()
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(labelText: 'Search an Artist'),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers? FutureBuilder(
          future: FirebaseFirestore.instance.collection('Artists').where('name', isEqualTo: searchController.text).get(),
          builder: (context, snapShot) {
            if(snapShot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: (snapShot.data as dynamic).docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Artist art = new Artist();
                    art = Artist.fromSnapShot((snapShot.data as dynamic).docs[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfile(art.uid)),
                      //SearchResult()
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage((snapShot.data as dynamic).docs[index]['imagePath']),
                  ),
                  title: Text((snapShot.data as dynamic).docs[index]['name']),
                );
              },
            );
          }
      ): /*Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text('Artworks'),
                  Icon(Icons.menu, color: Colors.black,),
              ],
            ),
          ),*/
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('Artworks').get(),
          builder: (context, snapShot){
            if(!snapShot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StaggeredGridView.countBuilder(
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                itemCount: (snapShot.data as dynamic).docs.length,
                itemBuilder: (context, index) {
                  return Image.network((snapShot.data as dynamic).docs[index]['imagePath']);
                },
                staggeredTileBuilder: (index) {
                  //return StaggeredTile.count(2,2);
                  return (index % 7 == 0)? StaggeredTile.count(1,2) : StaggeredTile.count(1,2);
                  //return StaggeredTile.fit(1);
                }
            );
          }
      ),
      //],
      //)
    );
  }
}

