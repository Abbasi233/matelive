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
  var roomsFuture = API().getRooms(Login().token);
  final _refreshController = RefreshController(initialRefresh: false);

  var chatController = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    print(Get.currentRoute);
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
          child: FutureBuilder<Map<bool, dynamic>>(
            future: roomsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var mapData = snapshot.data;

                if (mapData.keys.first) {
                  var pagedResponse = mapData.values.first as PagedResponse;
                  var data = pagedResponse.data as List<Room>;

                  if (data.isEmpty) {
                    return Center(
                      child: autoSize(
                        text: "Henüz Kimseyle Mesajlaşmadınız...",
                        paddingRight: 0,
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "${data[index].user.name} ${data[index].user.surname}",
                      ),
                      leading: CachedNetworkImage(
                        imageUrl: data[index].user.image,
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
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      subtitle: data[index].lastMessage != ""
                          ? Row(
                              children: [
                                data[index].user.id == Login().user.id
                                    ? Icon(Icons.check)
                                    : !data[index].isRead
                                        ? Icon(
                                            Icons.circle,
                                            color: kPrimaryColor,
                                          )
                                        : Container(),
                                Text(data[index].lastMessage.toString()),
                              ],
                            )
                          : const Text(
                              "Henüz mesaj yok.",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                      onTap: () {
                        print("Tap");
                        Get.to(() => MessagePage(
                              roomId: data[index].id,
                              receiver: data[index].user,
                            ));
                        // chatController.selectedChat.value = data[index];
                        // chatController.chatId.value = data[index].docId.toString();
                      },
                    ),
                  );
                }
              }

              return showProgressIndicator(context);
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    _refreshController.refreshCompleted();
    setState(() {
      roomsFuture = API().getRooms(Login().token);
    });
  }
}
