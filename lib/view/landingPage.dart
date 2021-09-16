import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/KrediAl/krediAl.dart';

import '/constant.dart';
import 'utils/appBar.dart';
import 'HomePage/homePage.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: MyAppBar(
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: kTabBarColor,
              child: TabBar(
                isScrollable: true,
                indicatorWeight: 4,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kPrimaryColor,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(top: 40, bottom: 5),
                tabs: [
                  _tab("ANA SAYFA", textColor: kPrimaryColor),
                  _tab("KREDİ AL", textColor: kYellowColor),
                  _tab("PROFİL BİLGİLERİ"),
                  _tab("GÖRÜŞMELER"),
                  _tab("BİLDİRİMLER"),
                  _tab("ÇIKIŞ YAP"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            KrediAlPage(),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }

  Tab _tab(String title, {Color textColor = Colors.white}) => Tab(
        child: Container(
          // width: Get.width * 0.25,
          child: Text(
            title,
            style:
                customFont(18, fontWeight: FontWeight.w500, color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
