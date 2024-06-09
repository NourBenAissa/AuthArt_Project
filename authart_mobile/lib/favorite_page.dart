import 'package:another_project/model/artwork.dart';
import 'package:another_project/searchPage.dart';
import 'package:another_project/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class favoritePage extends StatefulWidget {

  @override
  State<favoritePage> createState() => _favoritePageState();
}

class _favoritePageState extends State<favoritePage> {
  List<Object> favoris = [];
  List<Object> fav_list = [];
  List<Object> art_list = [];


  @override
  void initState() {
    getData();
  }

  getData()async {
    try{
      var userSnap = await FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).get();
      favoris = (userSnap.data() as dynamic )['favorits'] ;
      var artSnap = await FirebaseFirestore.instance.collection('Artworks').get();
      art_list = List.from(artSnap.docs.map((doc) => Artwork.fromSnapShot(doc)));
      for(int i=0;i<art_list.length;i++){
        Artwork art = new Artwork();
        art = art_list[i] as Artwork;
        if (favoris.contains(art.Name)){
          fav_list.add(art);

        }
      }
      setState(() {

      });
    }catch(e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          leading: Text(""),
          title : Text('Favorites',
              style: TextStyle(color: Colors.black87, fontSize: 23)),
          backgroundColor: Colors.grey.shade50,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,


        ),
        body: SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: fav_list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5,childAspectRatio: 1),
            itemBuilder: (context, index){
              Artwork artwork = new Artwork();
              artwork = fav_list[index];
              return Container(
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(artwork.imagePath),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width/2-10,
                      height: 300,
                    ),
                    Positioned(
                      child: buildDeleteIcon(artwork),
                      bottom: 1,
                      left: 3,
                    ),
                  ],
                ),
              );
            },

          ),
        )
    );
  }
  Widget buildDeleteIcon(Artwork artwork){
    return IconButton(
      onPressed: () {
        openDialog(artwork);
      },
      icon: Icon(Icons.delete, size: 25, color: Colors.redAccent.shade200,),

    );
  }
  Future openDialog(Artwork artwork) {
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
                height: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Are You Sure you want to delete this from your favorites ?",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        ElevatedButton(

                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("No"),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).update(
                                {'favorits': FieldValue.arrayRemove([artwork.Name])});
                            Navigator.of(context, rootNavigator: true).pop();

                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
