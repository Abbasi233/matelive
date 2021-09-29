import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import '../utils/miniCard.dart';
import '/view/utils/notifications_card.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fixedHeight,
              Text("Bildirimler", style: styleH1()),
              fixedHeight,
              Row(
                children: [
                  miniCard("SİSTEM\n BİLDİRİMLERİ", "0", Colors.yellow[700]),
                  fixedWidth,
                  miniCard("BEĞENİ\nBİLDİRİMLERİ", "0", Colors.yellow[700]),
                ],
              ),
              fixedHeight,
              Row(
                children: [
                  miniCard("DÜRTME\nBİLDİRİMLERİ", "0", Colors.yellow[700]),
                  fixedWidth,
                  miniCard("FAVORİ\nBİLDİRİMLERİ", "0", Colors.yellow[700]),
                ],
              ),
              fixedHeight,
              NotificationsCard(),
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
}
