import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import 'utils/pictures_card.dart';
import 'utils/account_info_card.dart';
import 'utils/change_password_card.dart';
import 'utils/account_settings_card.dart';
import '/view/utils/progressIndicator.dart';

class ProfilePage extends StatelessWidget {
  final profileFuture = API().getProfile(Login().token);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TextField dışında bir yere tıklayınca TextField'ın unfocus olması için
      onTap: () {
        // FocusScopeNode currentFocus = FocusScope.of(context);

        // if (!currentFocus.hasPrimaryFocus &&
        //     currentFocus.focusedChild != null) {
        //   FocusManager.instance.primaryFocus.unfocus();
        // }
      },
      child: Scaffold(
        body: FutureBuilder(
          future: profileFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: Get.width,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        fixedHeight,
                        PicturesCard(),
                        fixedHeight,
                        AccountInfoCard(),
                        fixedHeight,
                        fixedHeight,
                        ChangePasswordCard(),
                        fixedHeight,
                        fixedHeight,
                        AccountSettingsCard(),
                        fixedHeight,
                      ],
                    ),
                  ),
                ),
              );
            }
            return showProgressIndicator(context);
          },
        ),
      ),
    );
  }
}
