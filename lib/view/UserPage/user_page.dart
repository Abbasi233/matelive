import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:matelive/view/chats_page/message_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:matelive/view/utils/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../controller/getX/chat_controller.dart';
import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/model/user_detail.dart';
import '/view/utils/appBar.dart';
import '/view/utils/footer.dart';
import '/view/utils/snackbar.dart';
import '/model/profile_detail.dart';
import '/view/utils/show_image.dart';
import '/view/UserPage/utils/block_dialog.dart';
import '/view/UserPage/utils/report_dialog.dart';
import '/controller/getX/Agora/calling_controller.dart';

class UserDetailPage extends StatefulWidget {
  final UserDetail userDetail;
  UserDetailPage(this.userDetail);
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final _refreshController = RefreshController(initialRefresh: false);

  UserDetail userDetail;

  List<String> gender = [
    "Kadın",
    "Erkek",
    "Belirtilmemiş",
  ];

  var callingController = Get.find<CallingController>();

  @override
  void initState() {
    super.initState();
    userDetail = widget.userDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.circle,
              color: userDetail.isOnline ? kGreenColor : kPrimaryColor,
            ),
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          controller: _refreshController,
          header: MaterialClassicHeader(),
          physics: BouncingScrollPhysics(),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.grey[300],
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: CachedNetworkImage(
                            imageUrl: userDetail.image,
                            imageBuilder: (context, provider) => Container(
                              width: Get.width * .35,
                              height: Get.width * .35,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: provider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: Get.width * .35,
                              height: Get.width * .35,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          onTap: () {
                            Get.dialog(showImage(imageUrl: userDetail.image));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Tooltip(
                              child: Text(
                                "${userDetail.name} ${userDetail.surname}",
                                style: styleH3().copyWith(),
                              ),
                              message: userDetail.id.toString(),
                            ),
                            userDetail.emailVerified
                                ? Icon(
                                    Icons.verified,
                                    color: Colors.blue,
                                  )
                                : Container(),
                          ],
                        ),
                        userDetail.description != null
                            ? Html(
                                data: "<p>${userDetail.description}<p>",
                                style: {
                                  "p": Style(
                                    fontSize: FontSize.larger,
                                    color: kTextColor,
                                    // fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.center,
                                  ),
                                },
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Henüz açıklama girilmemiş",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              width: Get.width * 0.40,
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                child: userDetail.id == ProfileDetail().id
                                    ? Center(
                                        child: autoSize(
                                          text: "Kendi Profiliniz",
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.message_outlined,
                                            color: kWhiteColor,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "Mesaj Gönder",
                                              style: styleH4(
                                                color: kWhiteColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                onTap: () {
                                  var chatController =
                                      Get.find<ChatController>();
                                  var result = chatController
                                      .getExistRoomId(userDetail.id);
                                  chatController.messages.clear();

                                  Get.to(() => MessagePage(
                                        roomId: result,
                                        receiver: userDetail,
                                      ));
                                },
                              ),
                            ),
                            userDetail.isOnline &&
                                    userDetail.id != ProfileDetail().id
                                ? Container(
                                    height: 50,
                                    margin: const EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: kGreenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    width: Get.width * 0.40,
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone_outlined,
                                            color: kWhiteColor,
                                          ),
                                          AutoSizeText(
                                            "Şimdi Ara",
                                            style: styleH4(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        if (userDetail.isOnline) {
                                          callingController
                                              .createCall(userDetail);
                                        }
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        fixedHeight,
                        userDetail?.userPermissions?.socialMedias == null ||
                                userDetail.userPermissions.socialMedias == false
                            ? Center(
                                child: notHavePermission(),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: socialMediaButtons(),
                              ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.report),
                            onPressed: () async {
                              var dialogResult =
                                  await Get.dialog(ReportDialog());

                              if (dialogResult != null) {
                                var map = {
                                  "spam_user_id": userDetail.id,
                                  "message": dialogResult,
                                };

                                print(map);
                                var result = await API().reportUser(
                                  Login().token,
                                  map,
                                );

                                if (result.keys.first) {
                                  successSnackbar(result.values.first);
                                } else {
                                  failureSnackbar(result.values.first);
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.block_outlined),
                            onPressed: () async {
                              var dialogResult =
                                  await Get.dialog(BlockDialog());

                              if (dialogResult != null && dialogResult) {
                                var map = {
                                  "type": 5,
                                  "related_user_id": userDetail.id,
                                };
                                var result = await API().setAction(
                                  Login().token,
                                  map,
                                );

                                if (result.keys.first) {
                                  Get.back();
                                  successSnackbar(result.values.first);
                                } else {
                                  failureSnackbar(result.values.first);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fixedHeight,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        border: Border.all(
                          width: 1,
                          color: kTextColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("HAKKINDA",
                              style: styleH4(fontWeight: FontWeight.w600)),
                          userDetail?.userPermissions?.description == null ||
                                  userDetail.userPermissions.description ==
                                      false
                              ? Center(
                                  child: notHavePermission(),
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "Cinsiyet: ",
                                        children: [
                                          TextSpan(
                                            text: userDetail.gender == null
                                                ? "Belirtilmemiş"
                                                : gender[userDetail.gender],
                                            style: styleH4(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                      style: styleH4(),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: "Yaş: ",
                                        children: [
                                          TextSpan(
                                            text: userDetail.age,
                                            style: styleH4(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                      style: styleH4(),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    fixedHeight,
                    Text(
                      "Fotoğraf Galerisi",
                      style: styleH2(),
                    ),
                    fixedHeight,
                    userDetail?.userPermissions?.gallery == null ||
                            userDetail.userPermissions.gallery == false
                        ? Center(
                            child: notHavePermission(),
                          )
                        : userDetail.gallery.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3,
                                ),
                                itemCount: userDetail.gallery.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.dialog(
                                        showImage(
                                          galleryIndex: index,
                                          gallery: userDetail.gallery,
                                        ),
                                      );
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: userDetail.gallery[index].image,
                                      imageBuilder: (context, provider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: provider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  "Kullanıcı henüz bir fotoğraf paylaşmadı.",
                                  style: styleH4(color: kBlackColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                  ],
                ),
              ),
              fixedHeight,
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  Text notHavePermission() {
    return Text("Bu kısmı görüntülemek için yeterli izniniz yok.");
  }

  List<Widget> socialMediaButtons() {
    List<Widget> returnList = [];

    if (userDetail.socialMedias.facebook != null &&
        userDetail.socialMedias.facebook != "") {
      returnList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LineAwesomeIcons.facebook),
            Text(
              userDetail.socialMedias.facebook,
              style: styleH5(),
            )
          ],
        ),
      );
    }
    if (userDetail.socialMedias.instagram != null &&
        userDetail.socialMedias.instagram != "") {
      returnList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LineAwesomeIcons.instagram),
            Text(
              userDetail.socialMedias.instagram,
              style: styleH5(),
            )
          ],
        ),
      );
    }
    if (userDetail.socialMedias.pinterest != null &&
        userDetail.socialMedias.pinterest != "") {
      returnList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LineAwesomeIcons.pinterest),
            Text(
              userDetail.socialMedias.pinterest,
              style: styleH5(),
            )
          ],
        ),
      );
    }
    if (userDetail.socialMedias.twitter != null &&
        userDetail.socialMedias.twitter != "") {
      returnList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LineAwesomeIcons.twitter),
            Text(
              userDetail.socialMedias.twitter,
              style: styleH5(),
            )
          ],
        ),
      );
    }
    if (userDetail.socialMedias.website != null &&
        userDetail.socialMedias.website != "") {
      returnList.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LineAwesomeIcons.internet_explorer),
            Text(
              userDetail.socialMedias.website,
              style: styleH5(),
            )
          ],
        ),
      );
    }

    return returnList;
  }

  void _onRefresh() async {
    API().getUserDetail(Login().token, userDetail.id).then((newUserDetail) {
      _refreshController.refreshCompleted();
      setState(() {
        // Future.delayed(Duration(milliseconds: 500));
        userDetail = newUserDetail;
      });
    });
  }
}
