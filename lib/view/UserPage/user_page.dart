import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/view/Agora/call_page.dart';
import 'package:matelive/view/utils/appBar.dart';
import 'package:matelive/view/utils/footer.dart';
import 'package:matelive/view/utils/primaryButton.dart';

class UserPage extends StatefulWidget {
  final String username;
  UserPage(
    this.username,
  );
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: Get.height * 0.4,
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 50,
                  foregroundImage:
                      Image.asset("assets/images/avatar.png").image,
                ),
                Text.rich(
                  TextSpan(
                    text: widget.username,
                    style: styleH3().copyWith(),
                    children: [
                      TextSpan(
                        text: " (Onaylanmış Kullanıcı)\n",
                        style: styleH5(color: Colors.green),
                      ),
                      TextSpan(
                        text: "Toplam Başarılı Görüşme Sayısı: ",
                        style: styleH5(),
                        children: [
                          TextSpan(
                            text: "0",
                            style: styleH4(
                                color: kBlackColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                primaryButton(
                  text: Text("Şu An Çevrimiçi"),
                  onPressed: () {
                    Get.to(() => CallPage(widget.username));
                  },
                  padding: Get.width * 0.20,
                  // disabled: true,
                ),
              ],
            ),
          ),
          fixedHeight,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fotoğraf Galerisi",
                  style: styleH2(),
                ),
                Text(
                  "Kullanıcı henüz bir görsel paylaşmadı.",
                  style: styleH4(),
                ),
                fixedHeight,
                Container(
                  height: 150,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    border: Border.all(
                      width: 1,
                      color: kTextColor,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("HAKKINDA",
                          style: styleH4(fontWeight: FontWeight.w600)),
                      Text.rich(
                        TextSpan(
                          text: "Cinsiyet: ",
                          children: [
                            TextSpan(
                                text: "Belirtilmemiş",
                                style: styleH4(fontWeight: FontWeight.w600))
                          ],
                        ),
                        style: styleH4(),
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Yaş: ",
                          children: [
                            TextSpan(
                                text: "Belirtilmemiş",
                                style: styleH4(fontWeight: FontWeight.w600))
                          ],
                        ),
                        style: styleH4(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          footer(),
        ],
      ),
    );
  }
}
