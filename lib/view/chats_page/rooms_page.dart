import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/controller/getX/chat_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/model/Chat/room.dart';
import '/view/utils/appBar.dart';
import '/model/paged_response.dart';
import '/view/utils/auto_size_text.dart';
import '/view/utils/progressIndicator.dart';
import '/view/chats_page/message_page.dart';

import '/model/login.dart';
import '/controller/api.dart';

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
        // centerTitle: true,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: _onRefresh,
        controller: _refreshController,
        header: MaterialClassicHeader(),
        physics: BouncingScrollPhysics(),
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Obx(() {
            if (chatController.rooms.isEmpty) {
              return Center(
                child: autoSize(
                  text: "Henüz kimseyle mesajlaşmadınız.",
                  paddingRight: 0,
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: chatController.rooms.length,
              itemBuilder: (context, index) {
                var room = chatController.rooms[index];
                return ListTile(
                  title: Text(
                    "${room.user.name} ${room.user.surname}",
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
                          children: [
                            room.user.id == Login().user.id
                                ? Icon(Icons.check)
                                : !room.isRead
                                    ? Icon(
                                        Icons.circle,
                                        color: kPrimaryColor,
                                      )
                                    : Container(),
                            Text(room.lastMessage.toString()),
                          ],
                        )
                      : const Text(
                          "Henüz mesaj yok.",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                  onTap: () async {
                    print("Tap");
                    await Get.to(() => MessagePage(
                          roomId: room.id,
                          receiver: room.user,
                        ));
                    // setState(() {});
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await chatController.loadRooms();
    _refreshController.refreshCompleted();
  }
}
