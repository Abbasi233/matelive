import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/view/auth/email_confirm_page.dart';
import 'package:matelive/view/utils/snackbar.dart';

import '/constant.dart';
import 'utils/text_input.dart';

class SignUpPage extends StatelessWidget {
  final _login = Login();
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
                child: Image.asset(
                  "assets/images/logo.png",
                  // width: Get.size.width * 0.6,
                ),
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
                    Text("Sözleşmeleri okudum, onaylıyorum.", style: styleH4()),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 20, right: Get.size.width * 0.4, bottom: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    ),
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    textStyle: MaterialStateProperty.all(styleH4()),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(kTextInputBorderRadius),
                      ),
                    ),
                  ),
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

                        if (result) {
                          Get.back();
                          successSnackbar(
                              "Kaydolma işlemi başarıyla tamamlandı. E-posta hesabınıza gelen posta ile doğrulama işlemini gerçekleştirerek uygulamaya giriş yapabilirsiniz.");
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text('Kaydol'), Icon(Icons.person)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
