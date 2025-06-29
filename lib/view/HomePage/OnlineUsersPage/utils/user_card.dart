import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/controller/getX/chat_controller.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/view/chats_page/message_page.dart';
import 'package:matelive/view/utils/auto_size_text.dart';
import 'package:matelive/view/utils/snackbar.dart';

import '/constant.dart';
import '/model/user_detail.dart';
import '/view/UserPage/user_page.dart';
import '/view/utils/primaryButton.dart';
import '/controller/getX/Agora/calling_controller.dart';

Widget userCard(
    {UserDetail userDetail,
    bool online = false,
    bool showActionButtons = true}) {
  const double _fixedSize = 40;

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
                ),
              ),
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
                  stops: [0.03, 0.9],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: showActionButtons
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                child: Center(
                                  child: Icon(
                                      LineAwesomeIcons.hand_pointing_right_1),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(55, _fixedSize),
                                  fixedSize: Size(_fixedSize, _fixedSize),
                                  shape: CircleBorder(),
                                  primary: kWhiteColor, // <-- Button color
                                  onPrimary: kBlackColor, // <-- Splash color
                                ),
                                onPressed: () async {
                                  var result = await API().setAction(
                                    Login().token,
                                    {
                                      "type": 4,
                                      "related_user_id": userDetail.id
                                    },
                                  );

                                  if (result.keys.first) {
                                    successSnackbar(result.values.first);
                                  } else {
                                    failureSnackbar(result.values.first);
                                  }
                                },
                              ),
                              ElevatedButton(
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
                                onPressed: () async {
                                  var result = await API().setAction(
                                    Login().token,
                                    {
                                      "type": 3,
                                      "related_user_id": userDetail.id
                                    },
                                  );

                                  if (result.keys.first) {
                                    successSnackbar(result.values.first);
                                  } else {
                                    failureSnackbar(result.values.first);
                                  }
                                },
                              ),
                              ElevatedButton(
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
                                onPressed: () async {
                                  var result = await API().setAction(
                                    Login().token,
                                    {
                                      "type": 2,
                                      "related_user_id": userDetail.id
                                    },
                                  );

                                  if (result.keys.first) {
                                    successSnackbar(result.values.first);
                                  } else {
                                    failureSnackbar(result.values.first);
                                  }
                                },
                              ),
                            ],
                          )
                        : Container(),
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              userDetail.isOnline
                                  ? Expanded(
                                      child: primaryButton(
                                        text: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(LineAwesomeIcons.phone),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: autoSize(
                                                text: "Şimdi Ara",
                                                paddingRight: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Get.find<CallingController>()
                                              .createCall(userDetail);
                                        },
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(width: 10),
                              Expanded(
                                child: primaryButton(
                                  borderColor: Colors.blue,
                                  backgroundColor: Colors.blue,
                                  text: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.message),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Center(
                                          child: autoSize(
                                            text: "Mesaj Gönder",
                                            paddingRight: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    var result = Get.find<ChatController>()
                                        .getExistRoomId(userDetail.id);

                                    Get.to(() => MessagePage(
                                          roomId: result,
                                          receiver: userDetail,
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
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
