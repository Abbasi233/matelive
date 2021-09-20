import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;

  MyText(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xff282828),
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }
}
