import 'package:another_project/Widget/profile_header_widget.dart';


import 'package:flutter/material.dart';

import '../model/artist.dart';
import 'messages_widget.dart';
import 'new_message_widget.dart';

class ChatPage extends StatefulWidget {
  final Artist user;

  const ChatPage({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.blue,
    body: SafeArea(
      child: Column(
        children: [
          ProfileHeaderWidget(name: widget.user.Name),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: MessagesWidget(idUser: widget.user.uid),
            ),
          ),
          NewMessageWidget(idUser: widget.user.uid)
        ],
      ),
    ),
  );
}