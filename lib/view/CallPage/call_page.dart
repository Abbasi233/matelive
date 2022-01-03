import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:matelive/view/CallPage/utils/screen_off.dart';
import 'package:matelive/view/utils/snackbar.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/constant.dart';
import '/model/user_detail.dart';
import '/model/profile_detail.dart';
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

  PusherClient pusher;
  UserDetail userDetail;

  RxBool callAccepted;

  StreamSubscription<dynamic> _proximityStreamSubscription;

  Timer timeout;

  @override
  void initState() {
    super.initState();
    callAccepted = false.obs;
    userDetail = widget.userDetail;

    initAgora();
    listenSensor();

    if (callingController.isCallerMe) {
      timeout = Timer(Duration(seconds: 10), () {
        if (!callingController.stopWatchTimer.isRunning) {
          callingController.declineCall("not_answered");
        }
      });
    }
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
    timeout?.cancel();
    await engine?.leaveChannel();
    await engine?.destroy();
    _proximityStreamSubscription.cancel();

    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height / 5,
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
                          stream: callingController.stopWatchTimer.rawTime,
                          initialData:
                              callingController.stopWatchTimer.rawTime.value,
                          builder: (context, snapshot) {
                            final value = snapshot.data;
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(
                                      value == 0
                                          ? callingController.isCallerMe
                                              ? "Aranıyor..."
                                              : "Sizi Arıyor"
                                          : StopWatchTimer.getDisplayTime(
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
          Obx(
            () => callingController.isCallerMe || callAccepted.value
                ? onConversationButtons()
                : onCallReceiveButtons(),
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

  Future<void> initAgora() async {
    await [Permission.microphone].request();
    try {
      engine = await RtcEngine.createWithContext(RtcEngineContext(APP_ID));

      await engine.enableAudio();
      await engine.setChannelProfile(ChannelProfile.Communication);

      engine.setEventHandler(
        RtcEngineEventHandler(
          activeSpeaker: (i) {
            log("Aktive Speaker: $i");
          },
          microphoneEnabled: (enable) {
            log("Mikrofon: " + enable.toString());
            callingController.microphoneState.value = enable;
          },
          warning: (warningCode) {
            print(warningCode.toString());
          },
          rtcStats: (stats) {
            log("User Count: ${stats.userCount}");
          },
          connectionStateChanged: (state, reason) {
            log("Connection Changed : ${state.toString()}, ${reason.toString()}");
          },
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            log('joinChannelSuccess $channel $uid');
            // Get.snackbar(
            //     "Bağlantı Başarılı", "Artık görüşmeye başlayabilirsiniz.");
          },
          userJoined: (int uid, int elapsed) {
            log('userJoined $uid');
          },
          userOffline: (int uid, UserOfflineReason reason) {
            log('userOffline $uid');
            callingController.finishCall(uid, "user_left");
          },
          error: (error) {
            log("ERROR: $error", name: "AGORA");
          },
        ),
      );

      if (callingController.isCallerMe) {
        await joinChannel();
      }
    } catch (e) {
      print(e);
      failureSnackbar(e.toString());
    }
  }

  Future<void> joinChannel() async {
    await engine
        .joinChannel(
      callingController.agoraToken,
      callingController.callResult.webcall.channelName,
      null,
      ProfileDetail().id,
      ChannelMediaOptions(autoSubscribeAudio: true, publishLocalAudio: true),
    )
        .then((value) async {
      log("VOLUME : " +
          (await engine.getAudioMixingPublishVolume()).toString());
    });
  }

  Widget onCallReceiveButtons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          primaryButton(
            text: Row(
              children: [
                Icon(Icons.call),
                SizedBox(width: 5),
                Text("Kabul Et"),
              ],
            ),
            onPressed: () async {
              await callingController.startCall();
              await callingController.acceptCall();
              await joinChannel();
              callAccepted.value = true;
            },
            backgroundColor: kGreenColor,
            borderColor: kGreenColor,
            height: 70,
          ),
          primaryButton(
            text: Row(
              children: [
                Icon(Icons.call_end),
                SizedBox(width: 5),
                Text("Reddet"),
              ],
            ),
            onPressed: () {
              callingController.declineCall("declined_by_answerer");
            },
            height: 70,
          ),
        ],
      ),
    );
  }

  Widget onConversationButtons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            iconSize: 36,
            icon: Icon(callingController.getSpeakerIcon),
            onPressed: () async {
              await engine
                  .setEnableSpeakerphone(!callingController.speakerState.value);
              callingController
                  .speakerState(!callingController.speakerState.value);
            },
          ),
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
                var callStarted = callingController.stopWatchTimer.isRunning;

                if (callStarted) {
                  callingController.finishCall(ProfileDetail().id, "by_button");
                } else {
                  callingController.declineCall("declined_by_caller");
                }
              },
            ),
          ),
          IconButton(
            iconSize: 36,
            icon: Icon(callingController.getMicrophoneIcon),
            onPressed: () {
              engine.enableLocalAudio(!callingController.microphoneState.value);
              callingController
                  .microphoneState(!callingController.microphoneState.value);
            },
          ),
        ],
      ),
    );
  }

  Future<void> listenSensor() async {
    _proximityStreamSubscription =
        ProximitySensor.events.listen((int event) async {
      print(event);
      if (event > 0) {
        if (!callingController.screenClosed) {
          Get.dialog(ScreenOff());
          callingController.screenClosed = true;
        }
      } else {
        if (callingController.screenClosed) {
          Get.back();
          callingController.screenClosed = false;
        }
      }
    });
  }
}
