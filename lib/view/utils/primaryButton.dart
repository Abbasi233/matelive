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
  Color borderColor = kPrimaryColor,
  Widget imageIcon,
  bool disabled = false,
}) =>
    Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageIcon == null
              ? [Expanded(child: text)]
              : [text, SizedBox(width: 5), imageIcon],
        ),
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          backgroundColor: MaterialStateProperty.all(
              disabled ? kTextColor : backgroundColor),
          textStyle: MaterialStateProperty.all(styleH4()),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: disabled ? kTextColor : borderColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
