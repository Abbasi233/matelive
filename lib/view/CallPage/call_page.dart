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
import 'package:stop_watch_timer/stop_watch_timer.dart';

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

class _CallPageState extends State<CallPage>
    with SingleTickerProviderStateMixin {
  // CUSTOM ANİMASYON İÇİN SO'DAKİ BU CEVABI KULLANABİLİRSİN
  // https://stackoverflow.com/questions/53854589/create-very-custom-animations-in-flutter

  // AnimationController _controller;
  // Animation<double> _animation;

  var callingController = Get.put(CallingController());

  RtcEngine engine;
  UserDetail userDetail;
  RtcEngineContext rtcContext;

  bool value = true;

  PusherClient pusher;
  String callTime = "Aranıyor...";

  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    userDetail = widget.userDetail;

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    // _controller = AnimationController(
    //   duration: const Duration(milliseconds: 2000),
    //   vsync: this,
    // );
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.linear,
    // );
  }

  @override
  void dispose() async {
    super.dispose();
    // engine.destroy();
    // _controller.dispose();
    await _stopWatchTimer.dispose();
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: _stopWatchTimer.rawTime.value,
                          builder: (context, snap) {
                            final value = snap.data;
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      StopWatchTimer.getDisplayTime(
                                        value,
                                        hours: false,
                                        milliSecond: false,
                                      ).toString(),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      // Obx(() => Text(
                      //     callingController.stopwatch.value.isRunning
                      //         ? formatElapsedTime(
                      //             callingController.stopwatch.value.elapsed)
                      //         : callTime,
                      //     style: styleH4())),
                    ],
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: userDetail.image,
                  imageBuilder: (context, provider) => CircleAvatar(
                    radius: Get.width / 3,
                    foregroundImage: provider,
                  ),
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
                // Animasyon için bu formülü kullanabilirsin
                // Transform.rotate(
                //   angle: telefonuDondur ? math.pi / 2 : math.pi,
                //   child:
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    color: kWhiteColor,
                    icon: Icon(Icons.call),
                    onPressed: () {
                      // await engine.joinChannel(Token, 'matelive_mobile', null, 0);
                      // print("Joined!");

                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      print(_stopWatchTimer.secondTime.value);
                      // callingController.finishCall(
                      //   "by_button",
                      //   callingController.stopwatch.elapsed.inSeconds,
                      // );
                      // callingController.stopwatch.reset();
                    },
                  ),
                ),

                // ),
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

  String formatElapsedTime(Duration value) {
    String returnValue = "";
    var splittedValue = value.toString().split(".")[0];

    if (splittedValue[0] != "0") {
      returnValue += splittedValue[0];
    }
    returnValue += "${splittedValue[1]}:${splittedValue[2]}";
    return returnValue;
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
