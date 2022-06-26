import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matelive/model/Chat/message.dart';
import 'package:matelive/model/Chat/room.dart';
import 'package:matelive/model/paged_response.dart';
import 'package:matelive/view/chats_page/message_page.dart';
import 'package:matelive/view/chats_page/utils/image_preview.dart';

import '../api.dart';
import '../../model/login.dart';
import '../../view/utils/snackbar.dart';
import '../../view/utils/upload_image.dart';

class ChatController extends GetxController {
  RxList<Room> rooms = RxList();
  RxList<Message> messages = RxList();

  RxBool hasNewMessage = false.obs;
  RxBool messageLoading = false.obs;
  PagedResponse messageMetadata = PagedResponse();

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

  Future<void> loadMessages(int roomId) async {
    messageLoading.value = true;
    API().getMessages(Login().token, roomId).then((value) {
      if (value.keys.first) {
        messageMetadata = value.values.first as PagedResponse;

        if (messageMetadata.data != null) {
          messages.value = messageMetadata.data as List<Message>;
        } else {
          messages.value = <Message>[];
        }
        messageLoading.value = false;
      }
    });
  }

  void onNewMessage(Map<String, dynamic> map) {
    var message = Message.fromJson(map);

    if (activeChatId.value == message.roomId) {
      messages.insert(0, message);
    } else {
      hasNewMessage.value = true;
    }

    changeRoomsOrder(
      message: message,
      senderId: message.senderId,
    );
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

  int getExistRoomId(int receiverId) {
    return rooms.firstWhereOrNull((room) => room.user.id == receiverId)?.id ??
        0;
  }

  void changeRoomsOrder({
    Message message,
    int senderId,
  }) {
    var roomId = getExistRoomId(senderId);
    if (roomId != 0) {
      rooms.removeWhere((room) => room.id == roomId);
    }

    rooms.insert(
      0,
      Room(
        id: message.roomId,
        lastMessage: message.message,
        lastMessageSentBy: message.senderId,
        user: message.sender,
        updatedAt: message.updatedAt,
        isRead: {
          message.senderId.toString(): true,
          message.receiverId.toString(): false,
        },
      ),
    );
  }

  void changeRoomIsRead() {
    var room = rooms.firstWhere((room) => room.id == activeChatId.value);
    room.isRead["${Login().user.id}"] = true;
    rooms.refresh();
  }

  void setHasNewMessage() {
    var userId = Login().user.id;
    var result = rooms.firstWhere((room) => room.isRead["$userId"] == false,
        orElse: () => null);
    if (result == null) {
      hasNewMessage.value = false;
    }
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

  Future<Map<bool, String>> deleteMessage(int id) async {
    var result = await API().deleteMessage(Login().token, id);
    print(result);
    return result;
  }
}
