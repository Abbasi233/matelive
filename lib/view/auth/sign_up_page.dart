import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:matelive/view/utils/primaryButton.dart';

import '/constant.dart';
import '/controller/api.dart';
import 'utils/text_input.dart';
import '/view/utils/snackbar.dart';
import '/view/auth/email_confirm_page.dart';

class SignUpPage extends StatelessWidget {
  final _policies = false.obs;
  final _formKey = GlobalKey<FormState>();

  final _adController = TextEditingController();
  final _soyadController = TextEditingController();
  final _eMailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.size.height,
        child: SafeArea(
          child: ListView(
            padding:
                EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(top: 30),
            children: [
              Padding(
                padding: EdgeInsets.only(right: Get.size.width * 0.3),
                child: Image.asset("assets/images/logo.png"),
              ),
              SizedBox(height: 30),
              Text("Matelive'a Kaydol", style: styleH1()),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(right: Get.size.width / 15),
                child: Container(
                  child: Text.rich(
                    TextSpan(
                      style: styleH4(),
                      children: [
                        TextSpan(
                            text:
                                "Aşağıdaki bilgileri doldurarak yeni bir hesap oluşturabilir ya da "),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Text(
                              "buraya tıklayarak",
                              style: customFont(22, color: kPrimaryColor),
                            ),
                          ),
                        ),
                        TextSpan(
                            text: " var olan hesabınıza giriş yapabilirsiniz."),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: textInput(
                          hintText: "Adınız",
                          controller: _adController,
                        )),
                        SizedBox(width: 20),
                        Expanded(
                            child: textInput(
                          hintText: "Soyadınız",
                          controller: _soyadController,
                        )),
                      ],
                    ),
                    SizedBox(height: 15),
                    textInput(
                      hintText: "E-Posta Adresiniz",
                      controller: _eMailController,
                    ),
                    SizedBox(height: 15),
                    textInput(
                      hintText: "Şifreniz",
                      controller: _passwordController,
                      password: true,
                    ),
                    SizedBox(height: 15),
                    textInput(
                      hintText: "Şifrenizi Tekrar Giriniz",
                      controller: _passwordRepeatController,
                      password: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _policies.value,
                      onChanged: (value) => _policies.value = value,
                      fillColor: MaterialStateProperty.all(kPrimaryColor),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        "Sözleşmeleri okudum, onaylıyorum.",
                        style: styleH4(),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: Get.size.width * 0.4),
                child: primaryButton(
                  text: AutoSizeText(
                    'Kaydol',
                    maxLines: 1,
                  ),
                  imageIcon: Icon(Icons.person),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (_policies.value) {
                        var body = {
                          "name": _adController.text,
                          "surname": _soyadController.text,
                          "email": _eMailController.text,
                          "password": _passwordController.text,
                          "password_confirmation":
                              _passwordRepeatController.text,
                          "policy": true, // ??
                        };

                        var result = await API().register(body);

                        if (result.keys.first) {
                          Get.back();
                          successSnackbar(
                              "Kaydolma işlemi başarıyla tamamlandı. E-posta hesabınıza gelen posta ile doğrulama işlemini gerçekleştirerek uygulamaya giriş yapabilirsiniz.");

                          var resultVerify =
                              await API().sendVerifyEmail(result.values.first);
                          normalSnackbar(resultVerify);

                          Get.off(() => EmailConfirmPage());
                        } else {
                          failureSnackbar(
                              "Kaydolma işlemi sırasında bir hata oluştu. Lütfen girdiğiniz bilgileri kontrol ediniz.");
                        }
                      } else {
                        failureSnackbar(
                            "Sözleşmeleri onaylamadan kayıt olma işlemini gerçekleştiremezsiniz.");
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
