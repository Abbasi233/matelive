import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/utils/drawer.dart';

import '../../../constant.dart';
import '/view/utils/appBar.dart';
import '/view/utils/footer.dart';
import '/view/utils/primaryButton.dart';
import '/view/HomePage/OnlineUsersPage/utils/user_card.dart';

class OnlineUsers extends StatefulWidget {
  @override
  _OnlineUsersState createState() => _OnlineUsersState();
}

class _OnlineUsersState extends State<OnlineUsers> {
  var _selectedFilter = 'Tümü';

  List<String> buttonLabels = [
    "Tümü",
    "Kadınlar",
    "Erkekler",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "Online Kullanıcılar",
          style: styleH3(),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            fixedHeight,
            Text.rich(
              TextSpan(
                text: "Matelive'da ",
                style: styleH5(color: kTabBarColor),
                children: [
                  TextSpan(
                    text: "3 Kullanıcı ",
                    style: styleH3(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: "Online")
                ],
              ),
            ),
            fixedHeight,
            Column(
              children: buttonLabels
                  .map<Widget>(
                    (label) => Column(
                      children: [
                        primaryButton(
                          text: Text(
                            label,
                            style: styleH5(
                                color: _selectedFilter == label
                                    ? kWhiteColor
                                    : kPrimaryColor),
                          ),
                          backgroundColor: _selectedFilter == label
                              ? kPrimaryColor
                              : kWhiteColor,
                          onPressed: () {
                            setState(() {
                              _selectedFilter = label;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                  .toList(),
            ),
            userCard(
              username: "Mobil Test",
              age: "Yaş Bilgisi Bulunamadı.",
            ),
            userCard(
              username: "Mobil Test",
              age: "23 Yaşında",
            ),
            userCard(
              username: "Furkan Yılmaz",
              age: "Yaş Bilgisi Bulunamadı.",
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}
