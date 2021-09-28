import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/Agora/test.dart';
import 'package:matelive/view/utils/primaryButton.dart';

import '/constant.dart';
import '/view/signUp.dart';

class SignInPage extends StatelessWidget {
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _rememberMe.value,
                              onChanged: (value) => _rememberMe.value = value,
                              fillColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                            ),
                            Text("Beni Hatırla", style: styleH4()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: primaryButton(
                        text: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Giriş Yap'), Icon(Icons.person)],
                        ),
                        onPressed: () {
                          // if (_formKey.currentState.validate()) {}
                          // Get.to(() => AgoraCall());
                          Get.to(() => SignUpPage());
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Şifrenizi mi unuttunuz?",
                    style: styleH4(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textInput(
      {String hintText,
      TextEditingController controller,
      bool password = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
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
      ),
    );
  }
}
