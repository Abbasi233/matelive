import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget showImage(String imageUrl) {
  return FittedBox(
    child: Padding(
      padding: EdgeInsets.all(Get.width * 0.06),
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
      ),
    ),
  );
}
