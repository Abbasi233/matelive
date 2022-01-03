import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/view/LandingPage/contact_page/contact_page.dart';
import 'package:matelive/view/utils/appBar.dart';
import 'package:matelive/view/utils/auto_size_text.dart';
import 'package:matelive/view/utils/footer.dart';
import 'package:matelive/view/utils/primaryButton.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "Hakkımızda",
          style: styleH3(),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/about.jpeg"),
                    ),
                  ),
                ),
                Text(
                  "Şirketimiz Hakkında",
                  style: styleH5(),
                ),
                autoSize(
                  text: "İşimizi seviyor,\nsizin için çalışıyoruz!",
                  style: styleH1(),
                  maxLines: 2,
                  paddingVertical: 20,
                ),
                Text(
                  "Matelive.net İstanbul merkezli 2021 yılında projesi oluşturulup aynı yıl içinde web portalı faaliyetleri olarak online ve sesli sohbet sitesi olarak hizmet vermeye başlamıştır. Matelive.net'in en büyük özelliği tamamı gerçek profillerden oluşmasıdır. Bu da diğer uygulamalarda ve sitelerden en büyük olumlu farkımız olarak ortaya koymaktadır. Matelive uygulama projesine de başlamış olup aynı yıl içinde uygulama olarak da mobil mağazalar da yerin alacaktır. Hedefimiz dünya web portalı faaliyetleri bazında matelive markamızı dünyaya yaymaktır.",
                  style: styleH4(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: Color(0xFFf1f6f6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                autoSize(
                  text: "Merak ettiklerinizi bize sorun!",
                  style: styleH1(),
                  maxLines: 2,
                  paddingRight: 0,
                ),
                const SizedBox(height: 10),
                Text(
                  "Aklınıza takılan sorular, karşılaştığınız sorunlar ya da önerileriniz için bizimle iletişime geçin.",
                  style: styleH4(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: primaryButton(
                    text: autoSize(
                      text: 'İletişime Geç',
                      paddingRight: 0,
                    ),
                    imageIcon: Icon(Icons.mail_outline),
                    onPressed: () {
                      Get.off(() => ContactPage());
                    },
                  ),
                ),
              ],
            ),
          ),
          footer(),
        ],
      ),
    );
  }
}
