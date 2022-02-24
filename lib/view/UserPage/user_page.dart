import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
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
                          imageBuilder: (context, provider) => CircleAvatar(
                            radius: Get.width * 0.15,
                            foregroundImage: provider,
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: kPrimaryColor,
                          )),
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
                          Text(
                            "${userDetail.name} ${userDetail.surname}",
                            style: styleH3().copyWith(),
                          ),
                          userDetail.emailVerified
                              ? Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                )
                              : Container(),
                        ],
                      ),
                      Html(
                        data: "<p>${userDetail.description}<p>",
                        style: {
                          "p": Style(
                            fontSize: FontSize.larger,
                            color: kTextColor,
                            // fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        },
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: userDetail.isOnline
                                ? kPrimaryColor
                                : kTextColor,
                            borderRadius: BorderRadius.circular(30)),
                        width: Get.width * 0.50,
                        child: InkWell(
                          child: Center(
                            child: AutoSizeText(
                              userDetail.id == ProfileDetail().id
                                  ? "Kendi Profiliniz"
                                  : userDetail.isOnline
                                      ? "Şu An Çevrimiçi"
                                      : "Şu An Çevrimdışı",
                              style: styleH4(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          onTap: () {
                            if (userDetail.isOnline) {
                              callingController.createCall(userDetail);
                            }
                          },
                        ),
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
                            var dialogResult = await Get.dialog(ReportDialog());

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
                            var dialogResult = await Get.dialog(BlockDialog());

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
                                userDetail.userPermissions.description == false
                            ? Center(
                                child: notHavePermission(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                            image: provider, fit: BoxFit.cover),
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
                                  textAlign: TextAlign.center),
                            ),
                ],
              ),
            ),
            fixedHeight,
            footer(),
          ],
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
}
