import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CallingController extends GetxController {
  RxBool callingState = false.obs;
  RxBool microphoneState = true.obs;
  RxBool speakerState = true.obs;

  IconData get getCallingIcon =>
      callingState.value ? Icons.call : Icons.call_end;

  IconData get getMicrophoneIcon =>
      microphoneState.value ? Icons.mic_rounded : Icons.mic_off_rounded;

  IconData get getSpeakerIcon =>
      speakerState.value ? Icons.volume_up : Icons.volume_off;
}
