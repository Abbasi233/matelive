import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/view/LandingPage/controller.dart';

import '/constant.dart';
import '/view/HomePage/utils/comment.dart';

class NotificationsCard extends StatelessWidget {
  final bool showSeeAll;
  final bool showDeleteAll;

  NotificationsCard({this.showSeeAll = false, this.showDeleteAll = false});

  final _landingPageController = Get.find<LandingPageController>();

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
                      ? TextButton(
                          onPressed: () {},
                          child: Text(
                            "Tümünü Sil",
                            style: customFont(
                              16,
                              color: kOrangeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : Opacity(opacity: 0),
                ],
              ),
            ),
            Divider(),
            // TODO GEÇMİŞ GÖRÜŞMELER
            // Expanded(
            //   child:
            Column(
              children: [0, 0, 0]
                  .map(
                    (i) => comment(
                      description:
                          "Matelive'a hoşgeldiniz! Profil bilgilerinizi güncellemek için buraya tıklayabilirsiniz.",
                      dateTime: DateTime.now(),
                    ),
                  )
                  .toList(),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
