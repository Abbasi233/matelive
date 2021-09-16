import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constant.dart';

class MyAppBar extends AppBar {
  MyAppBar({bool centerTitle = false, double elevation = 4, PreferredSizeWidget bottom})
      : super(
          backgroundColor: Colors.white,
          centerTitle: centerTitle,
          title: Image.asset(
            "assets/images/logo.png",
            width: Get.width * 0.4,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
              color: kBlackColor,
            )
          ],
          elevation: elevation,
          bottom: bottom
        );
}
