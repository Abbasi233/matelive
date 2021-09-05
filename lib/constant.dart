import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFff0b3d);
const kTextColor = Color(0xFF5d5d5d);

/// fontSize: 36, fontWeight: FontWeight.w600
const styleH1 = TextStyle(fontSize: 36, fontWeight: FontWeight.w600);

/// fontSize: 28, fontWeight: FontWeight.w500
const styleH2 = TextStyle(fontSize: 28, fontWeight: FontWeight.w500);

/// fontSize: 24, fontWeight: FontWeight.w500
const styleH3 = TextStyle(fontSize: 24, fontWeight: FontWeight.w500);

/// fontSize: 20, fontWeight: FontWeight.w400, color: kTextColor
const styleH4 =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: kTextColor);

/// fontSize: 16, fontWeight: FontWeight.w400, color: kTextColor
const styleH5 =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: kTextColor);

/// fontSize: 14, fontWeight: FontWeight.w400, color: kTextColor
const styleH6 =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kTextColor);

TextStyle customFont(double size,
        {FontWeight weight = FontWeight.w500, Color color = kTextColor}) =>
    TextStyle(fontSize: size, fontWeight: weight, color: color);

const kBorderRadius = 40.0;
