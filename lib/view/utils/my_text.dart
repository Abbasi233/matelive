import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;

  MyText(
    this.title, {
    this.fontSize = 16,
    this.color = const Color(0xff282828),
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
