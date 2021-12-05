import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

import '/constant.dart';
import 'controller.dart';
import '/model/login.dart';
import '/view/utils/drawer.dart';
import '/view/utils/appBar.dart';
import '/model/profile_detail.dart';
import '/view/HomePage/home_page.dart';
import '/view/CallsPage/calls_page.dart';
import '/view/CreditsPage/credits_page.dart';
import '/view/ProfilePage/profile_page.dart';
import '/controller/getX/Agora/calling_controller.dart';
import '/view/NotificationsPage/notifications_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  var _callingController = Get.put(CallingController());
  var _landingPageController = Get.put(LandingPageController());

  PusherClient pusher;
  TabController _tabController;
  var profileInitialized = ProfileDetail().id.obs;

  @override
  void initState() {
    super.initState();
    initPusher();
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

  void initPusher() {
    PusherOptions options = PusherOptions(
      wsPort: 6001,
      cluster: "eu",
      encrypted: true,
      auth: PusherAuth("https://matelive.net/api/broadcasting/auth", headers: {
        'Authorization': 'Bearer ${Login().token}',
        'Content-Type': 'application/json',
      }),
    );
    pusher = PusherClient("4247212f2d5fe9f991e6", options, autoConnect: true);

    pusher.onConnectionStateChange((state) {
      log("previousState: ${state.previousState}, currentState: ${state.currentState}");
    });

    pusher.onConnectionError((error) {
      log("error: ${error.exception}");
    });
    pusher.connect();

    pusher.subscribe("private-user.call.${ProfileDetail().id}").bind(
      "App\\Events\\callUser",
      (PusherEvent event) {
        var data = jsonDecode(event.data);
        switch (data["type"]) {
          case "calling":
            _callingController.callingByRequestStatus(data);
            break;
          case "action":
            _callingController.actionByRequestStatus(
                data["webCallDetails"]["status"].toString(), data["actionerDetails"]);
            break;
        }
      },
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
