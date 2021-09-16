import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import 'utils/packageCard.dart';
import '/view/utils/footer.dart';

class KrediAlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kredi Al", style: styleH1()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Sizin için en uygun planı seçerek ilerleyin!",
                      style: styleH3(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // children: [10, 30, 60]
              //     .map<Widget>((e) => packageCard(
              //           title: "$e DAKİKA",
              //           price: 10,
              //           packageName: "Başlangıç Paketi",
              //           mostPopuler: e == 30 ? true : false,
              //         ))
              //     .toList(),
              children: [
                packageCard(
                  title: "10 DAKİKA",
                  price: 10,
                  packageName: "Başlangıç Paketi",
                ),
                packageCard(
                  title: "30 DAKİKA",
                  price: 25,
                  packageName: "Yeni Gelen Paketi",
                ),
                packageCard(
                  title: "60 DAKİKA",
                  price: 45,
                  packageName: "Avantaj Paketi",
                  mostPopuler: true,
                ),
                packageCard(
                  title: "100 DAKİKA",
                  price: 80,
                  packageName: "Süper Paketi",
                ),
                packageCard(
                  title: "200 DAKİKA",
                  price: 150,
                  packageName: "Lüks Paketi",
                ),
              ],
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}
