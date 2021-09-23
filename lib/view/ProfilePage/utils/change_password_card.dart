import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../utils/my_text.dart';
import 'my_text_input.dart';
import '../../../constant.dart';
import '/view/utils/fixedSpace.dart';

class ChangePasswordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HESAP ŞİFRESİNİ GÜNCELLE",
                style: styleH5(fontWeight: FontWeight.w600),
              ),
              fixedHeight,
              MyText('Eski Şifreniz'),
              MyTextInput(hintText: 'Eski Şifrenizi Giriniz'),
              fixedHeight,
              MyText('Yeni Şifreniz'),
              MyTextInput(hintText: 'Yeni Şifrenizi Giriniz'),
              fixedHeight,
              MyText('Yeni Şifre Tekrarı'),
              MyTextInput(hintText: 'Yeni Şifrenizi Tekrar Giriniz'),
              fixedHeight,
            ],
          ),
        ),
      ),
    );
  }
}
