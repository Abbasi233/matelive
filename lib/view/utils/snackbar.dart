import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/constant.dart';

void successSnackbar(String content) {
  Get.snackbar("İşlem Başarılı", content,
      backgroundColor: Colors.green[700], colorText: Colors.white);
}

void failureSnackbar(String content) {
  Get.snackbar("İşlem Başarısız", content,
      backgroundColor: Colors.red[700], colorText: Colors.white);
}

void normalSnackbar(String content) {
  Get.snackbar(
    "İşlem Sonucu",
    content,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    borderColor: kPrimaryColor,
    borderWidth: 1
  );
}
