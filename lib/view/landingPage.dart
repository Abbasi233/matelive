import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/KrediAl/krediAl.dart';

import '/constant.dart';
import 'utils/appBar.dart';
import 'HomePage/homePage.dart';
import '/view/CallsPage/calls_page.dart';
import '/view/ProfilePage/profile_page.dart';
import '/view/NotificationsPage/notifications_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: MyAppBar(
          elevation: 2,
          centerTitle: true,
        ),
        body: TabBarView(
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
            indicatorWeight: 4,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor,
            ),
            labelColor: kYellowColor,
            unselectedLabelColor: Colors.white,
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
      // ),
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
