import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ScreenOff extends StatelessWidget {
  const ScreenOff({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        height: Get.height,
        width: Get.width,
      ),
    );
  }
}
