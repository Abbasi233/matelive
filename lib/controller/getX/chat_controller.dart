// ignore_for_file: avoid_init_to_null

import 'package:get/get.dart';
import 'package:matelive/model/Chat/message.dart';
import 'package:matelive/model/Chat/room.dart';

import '../../view/utils/snackbar.dart';

class ChatController extends GetxController {
  RxList<Room> rooms = RxList();
  RxList<Message> messages = RxList();
  RxBool messageLoading = false.obs;

  RxInt activeChatId = RxInt(null);

  void onNewMessage(Map<String, dynamic> map) {
    var message = Message.fromJson(map["message"]);
  }

  void showNewMessageSnackbar(Map<String, dynamic> map) {
    var message = Message.fromJson(map);
    newMessageSnackbar(
      "${message.sender.name} ${message.sender.surname}",
      message.message,
      message.sender.image,
    );
  }
}
