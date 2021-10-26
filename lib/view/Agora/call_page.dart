import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;
import '/constant.dart';
import '/view/utils/primaryButton.dart';
import '/controller/getX/Agora/calling_controller.dart';

const APP_ID = "5c3d66930723436bb6592ece66f8f69e";
const Token =
    '0065c3d66930723436bb6592ece66f8f69eIABNiOZRyC7VXGQfKy5qd5KKB69dtfxZDuNb0pUmKB+06IVzL4YAAAAAEABkg7/N21hbYQEAAQDaWFth';

class CallPage extends StatefulWidget {
  final String username;
  CallPage(this.username);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage>
    with SingleTickerProviderStateMixin {
  RtcEngine engine;
  RtcEngineContext rtcContext;
  var callingController = Get.put(CallingController());
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    //initPlatformState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 12));
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
                      Text(widget.username, style: styleH1()),
                      Text("Buraya Süre Gelecek", style: styleH4()),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: Get.width / 3,
                  foregroundImage:
                      Image.asset("assets/images/avatar.png").image,
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
                  
                  angle: telefonuDondur ? math.pi/2:math.pi,
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

                // AnimatedContainer(
                //   duration: Duration(
                //     seconds: 2
                //   ),
                //    transform: Transform.rotate(
                     
                //     angle: telefonuDondur ? math.pi/2:math.pi
                    
                      
                //    ).transform,
                //     child: IconButton(
                //       icon: Icon(Icons.call),
                //       onPressed: () {
                //         setState(() => telefonuDondur = !telefonuDondur);
                //         _controller.forward();
                //         print(math.pi/4);
                //         // await engine.joinChannel(Token, 'matelive_mobile', null, 0);
                //         // print("Joined!");
                //         callingController.callingState.value =
                //             !callingController.callingState.value;
                //       },
                //     )),
                //  Obx(
                // () => AnimatedContainer(
                //   curve: Curves.fastOutSlowIn,
                //   duration: Duration(milliseconds: 500),
                //   child:neydi la buradaki basma değişkeni
                //       IconButton(
                //           icon: Icon(Icons.call),
                //           onPressed: () {
                //             // await engine.joinChannel(Token, 'matelive_mobile', null, 0);
                //             // print("Joined!");
                //             callingController.callingState.value =
                //                 !callingController.callingState.value;
                //           },
                //         )

                //   // Container(
                //   //   width: 75,
                //   //   height: 75,
                //   //   decoration: BoxDecoration(
                //   //     color: kPrimaryColor,
                //   //     shape: BoxShape.circle,
                //   //   ),
                //   //   child: InkWell(
                //   //     onTap: () {
                //   //       // await engine.joinChannel(Token, 'matelive_mobile', null, 0);
                //   //       // print("Joined!");
                //   //       callingController.callingState.value =
                //   //           !callingController.callingState.value;
                //   //     },
                //   //     child: callingController.callingState.value
                //   //         ? Icon(Icons.call, color: kWhiteColor)
                //   //         : Icon(Icons.call_end, color: kWhiteColor),
                //   //   ),
                //   // ),
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
