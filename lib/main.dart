import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'constant.dart';
import 'view/welcomePage.dart';
import 'view/landingPage.dart';
import 'controller/getX/storage.dart';

Widget _firstScreen;

void main() async {
  await GetStorage.init();
  _firstScreen = await isFirstShowingMethod();

  runApp(MyApp());
}

Future<Widget> isFirstShowingMethod() async {
  StorageController _controller = Get.put(StorageController());
  bool result = await _controller.readFirstShowing();
  return result ? WelcomePage() : LandingPage();
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
      ),
      home: _firstScreen,
    );
  }
}
