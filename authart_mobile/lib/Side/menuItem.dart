import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({Key key, this.icon, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16),
    child: Row(
      children:<Widget> [
        Icon(
          icon, color: Colors.black,
          size: 30,
        ),
        SizedBox(width: 20,),
        Text(title, style: TextStyle(
          fontWeight: FontWeight.w800, fontSize: 26, color: Colors.black
        ),)
      ],
    ),
    );
  }
}
