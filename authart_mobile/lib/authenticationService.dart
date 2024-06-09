
import 'dart:ffi';

import 'package:another_project/model/artwork.dart';
import 'package:another_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg:" logged in successfully", gravity: ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.BOTTOM);
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<void> signUp({String email, String password, String name, String familyName}) {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        FirebaseFirestore.instance.collection('Users').doc(value.user.uid).set({"email": email,"name":name,"familyName":familyName,"imagePath":"https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75"});
      });

      Fluttertoast.showToast(msg:" Registered successfully", gravity: ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.BOTTOM);
    }
  }
  Future<void> signUpArtist({String email, String password, String name, String familyName, String diplome, String speciality}) {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        FirebaseFirestore.instance.collection('Artists').doc(value.user.uid).set({"uid":value.user.uid,"name":name,"familyName":familyName,"email": email, "diplome": diplome, "speciality": speciality,"favorits" :[],"imagePath":"https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75"});
      });

      Fluttertoast.showToast(msg:" Registered successfully", gravity: ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.BOTTOM);
    }
  }

  /// updade artist
  Future<void> UpdateArtist({ String name, String familyName, String diplome, String speciality}) {

    FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).update({"name":name,"familyName":familyName, "diplome": diplome, "speciality": speciality});
    Fluttertoast.showToast(msg:" Account updated", gravity: ToastGravity.BOTTOM);
  }


  /// updade artist Profile
  Future<void> UpgradeArtist({ String name, String familyName, String diplome, String speciality}) {

    FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).update({"name":name,"familyName":familyName, "diplome": diplome, "speciality": speciality});
    Fluttertoast.showToast(msg:" Account upgraded", gravity: ToastGravity.BOTTOM);
  }

  /// update artwork
  Future<void> UpdateArtwork({Artwork art, String name, String desc}) {
    FirebaseFirestore.instance.collection('Artworks').doc(art.Name).delete();
    FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).update(
        {'artworks': FieldValue.arrayRemove([art.Name])});
    art.Name=name;
    art.desc=desc;
    FirebaseFirestore.instance.collection('Artworks').doc(art.Name).set({"name":name,"width":art.width,"height": art.height, "depth": art.depth,"weight": art.weight, "date": art.date,"state":art.state,"type":art.type,"desc":desc,"imagePath":art.imagePath,"creator":art.creator});
    FirebaseFirestore.instance.collection('Artists').doc(FirebaseAuth.instance.currentUser.uid).update(
        {'artworks': FieldValue.arrayUnion([art.Name])});

    Fluttertoast.showToast(msg:" Artwork Updated", gravity: ToastGravity.BOTTOM);
  }


  /// Adding an artwork to the data base
  Future<void> AddArtwork({String uuid,int version,String name, String width, String height, String depth, String weight, String date, String state, String type, String desc,String creator})async{
    FirebaseFirestore.instance.collection('Artworks').doc(name).set({"uuid":uuid,"version":version,"name":name,"width":width,"height": height, "depth": depth,"weight": weight, "date": date,"state":state,"type":type,"desc":desc,"imagePath":"https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/testest.jpg?alt=media&token=2d5ad90e-aff0-4e07-bd44-801a75a127cf","creator":creator});
    // adding the artwork name to his creator artwork_list
    FirebaseFirestore.instance.collection('Artists').doc(currentUser.uid).update({'artworks' : FieldValue.arrayUnion([name])});
    Fluttertoast.showToast(msg:" New artwork demand added successfully ", gravity: ToastGravity.BOTTOM);
  }





  ///Google Sign Method
  Future<UserCredential> googleLogin() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential);
  }



  ///Reading User Data
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  Stream<QuerySnapshot> get users{
    return userCollection.snapshots();
  }
/*
  Future<NormalUser> getCurrentUserData() async {
    try{
      DocumentSnapshot ds = await userCollection.doc(currentUser.uid).get();
      NormalUser NUser = NormalUser('bla la la', ds.get('name'), ds.get('familyName'), ds.get('email'));
      /*
      String firstName = ds.get('name');
      String lastName = ds.get('familyName');
      String user_email = ds.get('email');
       */
      return  NUser;
    }catch(e){
      print(e.toString());
      return null;
    }
  }*/
  ///contact artist

  Future<void> Contact(String name, String time ,bool unread ,String sender, NormalUser user  ) {

        FirebaseFirestore.instance.collection('Messages').doc(currentUser.uid).set({"text":"hello, i am intrested in the"+name+" artwork","time":time,"unread":false,"sender":currentUser.uid});


  }

}