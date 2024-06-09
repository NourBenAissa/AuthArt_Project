import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    this.text,
    this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
        ),
        onPressed: onClicked,
        child: Text(text)
    );
  }
}
