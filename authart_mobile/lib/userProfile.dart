
import 'package:another_project/Side/menuItem.dart';
import 'package:another_project/Widget/follow_button.dart';
import 'package:another_project/home_page.dart';
import 'package:another_project/model/artist.dart';
import 'package:another_project/searchPage.dart';
import 'package:another_project/sign_in_page.dart';
import 'package:another_project/update_artist_page.dart';
import 'package:another_project/utils/getArtworkData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'AddArtwork.dart';
import 'authenticationService.dart';
import 'model/artwork.dart';

class UserProfile extends StatefulWidget {
  String uid;
  UserProfile(String uid){
    this.uid=uid;
  }
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Object> _ArtworksList = [];
  List<Object> art_list = [];
  List<Object> list = [];
  List<Object> followings = [];
  List<Object> followers = [];
  var userData = {};
  var currentUserData = {};
  bool isfollowing = false;
  String role="artist";
  @override
  void initState() {
    super.initState();
    getData();
    getListData();
  }

  getData() async {
    try{
      var userSnap = await FirebaseFirestore.instance.collection('Artists').doc(widget.uid).get();
      if (userSnap == null ){
        userSnap = await FirebaseFirestore.instance.collection('Users').doc(widget.uid).get();
        role = "user";
      }
      userData = userSnap.data();
      if(role == "artist"){
        var usnap = await FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).get();
        currentUserData = usnap.data();
        followings = (currentUserData as dynamic)['followings'];
        isfollowing = (followings.contains(userData['uid']));
        /// list of followers people who followed you
        followers = (userData as dynamic)['followers'];
      }else if(role == "user"){
        var usnap = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).get();
        currentUserData = usnap.data();
        followings = (currentUserData as dynamic)['followings'];
        isfollowing = (followings.contains(userData['uid']));
      }

      setState(() {

      });
    }catch(e) {
      print(e);
    }
  }
  getListData() async {
    try {
      var userSnap = await FirebaseFirestore.instance.collection('Artists').doc(
          widget.uid).get();
      list = (userSnap.data() as dynamic)['artworks'];
      var artSnap = await FirebaseFirestore.instance.collection('Artworks')
          .get();
      art_list =
          List.from(artSnap.docs.map((doc) => Artwork.fromSnapShot(doc)));
      for (int i = 0; i < art_list.length; i++) {
        Artwork art = new Artwork();
        art = art_list[i] as Artwork;
        if(list.contains(art.Name)){
          _ArtworksList.add(art);
        }
      }
      setState(() {

      });
    }catch(e){

    }
  }

