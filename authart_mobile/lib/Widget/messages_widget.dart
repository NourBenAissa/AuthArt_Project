
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/firebaseapi.dart';
import '../model/message.dart';
import 'message_widget.dart';



class MessagesWidget extends StatelessWidget {
  final String idUser;

  const MessagesWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
    stream: FirebaseApi.getMessages(idUser),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());
        default:
          if (snapshot.hasError) {
            return buildText('Something Went Wrong Try later');
          } else {
            final messages = snapshot.data;

            return messages.isEmpty
                ? buildText('Send message..')
                : ListView.builder(
              physics: BouncingScrollPhysics(),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                var currentUser = FirebaseAuth.instance.currentUser;
                return MessageWidget(
                  message: message,
                  isMe: message.idUser == currentUser.uid,
                );
              },
            );
          }
      }
    },
  );

  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
  );
}