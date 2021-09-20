import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import 'utils/account_info_card.dart';
import 'utils/pictures_card.dart';
import 'utils/social_media_info_card.dart';
import 'utils/change_password_card.dart';
import 'utils/account_settings_card.dart';
import '/view/utils/fixedSpace.dart';
import '/view/utils/primaryButton.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                fixedHeight,
                //Profil ve Galeri Fotoğrafları
                PicturesCard(),
                fixedHeight,
                //Hesap Bilgileri
                AccountInfoCard(),
                fixedHeight,
                //Sosyal Medya Bilgileri
                SocialMediaInfoCard(),
                fixedHeight,
                //Güncelle Butonu
                _buildUpdateButton("Hesap Bilgilerini Güncelle", () {}),
                fixedHeight,
                //Hesap Şifresini Güncelle
                ChangePasswordCard(),
                fixedHeight,
                //Güncelle Butonu
                _buildUpdateButton("Hesap Şifresini Güncelle", () {}),
                fixedHeight,
                //Hesap Ayarları
                AccountSettingsCard(),
                fixedHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }

//Güncelle Butonu
  Widget _buildUpdateButton(String title, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: primaryButton(
        onPressed: onPressed,
        width: Get.width,
        height: 45,
        borderRadius: 8,
        text: Text(
          title,
          style: styleH4(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        imageIcon: ImageIcon(
          AssetImage('assets/icons/forward_button.png'),
          size: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}
