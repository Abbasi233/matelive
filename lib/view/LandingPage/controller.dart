import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum ConStates {
  DISCONNECTED,
  CONNECTING,
  CONNECTED,
}

class LandingPageController extends GetxController {
  TabController tabController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  RxString appVersion = "".obs;
  RxString appBuildNumber = "".obs;

  var pusherConStates = ConStates.DISCONNECTED.obs;

  @override
  void onInit() {
    PackageInfo.fromPlatform().then((packageInfo) {
      appVersion.value = packageInfo.version;
      appBuildNumber.value = packageInfo.buildNumber;
    });

    super.onInit();
  }

  Widget get getPusherConState {
    Widget child;
    switch (pusherConStates.value) {
      case ConStates.DISCONNECTED:
        child = Icon(Icons.swap_vertical_circle_rounded, color: Colors.red);
        break;
      case ConStates.CONNECTING:
        child =
            Icon(Icons.swap_vertical_circle_rounded, color: Colors.yellow[700]);
        break;
      case ConStates.CONNECTED:
        child = Icon(Icons.swap_vertical_circle_rounded,
            color: Colors.lightGreen[700]);
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: child,
    );
  }

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
