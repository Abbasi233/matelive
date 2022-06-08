import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    Widget child,
    bool centerTitle = false,
    double elevation = 4,
    PreferredSizeWidget bottom,
    Widget leading,
    List<Widget> action,
  }) : super(
          backgroundColor: kWhiteColor,
          centerTitle: centerTitle,
          title: child ??
              Image.asset(
                "assets/images/logo.png",
                width: Get.width * 0.4,
              ),
          // actions: [action != null ? action : Container()],
          actions: action,
          elevation: elevation,
          bottom: bottom,
          leading: leading,
        );
}
