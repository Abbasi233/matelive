import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/view/HomePage/utils/card.dart';
import 'package:matelive/view/HomePage/utils/fixedSpace.dart';
import 'package:matelive/view/utils/primaryButton.dart';

import 'utils/comment.dart';

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
                        child: Text(
                          "Online Kullanıcıları Göster",
                          style: styleH4(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {},
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
                card("BAŞARILI GÖRÜŞME\nSAYISI", "0", kPrimaryColor),
                fixedWidth,
                card("CEVAPSIZ ARAMA\nSAYISI", "0", Colors.lightGreen),
              ],
            ),
            fixedHeight,
            Row(
              children: [
                card("TOPLAM KONUŞMA\nSÜRESİ", "0 Dk", Colors.yellow[700]),
                fixedWidth,
                card("KALAN ARAMA\nKREDİSİ", "5 Dk", Colors.blue[900]),
              ],
            ),
            fixedHeight,
            Card(
              shape: RoundedRectangleBorder(
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
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius)),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "BİLDİRİMLER",
                            style: styleH5(fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Tümünü Gör",
                              style: customFont(
                                16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Tümünü Sil",
                              style: customFont(
                                16,
                                color: kOrangeColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    // TODO GEÇMİŞ GÖRÜŞMELER
                    // Expanded(
                    //   child:
                    Column(
                      children: [0, 0, 0]
                          .map(
                            (i) => comment(
                              description:
                                  "Matelive'a hoşgeldiniz! Profil bilgilerinizi güncellemek için buraya tıklayabilirsiniz.",
                              dateTime: DateTime.now(),
                            ),
                          )
                          .toList(),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
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
