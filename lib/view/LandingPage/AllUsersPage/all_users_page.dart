import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/utils/circularProgress.dart';
import 'package:matelive/view/utils/progressIndicator.dart';
import 'package:matelive/view/utils/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/constant.dart';
import '/view/utils/appBar.dart';
import '/view/utils/footer.dart';
import '/view/utils/primaryButton.dart';
import '/view/HomePage/OnlineUsersPage/utils/user_card.dart';

class AllUsersPage extends StatefulWidget {
  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  var allUsersCount = 0.obs;
  List<dynamic> userList = [];
  PagedResponse pagedResponse;
  String _selectedFilter = 'Tümü';

  List<String> buttonLabels = [
    "Tümü",
    "Kadınlar",
    "Erkekler",
  ];

  StreamController<List<dynamic>> streamController;
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    streamController = StreamController();
    API().getAllUsers(Login().token, _selectedFilter, "", "").then((value) {
      if (value.keys.first) {
        pagedResponse = value.values.first as PagedResponse;

        userList.addAll(pagedResponse.data);
        streamController.add(userList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "Tüm Kullanıcılar",
          style: styleH3(),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Scrollbar(
          child: SmartRefresher(
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: _customFooter(),
            controller: _refreshController,
            header: MaterialClassicHeader(),
            physics: BouncingScrollPhysics(),
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
                          text: "${allUsersCount.value} Kullanıcı ",
                          style: styleH3(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: "Mevcut")
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
                              onPressed: () async {
                                String gender = "";

                                setState(() {
                                  _selectedFilter = label;
                                  if (label == "Kadınlar") {
                                    gender = "1";
                                  } else if (label == "Erkekler") {
                                    gender = "2";
                                  }
                                });

                                streamController.add(null);
                                var refreshUserList = await API()
                                    .getAllUsers(Login().token, gender, "", "");
                                pagedResponse = refreshUserList.values.first;
                                userList = pagedResponse.data;
                                streamController.add(userList);
                              },
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      )
                      .toList(),
                ),
                fixedHeight,
                StreamBuilder<List<dynamic>>(
                  stream: streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;

                      if (data != null && data.isNotEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback(
                          (_) => allUsersCount.value = pagedResponse.meta.total,
                        );

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userList.length,
                          itemBuilder: (context, i) =>
                              userCard(userDetail: userList[i]),
                        );
                      } else {
                        return Container(
                          height: 300,
                          child: Center(child: Text("Bir Hata Oluştu")),
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
        ),
      ),
    );
  }

  void _onRefresh() async {
    streamController.add(null);

    String gender = "";
    if (_selectedFilter == "Kadınlar") {
      gender = "1";
    } else if (_selectedFilter == "Erkekler") {
      gender = "2";
    }
    var newAllUserFuture =
        await API().getAllUsers(Login().token, gender, "", "");

    if (newAllUserFuture.keys.first) {
      pagedResponse = newAllUserFuture.values.first as PagedResponse;
      userList = pagedResponse.data;
    }
    streamController.add(userList);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (pagedResponse.meta.currentPage < pagedResponse.meta.lastPage) {
      var loadNewUsers = await API().getAllUsers(
        Login().token,
        _selectedFilter,
        "",
        (pagedResponse.meta.currentPage + 1).toString(),
      );

      if (loadNewUsers.keys.first) {
        pagedResponse = loadNewUsers.values.first as PagedResponse;
        userList.addAll(pagedResponse.data);
        streamController.add(userList);
      }
    }
    _refreshController.loadComplete();
  }

  Widget _customFooter() {
    return CustomFooter(
      height: 100,
      loadStyle: LoadStyle.ShowWhenLoading,
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("Yüklemek için kaydırın");
        } else if (mode == LoadStatus.loading) {
          body = showProgressIndicator(context);
        } else if (mode == LoadStatus.failed) {
          body = Text("Yüklenirken hata oluştu. Tekrar deneyin.");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("Yüklemek için bırakın");
        } else {
          body = Text("Liste Sonu");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
