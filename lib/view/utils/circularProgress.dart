import 'package:flutter/material.dart';
import 'package:matelive/constant.dart';

class MyCircularProgress extends Center {
  MyCircularProgress()
      : super(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: kPrimaryColor,
          ),
        );
}
