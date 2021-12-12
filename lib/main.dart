import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matelive/controller/getX/calls_controller.dart';
import 'package:matelive/controller/in-app-purchase.dart';

import 'constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import 'view/auth/sign_in_page.dart';
import 'view/auth/welcome_page.dart';
import '/view/LandingPage/landing_page.dart';
import 'controller/getX/storage_controller.dart';
import '/controller/getX/notifications_controller.dart';

Widget _firstPage;
void main() async {
  await GetStorage.init();
  _firstPage = await initFirstPage();

  runApp(MyApp());
}

Future<Widget> initFirstPage() async {
  var _storageController = Get.put(StorageController());
  bool result = _storageController.readFirstShowing();

  if (!result) {
    if (_storageController.readLogin()) {
      return await initApp() ? LandingPage() : SignInPage();
    }
  } else {
    return WelcomePage();
  }
  return SignInPage();
}

Future<bool> initApp() async {
  var futureList = await Future.wait([
    getProfile(),
    getCalls(),
    getNofitications(),
  ]);
  return futureList.every((element) => element);
}

Future<bool> getProfile() async {
  var result = await API().getProfile(Login().token);
  return result.keys.first;
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

Future<bool> getCalls() async {
  var result = await API().getCalls(Login().token);
  if (result.keys.first) {
    Get.put(CallsController()).pagedResponse.value = result.values.first;
    return true;
  }
  return false;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var iapController = Get.put(IAPController());

  @override
  void initState() {
    super.initState();
  }

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
