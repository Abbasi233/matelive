import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/view/utils/progressIndicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/constant.dart';
import '../utils/miniCard.dart';
import '/view/utils/primaryButton.dart';
import '/view/LandingPage/controller.dart';
import '/view/utils/notifications_card.dart';
import 'OnlineUsersPage/online_users_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _landingPageController = Get.find<LandingPageController>();

  final _refreshController = RefreshController(initialRefresh: false);

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
              Text("Merhaba, ${Login().user.name}", style: styleH1()),
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
                              Text("Görüşmeye Başlayın!",
                                  style: styleH3(fontWeight: FontWeight.w600)),
                              Text.rich(
                                TextSpan(
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
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: primaryButton(
                                  text: Text(
                                    "Online Kullanıcıları Göster",
                                    style: styleH4(
                                        fontSize: 18,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    // Get.to(()=> AgoraCall());
                                    // Get.to(()=> OnlineUsers());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnlineUsersPage()));
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
                            AutoSizeText(
                              "Çevrimiçi olan kullanıcılar bulunuyor...",
                              style: styleH5(
                                color: kBlackColor,
                                fontWeight: FontWeight.w500,
                              ),
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
              // TODO METRİKLER
              Row(
                children: [
                  miniCard("BAŞARILI GÖRÜŞME\nSAYISI", "0", kPrimaryColor),
                  fixedWidth,
                  miniCard("CEVAPSIZ ARAMA\nSAYISI", "0", Colors.lightGreen),
                ],
              ),
              fixedHeight,
              Row(
                children: [
                  miniCard(
                      "TOPLAM KONUŞMA\nSÜRESİ", "0 Dk", Colors.yellow[700]),
                  fixedWidth,
                  miniCard("KALAN ARAMA\nKREDİSİ", "5 Dk", Colors.blue[900]),
                ],
              ),
              fixedHeight,
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: kTextColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(kBorderRadius)),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "GEÇMİŞ GÖRÜŞMELERİNİZ",
                            style: styleH6(fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              _landingPageController.changeTab(1);
                            },
                            child: Text(
                              "Tümünü Gör",
                              style: customFont(
                                18,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      // TODO GEÇMİŞ GÖRÜŞMELER
                      Text(
                        "Geçmiş görüşmeniz bulunmamaktadır.",
                        style: styleH5(),
                      ),
                    ],
                  ),
                ),
              ),
              fixedHeight,
              NotificationsCard(
                showThree: true,
                showSeeAll: true,
                showDeleteAll: true,
              ),
              fixedHeight,
              Center(
                  child: Text(
                      "${DateTime.now().year} © Matelive Tüm Hakları Saklıdır.")),
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
