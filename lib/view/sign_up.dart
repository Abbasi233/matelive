import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/EmailConfirmPage/email_confirm_page.dart';

import '/constant.dart';

class SignUpPage extends StatelessWidget {
  final _rememberMe = false.obs;
  final _formKey = GlobalKey<FormState>();
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
                        Expanded(child: textInput(hintText: "Adınız")),
                        SizedBox(width: 20),
                        Expanded(child: textInput(hintText: "Soyadınız")),
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
                      value: _rememberMe.value,
                      onChanged: (value) => _rememberMe.value = value,
                      fillColor: MaterialStateProperty.all(kPrimaryColor),
                    ),
                    Text("Sözleşmeleri okudum, onaylıyorum.", style: styleH4()),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20,right: Get.size.width * 0.4, bottom: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    ),
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    textStyle: MaterialStateProperty.all(styleH4()),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kTextInputBorderRadius),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // if (_formKey.currentState.validate()) {}
                    Get.to(() => EmailConfirmPage());
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

  Widget textInput(
      {String hintText,
      TextEditingController controller,
      bool password = false}) {
    return TextFormField(
      style: styleH4(),
      controller: controller,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: customFont(
          18,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        hoverColor: kPrimaryColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(kTextInputBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(kTextInputBorderRadius),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      ),
      obscureText: password,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen bu alanı doldurun.';
        }
        return null;
      },
    );
  }
}
