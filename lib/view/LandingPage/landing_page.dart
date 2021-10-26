import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/CreditsPage/credits_page.dart';
import 'package:matelive/view/utils/drawer.dart';

import 'controller.dart';
import '/constant.dart';
import '../utils/appBar.dart';
import '../HomePage/home_page.dart';
import '/view/CallsPage/calls_page.dart';
import '/view/ProfilePage/profile_page.dart';
import '/view/NotificationsPage/notifications_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _landingPageController = Get.put(LandingPageController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _landingPageController.initTabController(_tabController);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _landingPageController.scaffoldKey,
        appBar: MyAppBar(
          elevation: 2,
          centerTitle: true,
        ),
        drawer: MyDrawer.build(),
        body: TabBarView(
          controller: _landingPageController.tabController,
          children: [
            HomePage(),
            CallsPage(),
            NotificationsPage(),
            CreditsPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: kTabBarColor,
          child: TabBar(
            controller: _landingPageController.tabController,
            indicatorWeight: 4,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor,
            ),
            labelColor: kYellowColor,
            unselectedLabelColor: kWhiteColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(top: 40, bottom: 5),
            tabs: [
              _tab(Icons.home_rounded),
              _tab(Icons.call_rounded),
              _tab(Icons.notifications_active_rounded),
              _tab(Icons.attach_money_rounded),
              _tab(Icons.account_circle_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Tab _tab(IconData icon) => Tab(
        child: Container(
            child:
                // icon != Icons.person ?
                Icon(icon)
            // : CircleAvatar(backgroundImage: ,),
            // TODO Kullanıcı Profil Fotoğrafı Eklenecek
            ),
      );
}
