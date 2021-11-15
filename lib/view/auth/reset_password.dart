import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/view/utils/primaryButton.dart';
import 'package:matelive/view/utils/snackbar.dart';

import '/constant.dart';
import 'utils/text_input.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _eMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20) +
                  EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: Get.size.width * 0.6,
                  ),
                  fixedHeight,
                  Text("Matelive Şifremi Unuttum", style: styleH1()),
                  fixedHeight,
                  Text(
                    "Sıfırlama bağlantısı talebiniz ardından e-posta adresinize gelecek yönlendirmeler ile şifrenizi sıfırlayabilirsiniz.",
                    style: styleH4(),
                  ),
                  fixedHeight,
                  Form(
                    key: _formKey,
                    child: textInput(
                      hintText: "E-Posta Adresiniz",
                      controller: _eMailController,
                    ),
                  ),
                  fixedHeight,
                  primaryButton(
                    text: Expanded(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                                'Şifre Sıfırlama Bağlantısını Gönder'),
                          ),
                          fixedWidth,
                          Icon(Icons.lock_clock_rounded)
                        ],
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var result = await API().sendResetPasswordMail({
                          "email": _eMailController.text,
                        });

                        normalSnackbar(result);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
