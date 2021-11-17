import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:matelive/controller/getX/storage_controller.dart';

import '/constant.dart';
import '/model/login.dart';
import '../auth/sign_in.dart';
import '/controller/api.dart';
import '/view/HomePage/home_page.dart';
import '/view/utils/primaryButton.dart';

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
            _listTile(Text("Tüm Üyeler"), HomePage()),
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
                          bool result = await API().logout(Login().token);
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
