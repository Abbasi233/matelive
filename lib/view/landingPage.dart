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
          elevation: 0,
          centerTitle: true,
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(kToolbarHeight),
          //   child: Container(
          //     color: kTabBarColor,
          //     child: TabBar(
          //       isScrollable: true,
          //       indicatorWeight: 4,
          //       indicator: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: kPrimaryColor,
          //       ),
          //       indicatorSize: TabBarIndicatorSize.label,
          //       indicatorPadding: EdgeInsets.only(top: 40, bottom: 5),
          //       tabs: [
          //         _tab("ANA SAYFA", textColor: kPrimaryColor),
          //         _tab("KREDİ AL", textColor: kYellowColor),
          //         _tab("PROFİL BİLGİLERİ"),
          //         _tab("GÖRÜŞMELER"),
          //         _tab("BİLDİRİMLER"),
          //         _tab("ÇIKIŞ YAP"),
          //       ],
          //     ),
          //   ),
          // ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            CallsPage(),
            NotificationsPage(),
            KrediAlPage(),
            ProfilePage(),
            // Container(),
          ],
        ),
        bottomNavigationBar: Container(
          color: kTabBarColor,
          child: TabBar(
            // isScrollable: true,
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
              // _tab("ANA SAYFA", textColor: kPrimaryColor),
              // _tab("KREDİ AL", textColor: kYellowColor),
              // _tab("PROFİL BİLGİLERİ"),
              // _tab("GÖRÜŞMELER"),
              // _tab("BİLDİRİMLER"),
              // _tab("ÇIKIŞ YAP"),
              _tab(Icons.home_rounded, textColor: kPrimaryColor),
              _tab(Icons.call_rounded),
              _tab(Icons.notifications_active_rounded),
              _tab(Icons.attach_money_rounded, textColor: kYellowColor),
              _tab(Icons.account_circle_rounded),
              // _tab(Icons.exit),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Tab _tab(IconData icon, {Color textColor = Colors.white}) => Tab(
        child: Container(
            child:
                // icon != Icons.person ?
                Icon(icon)
            // : CircleAvatar(backgroundImage: ,),
            // TODO Kullanıcı Profil Fotoğrafı Eklenecek
            ),
      );
}
