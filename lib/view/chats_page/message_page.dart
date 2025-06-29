import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/utils/appBar.dart';
import '/model/user_detail.dart';
import '/model/Chat/message.dart';
import '/view/utils/snackbar.dart';
import '/model/paged_response.dart';
import '/view/utils/show_image.dart';
import '/view/UserPage/user_page.dart';
import '/view/chats_page/utils/methods.dart';
import '/controller/getX/chat_controller.dart';
import '/view/chats_page/utils/delete_message_dialog.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({this.roomId = 0, this.receiver, Key key})
      : super(key: key);
  final UserDetail receiver;
  final int roomId;

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  UserDetail receiver;
  var scrollController = ScrollController();
  var messageController = TextEditingController();
  var chatController = Get.find<ChatController>();

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    receiver = widget.receiver;
    chatController.activeChatId.value = widget.roomId;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => chatController.loadMessages(widget.roomId),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Row(
          children: [
            GestureDetector(
              child: CachedNetworkImage(
                imageUrl: receiver.image,
                imageBuilder: (context, provider) => CircleAvatar(
                  foregroundImage: provider,
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: kPrimaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              onTap: () {
                Get.dialog(showImage(imageUrl: receiver.image));
              },
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => Get.to(() => UserDetailPage(receiver)),
              child: Text(
                "${receiver.name} ${receiver.surname}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (chatController.messageLoading.value) {
                  return Center(child: const CircularProgressIndicator());
                }

                if (chatController.messages.isEmpty) {
                  return Center(
                    child: Text("Henüz bu kişiyle mesajlaşmadınız."),
                  );
                }
                return Scrollbar(
                  child: SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: true,
                    onLoading: _onLoading,
                    primary: false,
                    controller: _refreshController,
                    header: CustomHeader(
                      height: 0,
                      builder: (context, mode) => null,
                    ),
                    footer: customFooter(),
                    physics: BouncingScrollPhysics(),
                    child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      controller: scrollController,
                      itemCount: chatController.messages.length,
                      itemBuilder: (context, i) {
                        var messages = chatController.messages;

                        return Login().user.id == messages[i].senderId
                            ? rightMessage(messages[i])
                            : leftMessage(messages[i]);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25),
                        right: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25),
                        right: Radius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: "Mesaj Giriniz...",
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                            splashRadius: 24,
                            onPressed: sendImage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: sendMessage,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String printTime(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String time =
        "${twoDigits(dateTime.add(const Duration(hours: 3)).hour)}:${twoDigits(dateTime.minute)}";

    Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) {
      return "${twoDigits(dateTime.day)}.${twoDigits(dateTime.month)}.${dateTime.year} $time";
    }
    return time;
  }

  Widget leftMessage(Message message) {
    Duration difference = DateTime.now().difference(message.updatedAt);

    return InkWell(
      child: ChatBubble(
        padding: const EdgeInsets.all(8),
        clipper: ChatBubbleClipper2(
          type: BubbleType.receiverBubble,
          nipWidth: 0,
          nipHeight: 0,
          nipRadius: 0,
        ),
        alignment: Alignment.topLeft,
        backGroundColor: const Color(0xffE7E7ED),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            message.attachments.isNotEmpty
                ? imageContent(message.attachments.first)
                : SizedBox(),
            Container(
              constraints: BoxConstraints(
                maxWidth: Get.width * 0.60,
              ),
              child: Text(
                message.message ?? "Mesaj",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                difference.inDays > 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          "${twoDigits(message.updatedAt.day)}.${twoDigits(message.updatedAt.month)}.${message.updatedAt.year}",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : Container(),
                Text(
                  "${twoDigits(message.updatedAt.hour)}:${twoDigits(message.updatedAt.minute)}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        // if (chatMessage.type == "document") {
        //   chatController.downloadFile(chatMessage.message);
        // }
      },
    );
  }

  Widget rightMessage(Message message) {
    Duration difference = DateTime.now().difference(message.updatedAt);

    return InkWell(
      child: Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.only(bottom: 5),
        child: ChatBubble(
          padding: const EdgeInsets.all(8),
          clipper: ChatBubbleClipper2(
            type: BubbleType.sendBubble,
            nipWidth: 0,
            nipHeight: 0,
            nipRadius: 0,
          ),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.symmetric(vertical: 5),
          backGroundColor:
              message.sending ? kPrimaryColor.withAlpha(100) : kPrimaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              message.attachments.isNotEmpty
                  ? imageContent(message.attachments.first)
                  : SizedBox(),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * 0.60,
                ),
                child: Text(
                  message.message ?? "Mesaj",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  difference.inDays > 0
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text(
                            "${twoDigits(message.updatedAt.day)}.${twoDigits(message.updatedAt.month)}.${message.updatedAt.year}",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
                  Text(
                    "${twoDigits(message.updatedAt.hour)}:${twoDigits(message.updatedAt.minute)}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    message.sending ? Icons.access_time_rounded : Icons.check,
                    color: message.isReadByReceiver ? Colors.blue : Colors.grey,
                    size: 18,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // if (chatMessage.type == "document") {
        //   chatController.downloadFile(chatMessage.message);
        // }
      },
      onLongPress: () async {
        var result = await Get.dialog(deleteMessageDialog());
        if (result != null && result) {
          var result = await chatController.deleteMessage(message.id);
          if (result.keys.first) {
            chatController.loadMessages(widget.roomId);
            successSnackbar(result.values.first);
          } else {
            failureSnackbar(result.values.first);
          }
        }
      },
    );
  }

  Widget imageContent(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => GestureDetector(
          onTap: () => Get.dialog(showImage(imageUrl: imageUrl)),
          child: Container(
            height: 200,
            width: Get.width * .60,
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          height: 200,
          width: Get.width * .60,
          color: Colors.white60,
          child: Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  void sendMessage() async {
    String messageText = messageController.text;
    if (messageText.trim().isNotEmpty) {
      messageController.clear();

      var messageData = {
        "receiver_id": receiver.id,
        "message": messageText,
        "attachments": [],
      };

      var message = Message(
        message: messageText,
        roomId: widget.roomId,
        sender: receiver,
        senderId: Login().user.id,
        receiverId: receiver.id,
        attachments: [],
        updatedAt: DateTime.now(),
        sending: true,
        isReadByReceiver: false, // burası degisecek
      );

      chatController.messages.insert(0, message);
      API().sendMessage(messageData).then((result) {
        if (result.keys.first) {
          setState(() {
            chatController.messages[0].sending = false;
          });
          chatController.changeRoomsOrder(
            message: message,
            senderId: receiver.id,
          );
        }
      });
    }
  }

  void sendImage() async {
    var result = await chatController.uploadImage();

    if (result) {
      var messageData = {
        "receiver_id": receiver.id,
        "message": chatController.imageText,
        "attachments": [chatController.imageUrl]
      };

      var message = Message(
        message: chatController.imageText,
        attachments: [chatController.imageUrl],
        roomId: widget.roomId,
        sender: widget.receiver,
        senderId: Login().user.id,
        updatedAt: DateTime.now(),
        sending: true,
        isReadByReceiver: true, // burası degisecek
      );

      chatController.messages.insert(0, message);
      API().sendMessage(messageData).then((result) {
        if (result.keys.first) {
          setState(() {
            chatController.messages[0].sending = false;
          });
          chatController.changeRoomsOrder(
            message: message,
            // senderId: receiver.id,
          );
        } else {
          chatController.messages.removeAt(0);
          failureSnackbar(result.values.first);
        }
      });
    }
  }

  void _onLoading() async {
    PagedResponse metadata = chatController.messageMetadata;

    if (metadata.meta.currentPage < metadata.meta.lastPage) {
      var loadNewMessages = await API().getMessages(
        Login().token,
        widget.roomId,
        page: metadata.meta.currentPage + 1,
      );

      if (loadNewMessages.keys.first) {
        chatController.messageMetadata =
            loadNewMessages.values.first as PagedResponse;
        chatController.messages
            .addAll(chatController.messageMetadata.data as List<Message>);
      }
    }
    _refreshController.loadComplete();
  }
}
