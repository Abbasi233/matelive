import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/getX/chat_controller.dart';

import '/constant.dart';
import 'controller.dart';
import '/model/login.dart';
import '/view/utils/drawer.dart';
import '/view/utils/appBar.dart';
import '/model/profile_detail.dart';
import '/view/HomePage/home_page.dart';
import '/view/CallsPage/calls_page.dart';
import '/view/chats_page/rooms_page.dart';
import '/view/CreditsPage/credits_page.dart';
import '/view/ProfilePage/profile_page.dart';
import '/controller/getX/pusher_controller.dart';
import '/controller/getX/Agora/calling_controller.dart';
import '/view/NotificationsPage/notifications_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  var _landingPageController = Get.put(LandingPageController());

  TabController _tabController;
  var profileInitialized = ProfileDetail().id.obs;

  @override
  void initState() {
    super.initState();
    // initPusher();
    Get.put(ChatController());
    // Get.lazyPut(() => ChatController());
    Get.lazyPut(() => CallingController());

    var pusherController = Get.put(PusherController(Login().token));
    pusherController.listenCall(Login().user.id);
    pusherController.listenChat(Login().user.id);

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
          action: [
            Obx(() => _landingPageController.getPusherConState),
            IconButton(
              onPressed: () {
                Get.to(
                  () => RoomsPage(),
                  transition: Transition.cupertino,
                );
              },
              icon: Icon(
                Icons.message_rounded,
                color: Colors.grey[800],
              ),
            )
          ],
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
              _tab(Icons.notifications_active),
              _tab(Icons.attach_money_rounded),
              _tab(Icons.account_circle_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Tab _tab(IconData icon) => Tab(
        child: Container(child: Icon(icon)),
      );
}
