import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:matelive/controller/getX/Agora/calling_controller.dart';
import 'package:matelive/controller/getX/chat_controller.dart';
import 'package:matelive/view/LandingPage/controller.dart';
import 'package:matelive/view/utils/snackbar.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherController {
  PusherClient _pusher;

  var _chatController = Get.find<ChatController>();
  var _callingController = Get.find<CallingController>();
  var _landingPageController = Get.find<LandingPageController>();

  PusherController(String token) {
    PusherOptions options = PusherOptions(
      wsPort: 6001,
      cluster: "eu",
      auth: PusherAuth(
        "https://matelive.net/api/broadcasting/auth",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
    _pusher = PusherClient("4247212f2d5fe9f991e6", options);

    _pusher.onConnectionStateChange((state) {
      log("previousState: ${state.previousState}, currentState: ${state.currentState}");

      switch (state.currentState) {
        case "DISCONNECTED":
        case "disconnected":
          _landingPageController.pusherConStates.value = ConStates.DISCONNECTED;
          break;
        case "CONNECTING":
        case "connecting":
          _landingPageController.pusherConStates.value = ConStates.CONNECTING;
          break;
        case "CONNECTED":
        case "connected":
          _landingPageController.pusherConStates.value = ConStates.CONNECTED;
          break;
        default:
      }
    });

    _pusher.onConnectionError((error) {
      log("error: ${error.exception}");
    });
    _pusher.connect();
  }

  void listenCall(int userId) {
    _pusher.subscribe("private-user.call.$userId").bind(
      "App\\Events\\callUser",
      (PusherEvent event) {
        var data = jsonDecode(event.data);
        switch (data["type"]) {
          case "calling":
            _callingController.callingByRequestStatus(data);
            break;
          case "action":
            _callingController.actionByRequestStatus(
                data["webCallDetails"]["status"].toString(),
                data["actionerDetails"]);
            break;
        }
      },
    );
  }

  void listenChat(int userId) {
    _pusher.subscribe("presence-chat.$userId").bind(
      "App\\Events\\chatMessage",
      (PusherEvent event) {
        var map = jsonDecode(event.data)["message"];
        int activeChatId = _chatController.activeChatId.value;

        if (Get.currentRoute != "/RoomsPage" &&
            activeChatId != map["room_id"]) {
          _chatController.showNewMessageSnackbar(map);
        } else {}

        // var message = Message.fromJson(map["message"]);
        // messageList.insert(0, message);
        // streamController.sink.add([message]);
      },
    );
  }
}
