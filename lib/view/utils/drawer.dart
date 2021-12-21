import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/auth/sign_in_page.dart';
import '/view/utils/primaryButton.dart';
import '/controller/getX/storage_controller.dart';
import '/view/LandingPage/actions_page/actions_page.dart';
import '/view/LandingPage/AllUsersPage/all_users_page.dart';
import '/view/LandingPage/favorites_page/favorites_page.dart';

class MyDrawer {
  static ListTile _listTile(Text title, Widget page,
      {Color color = kBlackColor}) {
    return ListTile(
      title: Text(title.data, style: styleH4(color: color)),
      onTap: () {
        if (page != null) {
          Get.back();
          Get.to(() => page);
        }
      },
    );
  }

  static Widget build() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _listTile(Text("Tüm Üyeler"), AllUsersPage()),
            _listTile(Text("Beğenmeler"), ActionsPage("Beğenmeler", "3")),
            _listTile(Text("Dürtmeler"), ActionsPage("Dürtmeler", "4")),
            _listTile(Text("Favoriler"), FavoritesPage()),
            _listTile(Text("İletişim"), null),
            _listTile(Text("Yardım"), null),
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
              padding: 50,
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Çıkış Onayı'),
                    content:
                        Text('Uygulamadan çıkmak istediğinize emin misiniz?'),
                    actions: <Widget>[
                      OutlinedButton(
                        child: Text('Evet'),
                        onPressed: () async {
                          await API().logout(Login().token);
                          // Token geçersizse mesaj dönüyor ama ekrana yazdırmaya gerek yok.
                          Get.find<StorageController>().saveLogin(null);
                          Get.offAll(() => SignInPage());
                        },
                      ),
                      OutlinedButton(
                        child: Text('Hayır'),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
