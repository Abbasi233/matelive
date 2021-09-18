import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'utils/account_info_card.dart';
import '/view/utils/fixedSpace.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                fixedHeight,
                AccountInfoCard(),
                fixedHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
