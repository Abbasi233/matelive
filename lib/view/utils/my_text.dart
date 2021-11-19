import 'package:flutter/material.dart';

class MyText extends Text {
  final String title;
  final double fontSize;
  final TextOverflow overflow;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;

  MyText(
    this.title, {
    this.fontSize = 16,
    this.overflow,
    this.color = const Color(0xff282828),
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = 0.5,
  }) : super(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
          ),
          overflow: overflow,
        );
}
