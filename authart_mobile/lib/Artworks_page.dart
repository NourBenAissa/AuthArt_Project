import 'package:another_project/home_page.dart';
import 'package:another_project/utils/getArtworkData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/artwork.dart';
class ArtworkPage extends StatefulWidget {

  @override
  State<ArtworkPage> createState() => _ArtworkPage();
}



class _ArtworkPage extends State<ArtworkPage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  List<Object> _ArtworkList = [];
  String query='';


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getArtworkList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back, size: 30),
        ),
        backgroundColor: Colors.grey.shade50,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,


      ),
      body: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount:  _ArtworkList.length,
        //padding: EdgeInsets.all(20),
        separatorBuilder: (context, _)=> SizedBox(height: 15),
        itemBuilder: (context, index){
          return _buildPost(_ArtworkList[index] as Artwork);
        },
        //padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,

      ),
    );
  }

  Future getArtworkList() async {
    var data = await FirebaseFirestore.instance.collection('Artworks').orderBy('date').get();

    setState((){
      _ArtworkList = List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    });
  }

  /// Returning a post Artwork
  Widget _buildPost(Artwork artwork) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: double.infinity,
        height: 560.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    /*leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50.0,
                            width: 50.0,
                            image: AssetImage(posts[index].authorImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),*/
                    title: Text(
                      artwork.Name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(artwork.creator),
                    /*trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.black,
                      onPressed: () => print('More'),
                    ),*/
                  ),
                  InkWell(
                    onDoubleTap: () {
                      FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).update({'favorits':FieldValue.arrayUnion([artwork.Name])});
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GetArtworkData(artwork,false),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 1.0,
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(artwork.imagePath),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  iconSize: 30.0,
                                  onPressed: () => print('Like post'),
                                ),
                                Text(
                                  '2,515',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            /*SizedBox(width: 20.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.chat),
                                  iconSize: 30.0,
                                  onPressed: () {
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewPostScreen(
                                          post: posts[index],
                                        ),
                                      ),
                                    );*/
                                  },
                                ),
                                Text(
                                  '350',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                        /*IconButton(
                          icon: Icon(Icons.bookmark_border),
                          iconSize: 30.0,
                          onPressed: () => print('Save post'),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
