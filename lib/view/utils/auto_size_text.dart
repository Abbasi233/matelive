import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

Widget autoSize({
  String text,
  TextSpan textSpan,
  TextStyle style,
  double padding = 0.2,
  int maxLines = 1,
}) {
  return Padding(
    padding: EdgeInsets.only(right: Get.width * padding),
    child: text != null
        ? AutoSizeText(
            text,
            style: style,
            maxLines: maxLines,
          )
        : AutoSizeText.rich(
            textSpan,
            style: style,
            maxLines: maxLines,
          ),
  );
}
