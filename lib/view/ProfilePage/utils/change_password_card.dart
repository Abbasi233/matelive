import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/view/utils/snackbar.dart';

import 'my_text_input.dart';
import '../../../constant.dart';
import '../../utils/my_text.dart';
import '/view/utils/primaryButton.dart';

class ChangePasswordCard extends StatelessWidget {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HESAP ŞİFRESİNİ GÜNCELLE",
                  style: styleH5(fontWeight: FontWeight.w600),
                ),
                fixedHeight,
                MyText('Eski Şifreniz'),
                MyTextInput(
                  controller: oldPasswordController,
                  hintText: 'Eski Şifrenizi Giriniz',
                  validate: true,
                  obscureText: true,
                ),
                fixedHeight,
                MyText('Yeni Şifreniz'),
                MyTextInput(
                  controller: newPasswordController,
                  hintText: 'Yeni Şifrenizi Giriniz',
                  validate: true,
                  obscureText: true,
                ),
                fixedHeight,
                MyText('Yeni Şifre Tekrarı'),
                MyTextInput(
                  controller: repeatNewPasswordController,
                  hintText: 'Yeni Şifrenizi Tekrar Giriniz',
                  validate: true,
                  obscureText: true,
                ),
                fixedHeight,
                primaryButton(
                  text: Text(
                    "Hesap Şifresini Güncelle",
                    style: styleH4(
                      fontSize: 18,
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  imageIcon: ImageIcon(
                    AssetImage('assets/icons/forward_button.png'),
                    size: 22,
                    color: kWhiteColor,
                  ),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      var body = {
                        "old_password": oldPasswordController.text,
                        "new_password": newPasswordController.text,
                        "new_password_confirmation":
                            repeatNewPasswordController.text,
                      };
                      print(body);

                      var result =
                          await API().updatePassword(Login().token, body);
                      if (result.keys.first) {
                        successSnackbar(result.values.first);
                      } else {
                        failureSnackbar(result.values.first);
                      }
                      formKey.currentState.reset();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
