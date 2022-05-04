import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '/model/login.dart';
import '/controller/api.dart';
import '/model/user_detail.dart';
import '/model/Call/webcall.dart';
import '/view/utils/snackbar.dart';
import '/model/profile_detail.dart';
import '/model/Call/call_result.dart';
import '/view/CallPage/call_page.dart';

class CallingController extends GetxController {
  RxBool speakerState = false.obs;
  RxBool callingState = false.obs;
  RxBool microphoneState = true.obs;

  IconData get getCallingIcon =>
      callingState.value ? Icons.call : Icons.call_end;

  IconData get getMicrophoneIcon =>
      microphoneState.value ? Icons.mic_rounded : Icons.mic_off_rounded;

  IconData get getSpeakerIcon =>
      speakerState.value ? Icons.volume_up : Icons.volume_off;

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  final String callingSound = "sounds/calling.mp3";
  final String receivingSound = "sounds/receiving.mp3";

  String agoraToken = "";
  int remainingCredit = 0;
  bool isCallerMe = false;
  bool screenClosed = false;
  CallResult callResult = CallResult();
  StopWatchTimer stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  int sayac = 0;
  StreamSubscription<int> listenSeconds;

  Map<String, String> callStatus = {
    'waiting': "1",
    'accepted': "2",
    'started': "3",
    'ended': "4",
    'declined_by_caller': "5",
    'declined_by_answerer': "6",
    'not_answered': "7",
  };

  Map<String, int> actions = {
    'accepted': 2,
    'declined_by_caller': 5,
    'declined_by_answerer': 6,
    'not_answered': 7,
  };

  Map<String, int> endReasons = {
    'by_button': 1,
    'user_left': 2,
    'user_credit': 3,
    'user_credit_low': 4
  };

  void callingByRequestStatus(dynamic data) {
    isCallerMe = false;
    callResult = CallResult(
      message: data["message"],
      webcall: WebCall.fromJson(data["webCallDetails"]),
    );

    UserDetail userDetail = UserDetail.fromJson(data["callerDetails"]);
    Get.to(() => CallPage(userDetail));
    // playSound(receivingSound);
  }

  void actionByRequestStatus(String status, dynamic actionerDetails) async {
    await stopSound();

    if (status == callStatus["accepted"]) {
      log("isCallerMe $isCallerMe");
      if (isCallerMe) {
        log("LISTEN SECONDS STATE: ${listenSeconds.toString()}");
        listenSeconds =
            stopWatchTimer.secondTime.listen(calculateRemainingTime);
      }
      stopWatchTimer.onExecute.add(StopWatchExecute.start);
    } else if (status == callStatus["declined_by_caller"]) {
      resetTimer();

      if (screenClosed) {
        screenClosed = false;
        Get.back(); // for closing screen close dialog
      }
      Get.back();

      if (isCallerMe) {
        failureSnackbar("Aramayı iptal ettiniz.");
      } else {
        failureSnackbar(
            "Arama ${actionerDetails['name']} tarafından iptal edilmiştir.");
      }
    } else if (status == callStatus["declined_by_answerer"]) {
      resetTimer();

      if (screenClosed) {
        screenClosed = false;
        Get.back(); // for closing screen close dialog
      }
      Get.back();

      if (isCallerMe) {
        failureSnackbar(
            "Arama ${actionerDetails['name']} tarafından reddedilmiştir.");
      } else {
        failureSnackbar("Aramayı reddettiniz.");
      }
    } else if (status == callStatus["not_answered"]) {
      if (isCallerMe) {
        Get.back();
        failureSnackbar(
            "Aramanız herhangi bir cevap alınmadığı için iptal edilmiştir.");
      } else {
        Get.back();
        failureSnackbar(
            "Gelen aramaya cevap vermediğiniz için arama iptal edilmiştir.");
      }
    }
  }

  void createCall(UserDetail userDetail) async {
    var result = await Get.dialog(
      AlertDialog(
        title: Text("Arama İşlemi"),
        content: Text(
            "${userDetail.name} ${userDetail.surname} isimli kullanıcıyı aramak istediğinize emin misiniz?"),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: true), child: Text("Evet")),
          TextButton(
              onPressed: () => Get.back(result: false), child: Text("Hayır")),
        ],
      ),
    );

    if (result) {
      var apiResult = await API().createCall(Login().token, userDetail.id);

      if (apiResult.keys.first) {
        CallResult call = apiResult.values.first as CallResult;
        var tokenResult = await API().generateToken(
          Login().token,
          {"channel_name": call.webcall.channelName, "role": 2},
        );

        if (tokenResult.keys.first) {
          isCallerMe = true;
          callResult = apiResult.values.first;
          agoraToken = tokenResult.values.first;
          Get.to(() => CallPage(userDetail));
          playSound(callingSound);
        } else {
          failureSnackbar(tokenResult.values.first);
        }
      } else {
        failureSnackbar(apiResult.values.first);
      }
    }
  }

  Future<void> startCall() async {
    var result = await API().startCall(
      Login().token,
      callResult.webcall.id,
      {"channel_name": callResult.webcall.channelName, "role": 1},
    );
    var tokenResult = await API().generateToken(
      Login().token,
      {"channel_name": callResult.webcall.channelName, "role": 1},
    );

    if (result.keys.first) {
      stopWatchTimer.onExecute.add(StopWatchExecute.start);
      agoraToken = tokenResult.values.first;
    }
  }

  Future<void> acceptCall() async {
    var acceptCallBody = {"action": actions["accepted"]};

    var apiResult = await API().callAction(
      Login().token,
      callResult.webcall.id,
      acceptCallBody,
    );

    if (!apiResult.keys.first) {
      failureSnackbar(apiResult.values.first);
    }
  }

  Future<void> finishCall(int reasonerId, String endReason) async {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);

    if (reasonerId == ProfileDetail().id) {
      var finishCallBody = {
        "reasoner_id": reasonerId,
        "end_reason": endReasons[endReason],
        "duration": stopWatchTimer.secondTime.value,
      };

      var apiResult = await API().finishCall(
        Login().token,
        callResult.webcall.id,
        finishCallBody,
      );

      Get.back();
      if (!apiResult.keys.first) {
        failureSnackbar(apiResult.values.first);
      }
    } else {
      Get.back();
    }

    log("FINISH CALL------");
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    await listenSeconds?.cancel();
  }

  Future<void> declineCall(String action) async {
    var declineCallBody = {"action": actions[action]};

    var apiResult = await API().callAction(
      Login().token,
      callResult.webcall.id,
      declineCallBody,
    );

    if (!apiResult.keys.first) {
      failureSnackbar(apiResult.values.first);
    }
  }

  Future<void> playSound(String file) async {
    audioPlayer = await audioCache.loop(file);
  }

  Future<void> stopSound() async {
    if (audioPlayer.state == PlayerState.PLAYING) {
      await audioPlayer.stop();
    }
  }

  void calculateRemainingTime(int time) async {
    log("Kalan Kredi: $remainingCredit");

    if (remainingCredit > 0) {
      remainingCredit--;
    } else {
      // await listenSeconds?.cancel();
      await finishCall(ProfileDetail().id, "by_button");
    }
  }

  void resetTimer() {
    stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    listenSeconds?.cancel();
  }
}
