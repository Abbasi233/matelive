import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: 20) + EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: Get.size.width * 0.6,
              ),
              Text("Matelive Giriş", style: styleH1)
            ],
          ),
        ),
      ),
    );
  }
}
