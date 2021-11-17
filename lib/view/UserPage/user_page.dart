import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/Agora/call_page.dart';
import 'package:matelive/view/utils/show_image.dart';
import 'package:matelive/view/utils/appBar.dart';
import 'package:matelive/view/utils/footer.dart';
import 'package:matelive/view/utils/primaryButton.dart';
import 'package:matelive/view/utils/progressIndicator.dart';

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

  @override
  void initState() {
    super.initState();
    // _future = API().getUserDetail(Login().token, userDetail.id);
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
              height: Get.height * 0.4,
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
                      Get.dialog(showImage(userDetail.image));
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
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    width: Get.width * 0.50,
                    child: Center(
                        child: AutoSizeText(
                      "Şu An Çevrimiçi",
                      style: styleH4(
                          color: kWhiteColor, fontWeight: FontWeight.w400),
                    )),
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
                  Text(
                    "Fotoğraf Galerisi",
                    style: styleH2(),
                  ),
                  Text(
                    "Kullanıcı henüz bir görsel paylaşmadı.",
                    style: styleH4(),
                  ),
                  fixedHeight,
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
                  )
                ],
              ),
            ),
            footer(),
          ],
        ),
        // FutureBuilder(
        //     future: _future,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return ListView(
        //           children: [
        //             Container(
        //               height: Get.height * 0.4,
        //               color: Colors.grey[300],
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                 children: [
        //                   CircleAvatar(
        //                     radius: 50,
        //                     foregroundImage:
        //                         Image.asset("assets/images/avatar.png").image,
        //                   ),
        //                   Text.rich(
        //                     TextSpan(
        //                       text: "widget.username",
        //                       style: styleH3().copyWith(),
        //                       children: [
        //                         TextSpan(
        //                           text: " (Onaylanmış Kullanıcı)\n",
        //                           style: styleH5(color: Colors.green),
        //                         ),
        //                         TextSpan(
        //                           text: "Toplam Başarılı Görüşme Sayısı: ",
        //                           style: styleH5(),
        //                           children: [
        //                             TextSpan(
        //                               text: "0",
        //                               style: styleH4(
        //                                   color: kBlackColor,
        //                                   fontWeight: FontWeight.w600),
        //                             ),
        //                           ],
        //                         )
        //                       ],
        //                     ),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                   primaryButton(
        //                     text: Text("Şu An Çevrimiçi"),
        //                     onPressed: () {
        //                       // Get.to(() => CallPage(widget.username));
        //                     },
        //                     padding: Get.width * 0.20,
        //                     // disabled: true,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             fixedHeight,
        //             Container(
        //               padding: const EdgeInsets.symmetric(horizontal: 20),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     "Fotoğraf Galerisi",
        //                     style: styleH2(),
        //                   ),
        //                   Text(
        //                     "Kullanıcı henüz bir görsel paylaşmadı.",
        //                     style: styleH4(),
        //                   ),
        //                   fixedHeight,
        //                   Container(
        //                     height: 150,
        //                     padding: const EdgeInsets.all(20),
        //                     decoration: BoxDecoration(
        //                       borderRadius:
        //                           BorderRadius.circular(kBorderRadius),
        //                       border: Border.all(
        //                         width: 1,
        //                         color: kTextColor,
        //                       ),
        //                     ),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                       crossAxisAlignment: CrossAxisAlignment.stretch,
        //                       children: [
        //                         Text("HAKKINDA",
        //                             style:
        //                                 styleH4(fontWeight: FontWeight.w600)),
        //                         Text.rich(
        //                           TextSpan(
        //                             text: "Cinsiyet: ",
        //                             children: [
        //                               TextSpan(
        //                                   text: "Belirtilmemiş",
        //                                   style: styleH4(
        //                                       fontWeight: FontWeight.w600))
        //                             ],
        //                           ),
        //                           style: styleH4(),
        //                         ),
        //                         Text.rich(
        //                           TextSpan(
        //                             text: "Yaş: ",
        //                             children: [
        //                               TextSpan(
        //                                   text: "Belirtilmemiş",
        //                                   style: styleH4(
        //                                       fontWeight: FontWeight.w600))
        //                             ],
        //                           ),
        //                           style: styleH4(),
        //                         ),
        //                       ],
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             footer(),
        //           ],
        //         );
        //         }
        //         return showProgressIndicator(context);
        //       }),
      ),
    );
  }
}
