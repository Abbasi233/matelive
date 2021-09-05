import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matelive/controller/getX/storage.dart';
import 'package:matelive/view/signIn.dart';
import 'package:matelive/view/welcomePage.dart';

import 'view/homePage.dart';

Widget _firstScreen;

void main() async {
  await GetStorage.init();
  _firstScreen = await isFirstShowingMethod();

  runApp(MyApp());
}

Future<Widget> isFirstShowingMethod() async {
  StorageController _controller = StorageController();
  bool result = await _controller.isFirstShowing();
  return result ? WelcomePage() : SignInPage();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matelive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _firstScreen,
    );
  }
}
