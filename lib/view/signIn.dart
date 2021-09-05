import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/constant.dart';

class SignInPage extends StatelessWidget {
  final _rememberMe = false.obs;
  final _formKey = GlobalKey<FormState>();
  final _ePostaController = TextEditingController();
  final _sifreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.size.height,
            padding:
                EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: Get.size.width * 0.6,
                ),
                SizedBox(height: 30),
                Text("Matelive Giriş", style: styleH1),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(right: Get.size.width / 15),
                  child: Text(
                    "Aşağıdaki bilgileri doldurarak hesabınıza giriş yapabilir ya da buraya tıklayarak yeni bir hesap oluşturabilirsiniz.",
                    style: styleH4,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textInput(
                        hintText: "E-Posta Adresiniz",
                        controller: _ePostaController,
                      ),
                      textInput(
                        hintText: "Şifreniz",
                        controller: _sifreController,
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
                            Text("Beni Hatırla", style: styleH4),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                          textStyle: MaterialStateProperty.all(styleH4),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Giriş Yap'), Icon(Icons.person)],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Şifrenizi mi unuttunuz?",
                    style: styleH4,
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
        style: styleH4,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: customFont(
            18,
            weight: FontWeight.w500,
            color: Colors.grey,
          ),
          hoverColor: kPrimaryColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        obscureText: password,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
