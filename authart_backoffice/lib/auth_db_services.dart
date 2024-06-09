// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthDBServices{
  FirebaseAuth _firebaseAuth;

  AuthDBServices(this._firebaseAuth);

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
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> registerModerator({String email, String password, String name, String familyName}) {

      _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        FirebaseFirestore.instance.collection('Moderators').doc(value.user.uid).set({"role":"mod","email": email,"name":name,"familyName":familyName,"imagePath":"https://firebasestorage.googleapis.com/v0/b/testproject-24792.appspot.com/o/LkklZtymwMZeqi3yFrjpeYYRWt32.jpg?alt=media&token=33e21dd0-6951-4b16-a5c9-c26b0c83cb75"});
      });

  }
}
