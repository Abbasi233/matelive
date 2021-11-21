import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import 'sign_in_page.dart';
import '../utils/welcomePageItems.dart';
import '../../controller/getX/storage_controller.dart';
import '../../controller/getX/welcome_page_controller.dart';

class WelcomePage extends StatelessWidget {
  final _storage = Get.find<StorageController>();
  final _pageController = PageController();
  final _welcomePageController = Get.put(WelcomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: welcomePageItems.length,
            itemBuilder: (context, i) {
              print("Drawed");
              _pageController.addListener(() {
                _welcomePageController.emitPageNumber(_pageController);
              });
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            welcomePageItems[i]['center'],
                            width: 100,
                          ),
                          Text(
                            welcomePageItems[i]['title'],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF3F3D56),
                              height: 2.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            welcomePageItems[i]['description'],
                            style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: 1.2,
                                fontSize: 16.0,
                                height: 1.3),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10) +
                          EdgeInsets.only(bottom: 40),
                      child: welcomePageItems[i]['ID'] != '4'
                          ? Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Tanıtımı Geç",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      onPressed: () => closeScreen(context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                kWhiteColor),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kPrimaryColor),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text("Sonraki"),
                                      ),
                                      onPressed: () {
                                        _welcomePageController
                                            .changePage(_pageController);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(kWhiteColor),
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text("Hadi Başlayalım!"),
                                ),
                                onPressed: () => closeScreen(context),
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    welcomePageItems.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      height: 10.0,
                      width: 10.0,
                      decoration: BoxDecoration(
                        color: _welcomePageController.pageNo.value == index
                            ? kPrimaryColor
                            : kPrimaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    growable: false,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void closeScreen(BuildContext context) {
    _storage.saveFirstShowing();
    Get.off(() => SignInPage());
  }
}
