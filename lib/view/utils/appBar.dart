import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';

class MyAppBar extends AppBar {
  MyAppBar(
      {bool centerTitle = false,
      double elevation = 4,
      PreferredSizeWidget bottom})
      : super(
            backgroundColor: Colors.white,
            centerTitle: centerTitle,
            title: Image.asset(
              "assets/images/logo.png",
              width: Get.width * 0.4,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.find<AppBarController>().openDrawer();
                },
                icon: Icon(Icons.menu),
                color: kBlackColor,
              )
            ],
            elevation: elevation,
            bottom: bottom);
}

///
/// LANDİNG PAGE GETX'E ALINIP HER YERDEN ERİŞİM KONTROLÜ SAĞLANACAK
class AppBarController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }
}
