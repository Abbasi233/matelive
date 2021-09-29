import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/getX/storage.dart';
import 'package:matelive/view/LandingPage/landing_page.dart';
import 'package:matelive/view/sign_in.dart';
import 'package:matelive/view/utils/circularProgress.dart';

class AuthPage extends StatelessWidget {
  /// TODO AUTH
  // BACKEND HAZIRLANDIĞINDA AUTH İŞLEMİ BURADA STREAM İLE DENENECEK
  // Stream _authStream;

  final _storageController = Get.find<StorageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _storageController.readLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data)
              return LandingPage();
            else
              return SignInPage();
          }
          return MyCircularProgress();
        },
      ),
    );
  }
}
