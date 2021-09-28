import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/Agora/test.dart';

import '/constant.dart';
import 'utils/comment.dart';
import '/view/utils/card.dart';
import '/view/utils/fixedSpace.dart';
import '/view/utils/primaryButton.dart';
import '/view/utils/notifications_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            // TODO ${user.kullaniciAdi}
            fixedHeight,
            Text("Merhaba, Mobil!", style: styleH1()),
            fixedHeight,
            Card(
              color: kYellowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: Container(
                height: 250,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
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
                          // TODO ONLINE KİŞİ SAYISI
                          TextSpan(
                            text: "0",
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
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Get.to(()=> AgoraCall());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fixedHeight,
            // TODO METRİKLER
            Row(
              children: [
                gorusmeCard("BAŞARILI GÖRÜŞME\nSAYISI", "0", kPrimaryColor),
                fixedWidth,
                gorusmeCard("CEVAPSIZ ARAMA\nSAYISI", "0", Colors.lightGreen),
              ],
            ),
            fixedHeight,
            Row(
              children: [
                gorusmeCard(
                    "TOPLAM KONUŞMA\nSÜRESİ", "0 Dk", Colors.yellow[700]),
                fixedWidth,
                gorusmeCard("KALAN ARAMA\nKREDİSİ", "5 Dk", Colors.blue[900]),
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
                          onPressed: () {},
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
            NotificationsCard(showSeeAll: true, showDeleteAll: true),
            fixedHeight,
            Center(
                child: Text(
                    "${DateTime.now().year} © Matelive Tüm Hakları Saklıdır.")),
            fixedHeight,
          ],
        ),
      ),
    );
  }
}
