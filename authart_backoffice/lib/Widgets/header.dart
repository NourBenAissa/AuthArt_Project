// @dart=2.9

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  //const Header({Key? key}) : super(key: key);
  String title;

  Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.headline6),
        Spacer(),
        Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: Colors.white
            , borderRadius : BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Image.asset("assets/images/logo.png"
                , height: 38,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text("Semer Belghith"),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ],
    );
  }
}
