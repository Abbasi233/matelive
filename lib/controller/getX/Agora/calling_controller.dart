import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/model/user_detail.dart';
import 'package:matelive/view/CallPage/call_page.dart';
import 'package:matelive/view/utils/snackbar.dart';

class CallingController extends GetxController {
  RxBool callingState = false.obs;
  RxBool microphoneState = true.obs;
  RxBool speakerState = true.obs;
  bool isCurrentCallerMe = false;

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

  void callingByRequestStatus(dynamic data) {
    UserDetail userDetail = UserDetail.fromJson(data["callerDetails"]);
    Get.to(() => CallPage(userDetail));
  }

  void actionByRequestStatus(String status, dynamic actionerDetails) {
    if (status == callStatus["accepted"]) {
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
}
