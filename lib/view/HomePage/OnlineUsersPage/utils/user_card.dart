import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/constant.dart';
import '/model/user_detail.dart';
import '/view/UserPage/user_page.dart';
import '/view/utils/primaryButton.dart';
import '/controller/getX/Agora/calling_controller.dart';

Widget userCard({UserDetail userDetail, bool online = false}) {
  const double _fixedSize = 40;
  Widget actionButton = online
      ? primaryButton(
          padding: Get.width * 0.1,
          text: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LineAwesomeIcons.phone),
              SizedBox(width: 5),
              Text("Şimdi Ara"),
            ],
          ),
          onPressed: () {
            Get.find<CallingController>().createCall(userDetail);
          },
        )
      : primaryButton(
          padding: Get.width * 0.1,
          text: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LineAwesomeIcons.user),
              SizedBox(width: 5),
              Text("Profile Git"),
            ],
          ),
          onPressed: () {
            Get.to(() => UserDetailPage(userDetail));
          },
        );
  return Card(
    margin: const EdgeInsets.only(bottom: 30),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
    elevation: 4,
    child: InkWell(
      onTap: () {
        Get.to(() => UserDetailPage(userDetail));
      },
      child: Container(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageBuilder: (context, provider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: provider,
                    ),
                  ),
                );
              },
              fit: BoxFit.cover,
              imageUrl: userDetail.image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: kPrimaryColor,
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kBorderRadius),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                    stops: [
                      0.03,
                      0.9
                    ]),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Icon(LineAwesomeIcons.hand_pointing_right_1),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(55, _fixedSize),
                            fixedSize: Size(_fixedSize, _fixedSize),
                            shape: CircleBorder(),
                            primary: kWhiteColor, // <-- Button color
                            onPrimary: kBlackColor, // <-- Splash color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Icon(LineAwesomeIcons.heart),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(55, _fixedSize),
                            fixedSize: Size(_fixedSize, _fixedSize),
                            shape: CircleBorder(),
                            primary: kWhiteColor, // <-- Button color
                            onPrimary: kBlackColor, // <-- Splash color
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Center(
                            child: Icon(LineAwesomeIcons.bookmark),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(55, _fixedSize),
                            fixedSize: Size(_fixedSize, _fixedSize),
                            shape: CircleBorder(),
                            primary: kWhiteColor, // <-- Button color
                            onPrimary: kBlackColor, // <-- Splash color
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${userDetail.name} ${userDetail.surname}",
                            style: styleH2(color: kWhiteColor),
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            userDetail.age,
                            style: styleH4(color: kWhiteColor),
                          ),
                          actionButton,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
