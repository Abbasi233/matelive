import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';

void successSnackbar(String content) {
  Get.snackbar(
    "İşlem Başarılı",
    content,
    backgroundColor: Colors.green[700],
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(10),
  );
}

void failureSnackbar(String content) {
  Get.snackbar(
    "İşlem Başarısız",
    content,
    backgroundColor: Colors.red[700],
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(10),
  );
}

void normalSnackbar(String content) {
  Get.snackbar(
    "İşlem Sonucu",
    content,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    borderColor: kPrimaryColor,
    borderWidth: 1,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(10),
  );
}
