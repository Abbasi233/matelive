import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/getX/calls_controller.dart';

import '/constant.dart';
import 'sign_up_page.dart';
import '/model/login.dart';
import '/controller/api.dart';
import 'utils/text_input.dart';
import '/view/utils/snackbar.dart';
import '/view/auth/reset_password.dart';
import '/view/utils/primaryButton.dart';
import '/view/LandingPage/landing_page.dart';
import '/controller/getX/storage_controller.dart';
import '/controller/getX/notifications_controller.dart';

class SignInPage extends StatelessWidget {
  final storageController = Get.find<StorageController>();

  final _api = API();
  final _rememberMe = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _eMailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.size.height,
          width: Get.size.width,
          padding:
              EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: Get.size.width * 0.6,
                ),
                SizedBox(height: 30),
                Text("Matelive Giriş", style: styleH1()),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(right: Get.size.width / 15),
                  child: Text.rich(
                    TextSpan(
                      style: styleH4(),
                      children: [
                        TextSpan(
                            text:
                                "Aşağıdaki bilgileri doldurarak hesabınıza giriş yapabilir ya da "),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Get.to(() => SignUpPage()),
                            child: Text(
                              "buraya tıklayarak",
                              style: customFont(22, color: kPrimaryColor),
                            ),
                          ),
                        ),
                        TextSpan(text: " yeni bir hesap oluşturabilirsiniz."),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textInput(
                        hintText: "E-Posta Adresiniz",
                        controller: _eMailController,
                      ),
                      fixedHeight,
                      textInput(
                        hintText: "Şifreniz",
                        controller: _passwordController,
                        password: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(
                        () => Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _rememberMe.value,
                              onChanged: (value) => _rememberMe.value = value,
                              fillColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                            ),
                            Expanded(
                              child: AutoSizeText(
                                "Beni Hatırla",
                                style: styleH4(),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: primaryButton(
                        text: Expanded(
                          child: AutoSizeText(
                            'Giriş Yap',
                            maxLines: 1,
                          ),
                        ),
                        imageIcon: Icon(Icons.person),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var result = await _api.login({
                              "email": _eMailController.text,
                              "password": _passwordController.text,
                            });

                            if (result) {
                              if (_rememberMe.value) {
                                storageController.saveLogin(Login().toJson());
                              }

                              var result = await _api.getNotificationsByType(
                                Login().token,
                                "all",
                              );
                              if (result.keys.first) {
                                await _api.getProfile(Login().token);
                                Get.put(NotificationsController())
                                    .pagedResponse
                                    .value = result.values.first;

                                var callsResult =
                                    await _api.getCalls(Login().token);
                                Get.put(CallsController()).pagedResponse.value =
                                    callsResult.values.first;

                                Get.off(() => LandingPage());
                              } else {
                                failureSnackbar(result[false]);
                              }
                            } else {
                              failureSnackbar(
                                  "Kullanıcı adı veya şifre yanlış.");
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                TextButton(
                  child: Text(
                    "Şifrenizi mi unuttunuz?",
                    style: styleH4(),
                  ),
                  onPressed: () {
                    Get.to(() => ResetPasswordPage());
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