/*
  @override
  void didChangeDependencies() {
    //getArtworksList();
    //getData();
    //GetListData();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        leading: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              //Navigator.of(context, rootNavigator: true).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title: (userData['name']==null)?Text('.....', style: TextStyle(color: Colors.black),):Text(userData['name'], style: TextStyle(color: Colors.black),),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){
                showMaterialModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top:  Radius.circular(20),
                    )
                  ),
                  context: context,
                  builder: (context) =>  buildSheet(),
                );

              },
              icon: Icon(Icons.menu , color: Colors.black,)),
        ],
      ),

      body: (role == "artist") ? buildBodyArtist(userData) : buildBodyUser(userData),
    );
  }
  Widget buildBodyUser(var userData){
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: (userData['imagePath'] == null)?NetworkImage('https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75'):NetworkImage(userData['imagePath']),
                    radius: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildStatColumn(userData['favorites'].length,'favorites'),
                            buildStatColumn(150, 'followings'),
                          ],
                        ),
                        (userData['uid'] == FirebaseAuth.instance.currentUser.uid) ?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FollowButton(Colors.white, Colors.grey,'Edit',Colors.black ,'Edit',userData['uid'], () {}),
                          ],
                        ): Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (isfollowing)?FollowButton(Colors.white, Colors.grey,'UnFollow',Colors.black ,'unfollow_user',userData['uid'],() {setState(() {
                              isfollowing = false;
                            });}):FollowButton(Colors.blueAccent, Colors.grey,'Follow',Colors.white ,'follow_user',userData['uid'], () {setState(() {
                              isfollowing = true;
                            });}),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 15),
                child: (userData['name'] == null )?Text('.....', style: TextStyle(fontWeight: FontWeight.bold),):Text(userData['name'], style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  'Some Discription',

                ),
              ),
              const Divider(),

              ///todo add an image for the user to upgrade his account
            ],
          ),
        ),
      ],
    );
  }
  Widget buildBodyArtist(var userData) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: (userData['imagePath'] == null)?NetworkImage('https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75'):NetworkImage(userData['imagePath']),
                    radius: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildStatColumn(20, 'artworks'),
                            (followers == null )?buildStatColumn(0, 'followers'):buildStatColumn(followers.length, 'followers'),
                            buildStatColumn(10, 'folowing'),
                          ],
                        ),
                        (userData['uid'] == FirebaseAuth.instance.currentUser.uid)?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FollowButton(Colors.blueAccent.shade100, Colors.grey,'Upgrade to premium ',Colors.white ,'upgrade',userData['uid'], () {}),
                          ],
                        ):Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (isfollowing)?FollowButton(Colors.redAccent.shade100, Colors.grey,'Unfollow',Colors.white ,'unfollow_artist',userData['uid'], () { setState(() {
                              this.isfollowing = false;
                            });}):FollowButton(Colors.blueAccent, Colors.grey,'Follow',Colors.white ,'follow_artist',userData['uid'], () {setState(() {
                              this.isfollowing = true;
                            });}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              (userData['uid'] == FirebaseAuth.instance.currentUser.uid)?Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              ):
              SizedBox(height: 5,),

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 15),
                child: (userData['name'] == null )?Text('.....', style: TextStyle(fontWeight: FontWeight.bold),):Text(userData['name'], style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  'Some Discription',

                ),
              ),
              const Divider(),
              GridView.builder(
                shrinkWrap: true,
                itemCount: _ArtworksList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 1.5,childAspectRatio: 1),
                itemBuilder: (context, index){
                  Artwork artwork = new Artwork();
                  artwork = _ArtworksList[index];
                  return buildArtworkImage(artwork);
                },

              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget buildArtworkImage(Artwork artwork){
    return Container(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GetArtworkData(artwork, true)),
          );
        },
        child: Image(
            image: NetworkImage(artwork.imagePath),
            fit: BoxFit.cover
        ),
      ),
    );
  }
  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(),style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

        Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(label,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),)),

      ],
    );
  }

  Future getArtworksList() async {
    if(userData['uid'] == null ){

    }else {
      var data = await FirebaseFirestore.instance.collection('Artworks')
          .where('creator', isEqualTo: userData['uid'])
          .get();
      _ArtworksList =
          List.from(data.docs.map((doc) => Artwork.fromSnapShot(doc)));
    }
  }

  Widget buildSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Center(
          child: Container(

            width: 100,
            child: Divider(
              color: Colors.blueAccent.shade100,
              thickness: 3,
            ),
          ),
        ),
        SizedBox(height: 5,),

        TextButton.icon(

            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: 18),
              primary: Colors.black,
              padding: EdgeInsets.all(10),
            ),
            onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateArtistPage()),
          );
        },
            icon: Icon(Icons.edit, size:25),

            label: Text('Edit Profile',),


        ),

        SizedBox(height: 5,),
        TextButton.icon(
            style: TextButton.styleFrom(
              textStyle: TextStyle(fontSize: 18),
                primary: Colors.black,
              padding: EdgeInsets.all(10),
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddArtwork()),
              );
            },
            icon: Icon(Icons.add_photo_alternate, size:25),
            label: Text('Add Artwork'),

        ),
        SizedBox(height: 5,),
        TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 18),
            primary: Colors.black,
            padding: EdgeInsets.all(10),
          ),
          onPressed: (){
            context.read<AuthenticationService>().signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
          icon: Icon(Icons.logout, size:25),
          label: Text('Log Out'),

        ),
      ],
    );
  }


/*
    GetListData() async {
      //if(userData['artworks'] =! null ){
        var userSnap = await FirebaseFirestore.instance.collection('Artists').doc( widget.uid).get();
        list = (userSnap.data() as dynamic )['artworks'] ;
        var artSnap = await FirebaseFirestore.instance.collection('Artworks').get();
        art_list = List.from(artSnap.docs.map((doc) => Artwork.fromSnapShot(doc)));
        for(int i=0;i<art_list.length;i++){
          Artwork art = new Artwork();
          art = art_list[i] as Artwork;
          if (list.contains(art.Name)){
            _ArtworksList.add(art);

          }
        }
      //}
    }*/

}
