import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final String hintText;

  MyTextInput({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          style: TextStyle(
            color: Color(0xff737373),
            letterSpacing: 0.5,
          ),
          cursorColor: Color(0xffdc1b43),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xff737373),
              letterSpacing: 0.5,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffdc1b43), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
