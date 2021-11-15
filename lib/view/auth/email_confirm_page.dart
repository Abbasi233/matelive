import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/view/utils/snackbar.dart';

import '/constant.dart';
import '/view/LandingPage/landing_page.dart';

class EmailConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
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
                Text("Matelive E-Posta Onayı", style: styleH1()),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(right: Get.size.width / 15),
                  child: Text.rich(
                    TextSpan(
                      style: styleH4(),
                      children: [
                        TextSpan(
                          text:
                              "Hesap kurulumunuzun tamamlanması için e-posta adresinizi onaylamanız gerekmektedir.\n",
                          style: customFont(24, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                            text:
                                "Eğer bir e-posta almadıysanız aşağıdaki butona tıklayarak yeni bir doğrulama talep edebilirsiniz.",
                            style: styleH4()),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size(double.infinity, 50)),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        textStyle: MaterialStateProperty.all(styleH4()),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kTextInputBorderRadius),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        var result = await API().sendVerifyEmail(Login().token);
                        normalSnackbar(result);
                      },
                      child: Text('Yeni Bir Doğrulama E-Postası'),
                    ),
                  ],
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
