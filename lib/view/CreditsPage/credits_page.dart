import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/in-app-purchase.dart';
import 'package:matelive/model/credit.dart';
import 'package:matelive/view/utils/snackbar.dart';

import '/constant.dart';
import 'utils/packageCard.dart';
import '/view/utils/footer.dart';

class CreditsPage extends StatefulWidget {
  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  List<Credit> products = [];
  var iapController = Get.find<IAPController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          iapController.loadPurchases();
          failureSnackbar(iapController.products.length.toString());
        },
      ),
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
              children: iapController.products
                  .map<Widget>(
                    (e) => packageCard(
                      credit: e,
                      mostPopuler: e.title == "60 DAKİKA",
                    ),
                  )
                  .toList(),
              // [
              // packageCard(
              //   title: "10 DAKİKA",
              //   price: 10,
              //   packageName: "Başlangıç Paketi",
              // ),
              // packageCard(
              //   title: "30 DAKİKA",
              //   price: 25,
              //   packageName: "Yeni Gelen Paketi",
              // ),
              // packageCard(
              //   title: "60 DAKİKA",
              //   price: 45,
              //   packageName: "Avantaj Paketi",
              //   mostPopuler: true,
              // ),
              // packageCard(
              //   title: "100 DAKİKA",
              //   price: 80,
              //   packageName: "Süper Paketi",
              // ),
              // packageCard(
              //   title: "200 DAKİKA",
              //   price: 150,
              //   packageName: "Lüks Paketi",
              // ),
              // ],
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}
