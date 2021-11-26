import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/model/Call/call_result.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/CallPage/call_page.dart';
import 'package:matelive/view/utils/snackbar.dart';
import 'package:matelive/controller/api.dart';

class CallingController extends GetxController {
  RxBool speakerState = true.obs;
  RxBool callingState = false.obs;
  RxBool microphoneState = true.obs;
  Rx<Stopwatch> stopwatch = Stopwatch().obs;

  bool isCurrentCallerMe = false;
  CallResult callResult = CallResult();

  IconData get getCallingIcon =>
      callingState.value ? Icons.call : Icons.call_end;

  IconData get getMicrophoneIcon =>
      microphoneState.value ? Icons.mic_rounded : Icons.mic_off_rounded;

  IconData get getSpeakerIcon =>
      speakerState.value ? Icons.volume_up : Icons.volume_off;

  Map<String, String> callStatus = {
    'waiting': "1",
    'accepted': "2",
    'started': "3",
    'ended': "4",
    'declined_by_caller': "5",
    'declined_by_answerer': "6",
    'not_answered': "7",
  };

  Map<String, int> endReasons = {
    'by_button': 1,
    'user_left': 2,
    'user_credit': 3,
    'user_credit_low': 4
  };

  void callingByRequestStatus(dynamic data) {
    UserDetail userDetail = UserDetail.fromJson(data["callerDetails"]);
    Get.to(() => CallPage(userDetail));
  }

  void actionByRequestStatus(String status, dynamic actionerDetails) {
    if (status == callStatus["accepted"]) {
      stopwatch.value.start();
      successSnackbar("Birazdan Yönlendirileceksiniz");
    } else if (status == callStatus["declined_by_caller"]) {
      Get.back();
      failureSnackbar(
          "Arama ${actionerDetails['name']} tarafından iptal edilmiştir.");
    } else if (status == callStatus["declined_by_answerer"]) {
      Get.back();
      failureSnackbar(
          "Arama ${actionerDetails['name']} tarafından reddedilmiştir.");
    } else if (status == callStatus["not_answered"]) {
      if (isCurrentCallerMe) {
        Get.back();
        failureSnackbar(
            "Aramanız herhangi bir cevap alınmadığı için iptal edilmiştir.");
      } else {
        Get.back();
        failureSnackbar(
            "Gelen aramaya cevap vermediğiniz için arama iptal edilmiştir.");
      }
    }
    isCurrentCallerMe = false;
  }

  void finishCall(String endReason, int duration) async {
    var finishCallBody = {
      "reasoner_id": ProfileDetail().id,
      "end_reason": endReasons[endReason],
      "duration": duration,
    };

    var apiResult = await API().finishCall(
      Login().token,
      callResult.webcall.id,
      finishCallBody,
    );

    if (apiResult.keys.first) {
      Get.back();
    } else {
      Get.back();
      failureSnackbar(apiResult.values.first);
    }
  }
}
