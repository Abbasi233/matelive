import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/utils/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_client/pusher_client.dart';

import '/constant.dart';
import '/view/utils/primaryButton.dart';
import '/controller/getX/Agora/calling_controller.dart';

const APP_ID = "5c3d66930723436bb6592ece66f8f69e";

class CallPage extends StatefulWidget {
  final UserDetail userDetail;
  CallPage(this.userDetail);
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  var callingController = Get.put(CallingController());

  RtcEngine engine;
  UserDetail userDetail;
  RtcEngineContext rtcContext;

  PusherClient pusher;
  String callTime = "Aranıyor...";

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    userDetail = widget.userDetail;
  }

  @override
  void dispose() {
    // engine.destroy();
    super.dispose();
  }

  bool telefonuDondur = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Agora Audio'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${userDetail.name} ${userDetail.surname}",
                        style: styleH1(),
                      ),
                      Text(callTime, style: styleH4()),
                    ],
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: userDetail.image,
                  imageBuilder: (context, provider) => CircleAvatar(
                    radius: Get.width / 3,
                    foregroundImage: provider,
                  ),

                  //  Container(
                  //     decoration: BoxDecoration(
                  //       image:
                  //           DecorationImage(image: , fit: BoxFit.cover),
                  //     ),
                  //   ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: kPrimaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => IconButton(
                    iconSize: 36,
                    icon: Icon(callingController.getSpeakerIcon),
                    onPressed: () {
                      engine.setEnableSpeakerphone(
                          !callingController.speakerState.value);
                    },
                  ),
                ),
                Transform.rotate(
                  angle: telefonuDondur ? math.pi / 2 : math.pi,
                  child: IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      setState(() => telefonuDondur = !telefonuDondur);
                      // await engine.joinChannel(Token, 'matelive_mobile', null, 0);
                      // print("Joined!");
                      callingController.callingState.value =
                          !callingController.callingState.value;
                    },
                  ),
                ),
                Obx(
                  () => IconButton(
                    iconSize: 36,
                    icon: Icon(callingController.getMicrophoneIcon),
                    onPressed: () {
                      engine.enableLocalAudio(
                          !callingController.microphoneState.value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initPlatformState() async {
    await [Permission.microphone].request();
    rtcContext = RtcEngineContext(APP_ID);
    engine = await RtcEngine.createWithContext(rtcContext);

    engine.setEventHandler(
      RtcEngineEventHandler(
        activeSpeaker: (i) {
          print("Aktive Speaker: $i");
        },
        microphoneEnabled: (enable) {
          print(enable);
          callingController.microphoneState.value = enable;
        },
        warning: (warningCode) {
          print(warningCode.toString());
        },
        rtcStats: (stats) {
          print("Status: ${stats.userCount}");
        },
        connectionStateChanged: (state, reason) {
          print(
              "Connection Changed : ${state.toString()}, ${reason.toString()}");
        },
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess $channel $uid');
          Get.snackbar(
              "Bağlantı Başarılı", "Artık görüşmeye başlayabilirsiniz.");
          // setState(() {
          //   _joined = true;
          // });
        },
        userJoined: (int uid, int elapsed) {
          print('userJoined $uid');
          // setState(() {
          //   _remoteUid = uid;
          // });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('userOffline $uid');
          // setState(() {
          //   _remoteUid = 0;
          // });
        },
      ),
    );
  }
}
