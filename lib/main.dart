import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/controller/getX/notifications_controller.dart';
import 'package:matelive/model/login.dart';

import 'constant.dart';
import '/view/auth/sign_in.dart';
import 'view/auth/welcome_page.dart';
import '/view/LandingPage/landing_page.dart';
import 'controller/getX/storage_controller.dart';

Widget _firstPage;
void main() async {
  await GetStorage.init();
  _firstPage = await initFirstPage();

  runApp(MyApp());
}

Future<Widget> initFirstPage() async {
  var _storageController = Get.put(StorageController());
  bool result = _storageController.readFirstShowing();

  if (result) {
    return WelcomePage();
  } else {
    if (_storageController.readLogin()) {
      return await getNofitications() ? LandingPage() : SignInPage();
    }
  }
  return SignInPage();
}

Future<bool> getNofitications() async {
  var result = await API().getNotificationsByType(Login().token, "all");
  if (result.keys.first) {
    Get.put(NotificationsController()).pagedResponse.value =
        result.values.first;
    return true;
  }
  return false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matelive',
      theme: ThemeData(
        fontFamily: "Jost",
        primaryColor: kPrimaryColor,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: kBlackColor)),
        secondaryHeaderColor: kBlackColor,
      ),
      home: _firstPage,
    );
  }
}
