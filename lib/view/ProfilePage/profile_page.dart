import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/utils/footer.dart';
import '/view/utils/snackbar.dart';
import '/model/profile_detail.dart';
import '/view/utils/show_image.dart';
import 'utils/account_info_card.dart';
import '/view/utils/upload_image.dart';
import 'utils/change_password_card.dart';
import '/view/utils/progressIndicator.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<bool, dynamic>> profileFuture;

  final List<String> gender = [
    "Kadın",
    "Erkek",
    "Belirtilmemiş",
  ];
  
  @override
  void initState() {
    super.initState();
    profileFuture = API().getProfile(Login().token);
  }

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
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 35,
                                    vertical: 10,
                                  ),
                                  child: GestureDetector(
                                    child: CachedNetworkImage(
                                      imageUrl: ProfileDetail().image,
                                      imageBuilder: (context, provider) =>
                                          CircleAvatar(
                                        radius: Get.width * 0.15,
                                        foregroundImage: provider,
                                      ),
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: kPrimaryColor,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    onTap: () {
                                      Get.dialog(showImage(
                                          imageUrl: ProfileDetail().image));
                                    },
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: InkWell(
                                    child: Container(
                                      width: 37,
                                      height: 37,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.edit),
                                    ),
                                    onTap: () async {
                                      var image = await selectImage();

                                      if (image != null) {
                                        print((image as XFile).path);
                                        var result = await API().uploadImage(
                                          Login().token,
                                          (image as XFile).path,
                                          "profile-image",
                                        );
                                        var newProfileResult = await API()
                                            .getProfile(Login().token);

                                        setState(() {
                                          profileFuture =
                                              Future.value(newProfileResult);
                                        });
                                        if (result) {
                                          successSnackbar(
                                              "Profil resminiz başarıyla güncellenmiştir.");
                                        } else {
                                          failureSnackbar(
                                              "Profil resminiz güncellenirken bir sorun yaşandı.");
                                        }
                                      } else {
                                        normalSnackbar(
                                            "Herhangi bir resim seçilmedi.");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${ProfileDetail().name} ${ProfileDetail().surname}",
                                  style: styleH3().copyWith(),
                                ),
                                ProfileDetail().emailVerified
                                    ? Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                      )
                                    : Container(),
                              ],
                            ),
                            Html(
                              data: "<p>${ProfileDetail().description}<p>",
                              style: {
                                "p": Style(
                                  fontSize: FontSize.larger,
                                  color: kTextColor,
                                  // fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.center,
                                ),
                              },
                            ),
                            // TextSpan(
                            //   text: "Toplam Başarılı Görüşme Sayısı: ",
                            //   style: styleH5(),
                            //   children: [
                            //     TextSpan(
                            //       text: "0",
                            //       style: styleH4(
                            //           color: kBlackColor,
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //   ],
                            // )
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
                                      color: kWhiteColor,
                                      fontWeight: FontWeight.w400),
                                ),
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
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                border: Border.all(
                                  width: 1,
                                  color: kTextColor,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("HAKKINDA",
                                      style:
                                          styleH4(fontWeight: FontWeight.w600)),
                                  Text.rich(
                                    TextSpan(
                                      text: "Cinsiyet: ",
                                      children: [
                                        TextSpan(
                                          text: ProfileDetail().gender == null
                                              ? "Belirtilmemiş"
                                              : gender[ProfileDetail().gender],
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
                                          text: ProfileDetail().age,
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
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Fotoğraf Galerisi",
                                          style: styleH2(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 3,
                                      mainAxisSpacing: 3,
                                    ),
                                    itemCount:
                                        ProfileDetail().gallery.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index !=
                                          ProfileDetail().gallery.length) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              showImage(
                                                gallery:
                                                    ProfileDetail().gallery,
                                                galleryIndex: index,
                                              ),
                                            );
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: ProfileDetail()
                                                .gallery[index]
                                                .image,
                                            imageBuilder: (context, provider) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: provider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        );
                                      }
                                      return IconButton(
                                        icon: Icon(
                                          Icons.add_box_rounded,
                                          color: kPrimaryColor,
                                        ),
                                        iconSize: 48,
                                        onPressed: () async {
                                          var image = await selectImage();

                                          if (image != null) {
                                            print((image as XFile).path);
                                            var result =
                                                await API().uploadImage(
                                              Login().token,
                                              (image as XFile).path,
                                              "profile-gallery",
                                            );
                                            var newProfileResult = await API()
                                                .getProfile(Login().token);

                                            setState(() {
                                              profileFuture = Future.value(
                                                  newProfileResult);
                                            });
                                            if (result) {
                                              successSnackbar(
                                                  "Galeri fotoğrafınız başarıyla yüklendi.");
                                            } else {
                                              failureSnackbar(
                                                  "Galeri fotoğrafınız yüklenirken bir sorun yaşandı.");
                                            }
                                          } else {
                                            normalSnackbar(
                                                "Herhangi bir resim seçilmedi.");
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            fixedHeight,
                            AccountInfoCard(),
                            fixedHeight,
                            ChangePasswordCard(),
                            fixedHeight,
                            footer(),
                          ],
                        ),
                      ),
                    ],
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
