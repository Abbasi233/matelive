import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/constant.dart';
import '/model/login.dart';
import '/controller/api.dart';
import 'notification_item.dart';
import '/view/utils/snackbar.dart';
import '/model/notifications.dart' as app;
import '/view/LandingPage/controller.dart';
import '/view/utils/progressIndicator.dart';
import '/controller/getX/notifications_controller.dart';

class NotificationsCard extends StatelessWidget {
  NotificationsCard({
    this.showThree = false,
    this.showSeeAll = false,
    this.showDeleteAll = false,
  });

  final bool showThree;
  final bool showSeeAll;
  final bool showDeleteAll;
  final _landingPageController = Get.find<LandingPageController>();
  final _notificationsController = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: kTextColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(kBorderRadius)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BİLDİRİMLER",
                    style: styleH5(fontWeight: FontWeight.w600),
                  ),
                  showSeeAll
                      ? TextButton(
                          onPressed: () {
                            _landingPageController.changeTab(2);
                          },
                          child: Text(
                            "Tümünü Gör",
                            style: customFont(
                              16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : Opacity(opacity: 0),
                  showDeleteAll
                      ? Obx(
                          () => TextButton(
                            onPressed: (_notificationsController
                                            .pagedResponse.value.data !=
                                        null &&
                                    _notificationsController
                                        .pagedResponse.value.data.isNotEmpty)
                                ? () async {
                                    var dialogResult = await Get.dialog(
                                      AlertDialog(
                                        content: Text(
                                            "Tüm bildirimleri silmek istediğinizden emin misiniz?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Get.back(result: true),
                                              child: Text("Evet")),
                                          TextButton(
                                              onPressed: () =>
                                                  Get.back(result: false),
                                              child: Text("Hayır")),
                                        ],
                                      ),
                                    );

                                    if (dialogResult) {
                                      var result = await API()
                                          .clearNotification(Login().token);
                                      if (result is bool && result) {
                                        successSnackbar(
                                            "Tüm bildirimleriniz başarıyla silindi.");
                                      } else {
                                        failureSnackbar(result);
                                      }
                                    }
                                  }
                                : null,
                            child: Text(
                              "Tümünü Sil",
                              style: customFont(
                                16,
                                color: (_notificationsController
                                            .pagedResponse.value.data !=
                                        null &&
                                    _notificationsController
                                        .pagedResponse.value.data.isNotEmpty)
                                    ? kOrangeColor
                                    : kTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Opacity(opacity: 0),
                ],
              ),
            ),
            Divider(),
            Obx(
              () {
                var data = _notificationsController.pagedResponse.value.data ?? [];
                int endRange = showThree && data.length > 3 ? 3 : data.length;
                return data != null
                    ? data.isNotEmpty
                        ? Column(
                            children: data
                                .getRange(0, endRange)
                                .map(
                                  (i) => notificationItem(
                                    message: (i as app.Notification).message,
                                    dateTime: (i as app.Notification)
                                        .createdAtFormatted,
                                    onPressed: () async {
                                      var dialogResult = await Get.dialog(
                                        AlertDialog(
                                          content: Text(
                                              "Seçilen bildirimi silmek istediğinizden emin misiniz?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Get.back(result: true),
                                                child: Text("Evet")),
                                            TextButton(
                                                onPressed: () =>
                                                    Get.back(result: false),
                                                child: Text("Hayır")),
                                          ],
                                        ),
                                      );

                                      if (dialogResult) {
                                        var result =
                                            await API().delNotification(
                                          Login().token,
                                          (i as app.Notification).id,
                                        );

                                        if (result is bool && result) {
                                          successSnackbar(
                                              "Bildirim başarıyla silinmiştir.");
                                        } else {
                                          failureSnackbar(result);
                                        }
                                      }
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : Center(
                            child: Text(
                              "Şu anda herhangi bir bildiriminiz bulunmamaktadır.",
                              textAlign: TextAlign.center,
                            ),
                          )
                    : showProgressIndicator(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
