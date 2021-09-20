import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import 'utils/account_info_card.dart';
import 'utils/pictures_card.dart';
import 'utils/social_media_info_card.dart';
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
                AccountInfoCard(),
                fixedHeight,
                SocialMediaInfoCard(),
                fixedHeight,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: primaryButton(
                    onPressed: () {},
                    width: Get.width,
                    height: 45,
                    borderRadius: 8,
                    text: Text(
                      "Hesap Bilgilerini Güncelle",
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
                ),
                fixedHeight,
                PicturesCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
