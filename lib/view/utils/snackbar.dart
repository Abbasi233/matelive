import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

void failureSnackbar(String content, {int timeout = 3}) {
  Get.snackbar(
    "İşlem Başarısız",
    content,
    backgroundColor: Colors.red[700],
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(10),
    duration: Duration(seconds: timeout),
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

void newMessageSnackbar(
    String username, String content, String imageUrl, Function onTap) {
  Get.snackbar(
    "",
    "",
    titleText: Text(
      "$username Mesaj Gönderdi",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
    ),
    messageText: Text(
      content,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
    backgroundColor: Colors.white,
    colorText: Colors.black,
    borderColor: kPrimaryColor,
    borderWidth: 1,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    icon: CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, provider) => Container(
        width: 70.0,
        height: 70.0,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: provider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: 70.0,
        height: 70.0,
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
    onTap: (getSnackBar) {
      onTap();
      //Get.offAndToNamed();  //BURADA ROUTE'LARI TANIMLAMADIĞIM İÇİN BU METODU KULLANAMIYORUM VE BİLDİRİME TIKLAYINCA MEVCUT CHAT SAYFASINA YENİDEN YÖNLENDİREMİYORUM
    },
  );
}
