import 'package:flutter/material.dart';

import '/constant.dart';

Widget primaryButton({@required Widget child, @required Function onPressed}) =>
    Container(
      height: 50,
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          ),
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          textStyle: MaterialStateProperty.all(styleH4()),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kTextInputBorderRadius),
            ),
          ),
        ),
      ),
    );
