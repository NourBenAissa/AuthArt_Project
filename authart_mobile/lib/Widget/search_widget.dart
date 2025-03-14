import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hinttext;

  const SearchWidget({
    Key key,
    this.text,
    this.onChanged,
    this.hinttext
  }) : super(key: key);


  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black38);
    final style = widget.text.isEmpty ? styleHint: styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          //IconButton(icon: Icons.search, color: style.color),
          icon :IconButton(
            icon: Icon(Icons.search),
            iconSize: 60,
            onPressed: () {

            },
          ),
          /*suffixIcon: widget.text.isNotEmpty? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              //FocusScope.of(context).requestFocus(Focus)
            },
          )
              : null,*/
          hintText: widget.hinttext,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
