import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:matelive/view/Agora/call_page.dart';
import 'package:matelive/view/HomePage/home_page.dart';
import 'package:matelive/view/LandingPage/landing_page.dart';
import 'package:matelive/view/utils/primaryButton.dart';

import '/constant.dart';

class MyDrawer {
  static ListTile _listTile(Text title, Widget page,
      {Color color = kBlackColor}) {
    return ListTile(
      title: Text(title.data, style: styleH4(color: color)),
      onTap: () {
        // Get.off(() => page)
        },
    );
  }

  static Widget build() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _listTile(Text("Beğenmeler"), HomePage()),
            _listTile(Text("Dürtmeler"), HomePage()),
            _listTile(Text("Favoriler"), HomePage()),
            _listTile(Text("İletişim"), HomePage()),
            _listTile(Text("Yardım"), HomePage()),
            Divider(),
            SizedBox(height: 10),
            primaryButton(
              text: Row(
                children: [
                  Icon(LineAwesomeIcons.alternate_sign_out),
                  SizedBox(width: 5),
                  Text("Çıkış"),
                ],
              ),
              onPressed: () {
              },
              padding: 50
            )
          ],
        ),
      ),
    );
  }
}
