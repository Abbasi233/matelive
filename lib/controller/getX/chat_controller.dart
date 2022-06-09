// ignore_for_file: avoid_init_to_null
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matelive/model/Chat/message.dart';
import 'package:matelive/model/Chat/room.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/view/chats_page/message_page.dart';
import 'package:matelive/view/chats_page/utils/image_preview.dart';

import '../../model/login.dart';
import '../../view/utils/snackbar.dart';
import '../../view/utils/upload_image.dart';
import '../api.dart';

class ChatController extends GetxController {
  RxList<Room> rooms = RxList();
  RxList<Message> messages = RxList();
  RxBool messageLoading = false.obs;

  RxInt activeChatId = RxInt(null);
  String imageUrl = "";
  String imageText = "";

  Future<void> loadRooms() async {
    var result = await API().getRooms(Login().token);
    var pagedResponse = result.values.first as PagedResponse;

    if (pagedResponse.data != null) {
      rooms.value = pagedResponse.data as List<Room>;
    } else {
      rooms.value = <Room>[];
    }
  }

  void onNewMessage(Map<String, dynamic> map) {
    var message = Message.fromJson(map);

    if (activeChatId.value == message.roomId) {
      messages.insert(0, message);
    }

    changeRoomsOrder(message: message, userId: message.senderId);
  }

  void showNewMessageSnackbar(Map<String, dynamic> map) {
    var message = Message.fromJson(map);
    newMessageSnackbar(
      "${message.sender.name} ${message.sender.surname}",
      message.message,
      message.sender.image,
      () {
        var result = getExistRoomId(message.senderId);
        Get.to(() => MessagePage(roomId: result, receiver: message.sender));
      },
    );
  }

  int getExistRoomId(int userId) {
    return rooms.firstWhereOrNull((room) => room.user.id == userId)?.id ?? 0;
  }

  void changeRoomsOrder({Message message, int userId}) {
    var roomId = getExistRoomId(userId);
    if (roomId != 0) {
      rooms.removeWhere((room) => room.id == roomId);
    }

    rooms.insert(
      0,
      Room(
        id: message.roomId,
        lastMessage: message.message,
        user: message.sender,
        // createdAt: message.updatedAt,
        updatedAt: message.updatedAt,
        // isRead: message.senderId == Login().user.id ? false : true,
        isRead: true,
      ),
    );
  }

  Future<bool> uploadImage() async {
    var image = await selectImage();

    if (image == null) {
      normalSnackbar("Herhangi bir resim seçilmedi.");
      return false;
    }

    print((image as XFile).path);
    var uploadResult = await API().uploadChatImage(
      Login().token,
      (image as XFile).path,
    );

    if (uploadResult.keys.first == false) {
      normalSnackbar(uploadResult.values.first);
      return false;
    }

    imageUrl = uploadResult.values.first;
    var imageTextResult = await Get.to(() => ChatImagePreview(image));
    if (imageTextResult == null) return false;

    imageText = imageTextResult;
    return true;
  }
}
