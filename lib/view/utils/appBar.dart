import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import '/view/LandingPage/controller.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    Widget child,
    bool centerTitle = false,
    double elevation = 4,
    PreferredSizeWidget bottom,
    Widget leading,
  }) : super(
          backgroundColor: kWhiteColor,
          centerTitle: centerTitle,
          title: child ??
              Image.asset(
                "assets/images/logo.png",
                width: Get.width * 0.4,
              ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       Get.find<LandingPageController>().openDrawer();
          //     },
          //     icon: Icon(Icons.menu),
          //   )
          // ],
          elevation: elevation,
          bottom: bottom,
          leading: leading,
        );
}
