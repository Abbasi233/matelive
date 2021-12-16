import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import '/model/credit.dart';
import 'utils/packageCard.dart';
import '/view/utils/footer.dart';
import '/controller/in-app-purchase.dart';

class CreditsPage extends StatefulWidget {
  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  List<Credit> products = [];
  var iapController = Get.find<IAPController>();

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
              children: iapController.products
                  .map<Widget>(
                    (e) => creditCard(
                      credit: e,
                      mostPopuler: e.title == "60 DAKİKA",
                    ),
                  )
                  .toList(),
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}
