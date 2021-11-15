import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import '/view/utils/footer.dart';
import '/model/notifications.dart';
import '/view/utils/miniCard.dart';
import '/model/paged_response.dart';
import '/model/total_notifications.dart';
import '/view/utils/progressIndicator.dart';
import '/view/utils/notifications_card.dart';
import '/controller/getX/notifications_controller.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  var totalFuture = API().getTotalNotifications(Login().token);
  var notificationsFuture = API().getNotificationsByType(Login().token, "all");

  final notificationsController = Get.put(NotificationsController());
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<bool, dynamic>>>(
        future: Future.wait([
          totalFuture,
          notificationsFuture,
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var totalNotification = snapshot.data[0];
            var notifications = snapshot.data[1];

            if (totalNotification.keys.first && notifications.keys.first) {
              TotalNotifications total = totalNotification.values.first;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                notificationsController.pagedResponse.value =
                    notifications.values.first;
              });

              return SmartRefresher(
                enablePullDown: true,
                onRefresh: _onRefresh,
                controller: _refreshController,
                header: MaterialClassicHeader(),
                physics: BouncingScrollPhysics(),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    fixedHeight,
                    Text("Bildirimler", style: styleH1()),
                    fixedHeight,
                    Row(
                      children: [
                        miniCard(
                          "SİSTEM\nBİLDİRİMLERİ",
                          total.systemNotificationCount.toString(),
                          Colors.yellow[700],
                        ),
                        fixedWidth,
                        miniCard(
                          "BEĞENİ\nBİLDİRİMLERİ",
                          total.likeNotificationCount.toString(),
                          Colors.yellow[700],
                        ),
                      ],
                    ),
                    fixedHeight,
                    Row(
                      children: [
                        miniCard(
                          "DÜRTME\nBİLDİRİMLERİ",
                          total.snoozeNotificationCount.toString(),
                          Colors.yellow[700],
                        ),
                        fixedWidth,
                        miniCard(
                          "FAVORİ\nBİLDİRİMLERİ",
                          total.favoriteNotificationCount.toString(),
                          Colors.yellow[700],
                        ),
                      ],
                    ),
                    fixedHeight,
                    NotificationsCard(showDeleteAll: true),
                    footer(),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Bir hata oluştu."),
              );
            }
          }
          return showProgressIndicator(context);
        },
      ),
    );
  }

  void _onRefresh() async {
    var totalResult = await API().getTotalNotifications(Login().token);
    var notificationsResult =
        await API().getNotificationsByType(Login().token, "all");

    setState(() {
      totalFuture = Future.value(totalResult);
      notificationsFuture = Future.value(notificationsResult);
    });
    _refreshController.refreshCompleted();
  }
}
