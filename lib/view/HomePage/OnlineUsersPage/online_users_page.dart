import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/utils/circularProgress.dart';
import 'package:matelive/view/utils/progressIndicator.dart';
import 'package:matelive/view/utils/progress_dialog.dart';

import '/constant.dart';
import '/view/utils/appBar.dart';
import '/view/utils/footer.dart';
import '/view/utils/primaryButton.dart';
import '/view/HomePage/OnlineUsersPage/utils/user_card.dart';

class OnlineUsersPage extends StatefulWidget {
  @override
  _OnlineUsersPageState createState() => _OnlineUsersPageState();
}

class _OnlineUsersPageState extends State<OnlineUsersPage> {
  var onlineUsers = 0.obs;
  String _selectedFilter = 'Tümü';
  Future<Map<bool, dynamic>> _future;

  List<String> buttonLabels = [
    "Tümü",
    "Kadınlar",
    "Erkekler",
  ];

  @override
  void initState() {
    super.initState();
    _future = API().getOnlineUsers(Login().token, _selectedFilter, "");
  }

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
            Obx(
              () => Text.rich(
                TextSpan(
                  text: "Matelive'da ",
                  style: styleH5(color: kTabBarColor),
                  children: [
                    TextSpan(
                      text: "${onlineUsers.value} Kullanıcı ",
                      style: styleH3(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: "Online")
                  ],
                ),
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
                              String gender = "";
                              if (label == "Kadınlar") {
                                gender = "1";
                              } else if (label == "Erkekler") {
                                gender = "2";
                              }

                              _future = API()
                                  .getOnlineUsers(Login().token, gender, "");
                            });
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                  .toList(),
            ),
            fixedHeight,
            FutureBuilder<Map<bool, dynamic>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  if (data.keys.first) {
                    var pagedResponse = data.values.first as PagedResponse;
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => onlineUsers.value = pagedResponse.meta.total,
                    );

                    return Column(
                      children: pagedResponse.data
                          .map<Widget>(
                            (userDetail) => userCard(userDetail: userDetail),
                          )
                          .toList(),
                    );
                  } else {
                    return Container(
                      height: 300,
                      child: Center(child: Text(snapshot.data.values.first)),
                    );
                  }
                }
                return showProgressIndicator(context);
              },
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}
