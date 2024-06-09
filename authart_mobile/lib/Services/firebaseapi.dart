import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../model/message.dart';
import '../model/messageuser.dart';
import '../utils.dart';

class FirebaseApi {
  static Stream<List<UserMes>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(UserMes.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chats/$idUser/messages');
    var currentUser = FirebaseAuth.instance.currentUser;
    final newMessage = Message(
      idUser: currentUser.uid,
      urlAvatar: currentUser.photoURL,
      username: currentUser.displayName,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));


}