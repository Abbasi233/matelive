import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LandingPageController extends GetxController {
  TabController tabController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void initTabController(TabController _tabController) {
    tabController = _tabController;
  }

  void changeTab(int index) {
    tabController.index = index;
  }
}
