import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/controller/getX/Agora/calling_controller.dart';
import 'package:matelive/model/Call/call_result.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/CallPage/call_page.dart';
import 'package:matelive/view/utils/show_image.dart';
import 'package:matelive/view/utils/appBar.dart';
import 'package:matelive/view/utils/footer.dart';
import 'package:matelive/view/utils/primaryButton.dart';
import 'package:matelive/view/utils/progressIndicator.dart';
import 'package:matelive/view/utils/snackbar.dart';

class UserDetailPage extends StatefulWidget {
  final UserDetail userDetail;
  UserDetailPage(this.userDetail);
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Future<dynamic> _future;
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
              child: Column(
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                        color: userDetail.isOnline ? kPrimaryColor : kTextColor,
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
                              color: kWhiteColor, fontWeight: FontWeight.w400),
                        ),
                      ),
                      onTap: userDetail.isOnline ? createCall : null,
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
                  ),
                  fixedHeight,
                  Text(
                    "Fotoğraf Galerisi",
                    style: styleH2(),
                  ),
                  fixedHeight,
                  userDetail.gallery.isNotEmpty
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
                                imageBuilder: (context, provider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: provider, fit: BoxFit.cover),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
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

  void createCall() async {
    // var result = await Get.dialog(AlertDialog(
    //   title: Text("Arama İşlemi"),
    //   content: Text(
    //       "${userDetail.name} ${userDetail.surname} isimli kullanıcıyı aramak istediğinize emin misiniz?"),
    //   actions: [
    //     TextButton(
    //         onPressed: () => Get.back(result: true), child: Text("Evet")),
    //     TextButton(
    //         onPressed: () => Get.back(result: false), child: Text("Hayır")),
    //   ],
    // ));

    // if (result) {
    //   var apiResult = await API().createCall(Login().token, userDetail.id);

    //   if (apiResult.keys.first) {
    //     callingController.isCurrentCallerMe = true;
    //     callingController.callResult = apiResult.values.first;
    //     Get.to(() => CallPage(userDetail));
    //   } else {
    //     failureSnackbar(apiResult.values.first);
    //   }
    // }

    callingController.stopwatch.value.start();
    Get.to(() => CallPage(userDetail));
  }
}
