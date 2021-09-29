import 'package:flutter/material.dart';

import '/constant.dart';

Widget primaryButton({
  @required Widget text,
  @required Function onPressed,
  double width,
  double height = 50,
  double padding = 0,
  double borderRadius = kTextInputBorderRadius,
  Color backgroundColor = kPrimaryColor,
  ImageIcon imageIcon,
}) =>
    Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageIcon == null
              ? [text]
              : [text, SizedBox(width: 5), imageIcon],
        ),
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          textStyle: MaterialStateProperty.all(styleH4()),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
