import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/model/Chat/room.dart';
import '/view/utils/appBar.dart';
import '/model/paged_response.dart';
import '/view/utils/auto_size_text.dart';
import '/view/chats_page/message_page.dart';
import '/view/chats_page/utils/methods.dart';
import '/controller/getX/chat_controller.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key key}) : super(key: key);

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final _refreshController = RefreshController(initialRefresh: false);
  var chatController = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    chatController.loadRooms();
  }

  @override
  void dispose() {
    chatController.messages.clear();
    chatController.activeChatId.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "Mesajlaşmalar",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        () {
          if (chatController.rooms.isEmpty) {
            return Center(
              child: autoSize(
                text: "Henüz kimseyle mesajlaşmadınız.",
                paddingRight: 0,
              ),
            );
          }

          return Scrollbar(
            child: SmartRefresher(
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              footer: customFooter(),
              controller: _refreshController,
              header: MaterialClassicHeader(),
              physics: BouncingScrollPhysics(),
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: chatController.rooms.length,
                itemBuilder: (context, index) {
                  var room = chatController.rooms[index];
                  return ListTile(
                    title: Text(
                      "${room.user.name} ${room.user.surname}",
                      style: isReadByReceiver(room, Login().user.id)
                          ? null
                          : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                    ),
                    leading: CachedNetworkImage(
                      imageUrl: room.user.image,
                      imageBuilder: (context, provider) => Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width: 70.0,
                        height: 70.0,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    subtitle: room.lastMessage != ""
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              room.lastMessageSentBy == Login().user.id
                                  ? Icon(
                                      Icons.check,
                                      color: isReadByReceiver(
                                        room,
                                        room.user.id,
                                      )
                                          ? Colors.blue
                                          : Colors.grey,
                                    )
                                  : isReadByReceiver(room, Login().user.id)
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.circle,
                                            color: kPrimaryColor,
                                            size: 20,
                                          ),
                                        ),
                              Expanded(
                                child: Text(
                                  room.lastMessage.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            "Henüz mesaj yok.",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                    onTap: () async {
                      print("Tap");
                      await Get.to(
                        () => MessagePage(
                          roomId: room.id,
                          receiver: room.user,
                        ),
                      );
                      chatController.changeRoomIsRead();
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  bool isReadByReceiver(Room room, int userId) {
    return room.isRead != null && room.isRead["$userId"];
  }

  void _onRefresh() async {
    await chatController.loadRooms();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    PagedResponse metadata = chatController.roomsMetadata;

    if (metadata.meta.currentPage < metadata.meta.lastPage) {
      var loadNewRooms = await API().getRooms(
        Login().token,
        page: metadata.meta.currentPage + 1,
      );

      if (loadNewRooms.keys.first) {
        chatController.roomsMetadata =
            loadNewRooms.values.first as PagedResponse;
        chatController.rooms
            .addAll(chatController.roomsMetadata.data as List<Room>);
      }
    }
    _refreshController.loadComplete();
  }
}
