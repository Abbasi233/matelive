import 'package:flutter/material.dart';

import '/constant.dart';
import '/view/utils/appBar.dart';
import '/view/utils/auto_size_text.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          "S.S.S.",
          style: styleH3(),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          autoSize(
            text: "Sıkça Sorulan Sorular;",
            style: styleH1(),
            maxLines: 2,
            paddingVertical: 20,
          ),
          questionStyle("Soru1: matelive.net nedir?"),
          answerStyle(
            "Cevap: matelive.net  bir arkadaşlık sitesi olup yeni insanlarla tanışma ve sosyalleşme imkanı sunan ve bunu yaparken güvenlik ve gizliliğe önem veren bir arkadaşlık platformudur. Diğer arkadaşlık sitelerinden ayıran en belirgin farkı sesli görüşme imkanı sunmasıdır.",
          ),
          questionStyle("Soru2: matelive.net nasıl çalışır?"),
          answerStyle(
              "Cevap: matelive.net sitesinde profil oluşturma ve profil inceleme vardır. Yayında olan profilleri ücretsiz inceleme imkanı vermektedir, yayında olan profilleri satın aldığınız sesli konuşma paketleriyle dilediğiniz zaman iletişime geçebilirsiniz. Profil oluşturabilmek için sadece sürekli kullandığınız e-posta adresinizin olması yeterlidir."),
          questionStyle("Soru3: Nasıl profil oluşturabilirim?"),
          answerStyle(
              "Cevap: matelive.net sitesindeki Matelive'a kaydol sayfası üzerinden sizden istenilen bilgileri sisteme girerek profil oluşturma işleminize başlayabilirsiniz. Sizden istenilen bilgileri doldurduktan sonra ''Kaydol'' butonuna tıklayarak profilinizi onaylamanız gerekiyor, sonrasında editörlerimizin inceleme aşamasından geçtikten sonra uygun bulunursa profiliniz ziyaretçilere açık yayınlanacaktır."),
          questionStyle("Soru4: Profilimi nasıl oluşturmalıyım?"),
          answerStyle(
              "Cevap: Profil oluşturmak çok basit ve kolaydır. Unutmayın, bu bir arkadaşlık platformu, dolayısıyla kendinizi en rahat ve özgün şekilde anlatmanızı öneriyoruz."),
          questionStyle("Soru5: Profili bulunan adaylara nasıl ulaşabilirim?"),
          answerStyle(
              "Cevap: profili bulunan adaylara ulaşabilmeniz için ilk kayıtta hesabınıza tanımlanan ücretsiz dakikaları kullanarak istediğiniz zaman istediğiniz kişiye (çevirim içi ise) ulaşabilir, konuşabilirsiniz. Süreniz bittiği zaman size en uygun dakika paketini satın alıp istediğiniz kişiyi tekrar arayabilir doyasıya konuşabilirsiniz."),
          questionStyle("Soru6: matelive.net'e neden üye olmalıyım?"),
          answerStyle(
              "Cevap: Tamamen gerçek kişilerden oluşan arkadaşlık platformudur, kullanıcılarına ücretli hizmet vermektedir. Matelive.net'te bulunan profilleri editörlerimiz titizlikle incelemelerde bulunarak profilleri onaydan geçirmektedirler. Matelive.net içerisinde yaşadığınız herhangi bir sorun yada cevaplanması gerektiğini düşündüğünüz her türlü sorularınız için günün her saati site@matelive.net e-posta adresine yazabilirsiniz."),
        ],
      ),
    );
  }

  Widget questionStyle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: styleH2(),
        ),
      );

  Widget answerStyle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Text(
          text,
          style: styleH4(),
        ),
      );
}
