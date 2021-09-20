import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'my_slider.dart';
import '../../../constant.dart';
import '/view/utils/fixedSpace.dart';
import '/view/utils/primaryButton.dart';

enum SelectedContent { ProfilePicture, GalleryPictures }

class PicturesCard extends StatefulWidget {
  @override
  _PicturesCardState createState() => _PicturesCardState();
}

class _PicturesCardState extends State<PicturesCard> {
  //'Profil fotoğrafı' ya da 'Galeri Fotoğrafları' seçimi
  SelectedContent _selectedContent = SelectedContent.ProfilePicture;
  List<Widget> items;

  @override
  void initState() {
    super.initState();

    //Mockup data için burada
    //Veri gelince silinebilir.
    items = List.filled(
        5,
        Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/avatar.png',
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: _buildDeleteButton(),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          //'Profil fotoğrafı' ya da 'Galeri Fotoğrafları' butonları
          _buildButtons(),
          _selectedContent == SelectedContent.ProfilePicture
              ? _buildProfilePictureCard()
              : _buildGalleryPicturesCard(),
        ],
      ),
    );
  }

  //'Profil fotoğrafı' ya da 'Galeri Fotoğrafları' butonları
  Widget _buildButtons() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedContent == SelectedContent.ProfilePicture
                  ? "PROFİL FOTOĞRAFINIZ"
                  : "GALERİ",
              style: styleH5(fontWeight: FontWeight.w600),
            ),
            fixedHeight,
            //'Profil Fotoğrafı' Butonu
            SizedBox(
              width: Get.width,
              child: primaryButton(
                onPressed: () {
                  setState(() {
                    _selectedContent = SelectedContent.ProfilePicture;
                  });
                },
                height: 40,
                backgroundColor: Color(0xff188754),
                text: Text(
                  "Profil Fotoğrafı",
                  style: styleH4(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            fixedHeight,
            //'Galeri Fotoğrafları' Butonu
            SizedBox(
              width: Get.width,
              child: primaryButton(
                onPressed: () {
                  setState(() {
                    _selectedContent = SelectedContent.GalleryPictures;
                  });
                },
                height: 40,
                text: Text(
                  "Galeri Fotoğrafları",
                  style: styleH4(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Profil Fotoğrafı değiştirmek için
  Widget _buildProfilePictureCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profil Fotoğrafı",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  //Profil Fotoğrafı
                  Image.asset(
                    'assets/images/avatar.png',
                    width: Get.width,
                    height: 260,
                    fit: BoxFit.fill,
                  ),
                  //Sil Butonu
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildDeleteButton(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              primaryButton(
                onPressed: () {},
                width: Get.width,
                height: 45,
                borderRadius: 8,
                text: Text(
                  "Profil Fotoğrafını Güncelle",
                  style: styleH4(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Galerideki fotoğrafları görmek ve yeni foto. eklemek için.
  Widget _buildGalleryPicturesCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //Galeri Fotoları Slider
            MySlider(
              items,
              225,
              enlargeCenterPage: true,
            ),
            fixedHeight,
            primaryButton(
              onPressed: () {},
              width: Get.width,
              height: 45,
              borderRadius: 8,
              text: Text(
                "Fotoğraf Ekle",
                style: styleH4(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Fotoğrafların üzeirndeki sil butonu.
  Widget _buildDeleteButton() {
    return GestureDetector(
      child: Container(
        width: 50,
        height: 25,
        decoration: BoxDecoration(
          color: Color(0xffff6147),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage('assets/icons/trash.png'),
              size: 16,
              color: Colors.white,
            ),
            SizedBox(width: 2),
            Text(
              'Sil',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
