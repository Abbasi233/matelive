import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFff0b3d);
const kTextColor = Color(0xFF5d5d5d);
const kTextColorSoft = Color(0xFF8d8d8d);
const kTabBarColor = Color(0xFF1d1d1d);
const kYellowColor = Color(0xFFffd54f);
const kOrangeColor = Color(0xFFe74c0c);
const kBlackColor = Colors.black;

/// fontSize: 36, fontWeight: FontWeight.w600
TextStyle styleH1(
        {double fontSize = 34,
        FontWeight fontWeight = FontWeight.w600,
        Color color = kBlackColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

/// fontSize: 28, fontWeight: FontWeight.w500
TextStyle styleH2(
        {double fontSize = 28,
        FontWeight fontWeight = FontWeight.w500,
        Color color = kBlackColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

/// fontSize: 24, fontWeight: FontWeight.w500
TextStyle styleH3(
        {double fontSize = 24,
        FontWeight fontWeight = FontWeight.w500,
        Color color = kBlackColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

/// fontSize: 20, fontWeight: FontWeight.w400, color: kTextColor
TextStyle styleH4(
        {double fontSize = 20,
        FontWeight fontWeight = FontWeight.w400,
        Color color = kTextColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

/// fontSize: 16, fontWeight: FontWeight.w400, color: kTextColor
TextStyle styleH5(
        {double fontSize = 16,
        FontWeight fontWeight = FontWeight.w400,
        Color color = kTextColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

/// fontSize: 14, fontWeight: FontWeight.w400, color: kTextColor
TextStyle styleH6(
        {double fontSize = 14,
        FontWeight fontWeight = FontWeight.w400,
        Color color = kTextColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

TextStyle customFont(double fontSize,
        {FontWeight fontWeight = FontWeight.w500, Color color = kTextColor}) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);

const kBorderRadius = 15.0;
const kTextInputBorderRadius = 40.0;
