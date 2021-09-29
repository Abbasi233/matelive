import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:matelive/view/utils/primaryButton.dart';
import 'package:permission_handler/permission_handler.dart';

const APP_ID = "5c3d66930723436bb6592ece66f8f69e";
const Token =
    '0065c3d66930723436bb6592ece66f8f69eIAAdIk3ZgsHcifavZSAlSxYqW0a3cALtyjTkQciMde2gvIVzL4YAAAAAEAB6IwtS+9dRYQEAAQD511Fh';

class AgoraCall extends StatefulWidget {
  @override
  _AgoraCallState createState() => _AgoraCallState();
}

class _AgoraCallState extends State<AgoraCall> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;
// Create RTC client instance
  RtcEngineContext rtcContext;
  RtcEngine engine;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    engine.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Audio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            primaryButton(
              text: Text("Görüşmeye Başla"),
              onPressed: () async {
                // Join channel with channel name as 123
                await engine.joinChannel(Token, 'matelive_mobile', null, 0);
                print("Joined!");
              },
              padding: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    // Get microphone permission
    await [Permission.microphone].request();
    rtcContext = RtcEngineContext(APP_ID);
    engine = await RtcEngine.createWithContext(rtcContext);

    // Define event handling logic
    engine.setEventHandler(
      RtcEngineEventHandler(
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
