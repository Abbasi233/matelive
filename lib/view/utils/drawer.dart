import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:matelive/controller/getX/chat_controller.dart';
import 'package:matelive/controller/getX/pusher_controller.dart';
import 'package:matelive/view/LandingPage/about_page/about_page.dart';
import 'package:matelive/view/LandingPage/blocks_page/blocks_page.dart';
import 'package:matelive/view/LandingPage/contact_page/contact_page.dart';
import 'package:matelive/view/LandingPage/controller.dart';
import 'package:matelive/view/LandingPage/faq_page/faq_page.dart';
import 'package:matelive/view/auth/utils/policy_page.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/auth/sign_in_page.dart';
import '/view/utils/primaryButton.dart';
import '/controller/getX/storage_controller.dart';
import '/view/LandingPage/actions_page/actions_page.dart';
import '/view/LandingPage/all_users_page/all_users_page.dart';
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
    var landingPageController = Get.find<LandingPageController>();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _listTile(Text("Tüm Üyeler"), AllUsersPage()),
            _listTile(Text("Beğenmeler"), ActionsPage("Beğenmeler", "3")),
            _listTile(Text("Dürtmeler"), ActionsPage("Dürtmeler", "4")),
            _listTile(Text("Favoriler"), FavoritesPage()),
            _listTile(Text("Engellenenler"), BlocksPage()),
            _listTile(Text("Hakkımızda"), AboutPage()),
            _listTile(Text("İletişim"), ContactPage()),
            _listTile(
              Text("Kullanıcı Sözleşmesi"),
              PolicyPage(
                "assets/documents/user_policy.pdf",
                "Kullanıcı Sözleşmesi",
              ),
            ),
            _listTile(
              Text("Gizlilik Politikası"),
              PolicyPage(
                "assets/documents/privacy_policy.pdf",
                "Gizlilik ve Güvenlik Politikası",
              ),
            ),
            _listTile(Text("S.S.S."), FaqPage()),
            Obx(() {
              return Text("v" +
                  landingPageController.appVersion.value +
                  "." +
                  landingPageController.appBuildNumber.value);
            }),
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
                          Get.find<ChatController>().dispose();
                          Get.find<PusherController>().dispose();
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
            ),
          ],
        ),
      ),
    );
  }
}
