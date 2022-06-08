import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/getX/Agora/calling_controller.dart';
import 'package:matelive/view/utils/auto_size_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/model/infographic.dart';
import '/view/utils/miniCard.dart';
import '/model/paged_response.dart';
import '/view/utils/primaryButton.dart';
import '/view/LandingPage/controller.dart';
import '/view/utils/progressIndicator.dart';
import '/view/utils/notifications_card.dart';
import 'OnlineUsersPage/online_users_page.dart';
import '/controller/getX/calls_controller.dart';
import '/view/CallsPage/utils/expansion_panel.dart';
import '/controller/getX/notifications_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _refreshController = RefreshController(initialRefresh: false);

  final _callsController = Get.find<CallsController>();
  final _callingController = Get.find<CallingController>();
  final _landingPageController = Get.find<LandingPageController>();
  final _notificationsController = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    log("Token: " + Login().token);
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          controller: _refreshController,
          header: MaterialClassicHeader(),
          physics: BouncingScrollPhysics(),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              fixedHeight,
              autoSize(
                text: "Merhaba, ${Login().user.name}",
                style: styleH1(),
              ),
              fixedHeight,
              Card(
                color: kYellowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                child: Container(
                  height: 250,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: FutureBuilder<Map<bool, dynamic>>(
                    future: API().getOnlineUsers(Login().token, "", ""),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        if (data.keys.first) {
                          var pagedResponse =
                              data.values.first as PagedResponse;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              autoSize(
                                text: "Görüşmeye Başlayın!",
                                style: styleH3(fontWeight: FontWeight.w600),
                                paddingRight: 0.05,
                              ),
                              autoSize(
                                textSpan: TextSpan(
                                  text: "Şu an ",
                                  children: [
                                    TextSpan(
                                      text:
                                          pagedResponse.data.length.toString(),
                                      style: styleH4(
                                        fontWeight: FontWeight.w600,
                                        color: kBlackColor,
                                      ),
                                    ),
                                    TextSpan(text: " kişi online.\n"),
                                    TextSpan(text: "Hemen görüşmeye başlayın!"),
                                  ],
                                ),
                                style: styleH5(
                                  fontSize: 18,
                                  color: kBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                paddingRight: 0.05,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: primaryButton(
                                  text: autoSize(
                                    text: "Online Kullanıcıları Göster",
                                    style: styleH4(
                                      fontSize: 18,
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    paddingRight: 0,
                                  ),
                                  onPressed: () {
                                    Get.to(() => OnlineUsersPage());
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {}
                      }
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            autoSize(
                              text: "Çevrimiçi olan kullanıcılar bulunuyor...",
                              style: styleH5(
                                color: kBlackColor,
                                fontWeight: FontWeight.w500,
                              ),
                              paddingRight: 0,
                            ),
                            showProgressIndicator(context),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              fixedHeight,
              FutureBuilder<Map<bool, dynamic>>(
                future: API().getInfographic(Login().token),
                builder: (context, snapshot) {
                  Infographic info;
                  if (snapshot.hasData) {
                    if (snapshot.data.keys.first) {
                      info = snapshot.data.values.first;
                      _callingController.remainingCredit = info.remainingCredit;
                    } else {
                      return Center(
                        child: Text(snapshot.data.values.first),
                      );
                    }
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          miniCard(
                            "BAŞARILI GÖRÜŞME\nSAYISI",
                            info == null
                                ? showProgressIndicator(context)
                                : autoSize(
                                    text: info.successfullCallCount.toString(),
                                    style: styleH3(
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor,
                                    ),
                                    paddingRight: 0,
                                  ),
                            Colors.lightGreen,
                          ),
                          fixedWidth,
                          miniCard(
                            "CEVAPSIZ ARAMA\nSAYISI",
                            info == null
                                ? showProgressIndicator(context)
                                : autoSize(
                                    text: info.failedCallCount.toString(),
                                    style: styleH3(
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor,
                                    ),
                                    paddingRight: 0,
                                  ),
                            kPrimaryColor,
                          ),
                        ],
                      ),
                      fixedHeight,
                      Row(
                        children: [
                          miniCard(
                            "TOPLAM KONUŞMA\nSÜRESİ",
                            info == null
                                ? showProgressIndicator(context)
                                : autoSize(
                                    text: info
                                        .succesfullCallDurationFormattedShort,
                                    style: styleH3(
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor,
                                    ),
                                    paddingRight: 0,
                                  ),
                            Colors.yellow[700],
                          ),
                          fixedWidth,
                          miniCard(
                            "KALAN\nARAMA\nKREDİSİ",
                            info == null
                                ? showProgressIndicator(context)
                                : autoSize(
                                    text: info.remainingCreditFormattedSort,
                                    style: styleH3(
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor,
                                    ),
                                    paddingRight: 0,
                                  ),
                            Colors.blue[900],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              fixedHeight,
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: kTextColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(kBorderRadius)),
                child: FutureBuilder<Map<bool, dynamic>>(
                  future: API().getCalls(Login().token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.keys.first) {
                        _callsController.pagedResponse.value =
                            snapshot.data.values.first;

                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: autoSize(
                                      text: "GEÇMİŞ GÖRÜŞMELERİNİZ",
                                      style: TextStyle(fontSize: 7),
                                      //     styleH6(fontWeight: FontWeight.w600),
                                      paddingRight: 0,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _landingPageController.changeTab(1);
                                    },
                                    child: autoSize(
                                      text: "Tümünü Gör",
                                      style: customFont(
                                        18,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      paddingRight: 0,
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              CallsExpansionPanel(showThree: true)
                            ],
                          ),
                        );
                      }
                    }
                    return showProgressIndicator(context);
                  },
                ),
              ),
              fixedHeight,
              FutureBuilder<Map<bool, dynamic>>(
                  future: API().getNotificationsByType(Login().token, "all"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.keys.first) {
                        _notificationsController.pagedResponse.value =
                            snapshot.data.values.first;

                        return NotificationsCard(
                          showThree: true,
                          showSeeAll: true,
                          showDeleteAll: true,
                        );
                      }
                    }
                    return showProgressIndicator(context);
                  }),
              fixedHeight,
              Center(
                child: Text(
                    "${DateTime.now().year} © Matelive Tüm Hakları Saklıdır."),
              ),
              fixedHeight,
            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    setState(() {
      Future.delayed(Duration(milliseconds: 500));
    });
    _refreshController.refreshCompleted();
  }
}
