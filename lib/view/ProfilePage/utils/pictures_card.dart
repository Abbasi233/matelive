import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'my_text.dart';
import 'my_text_input.dart';
import '../../../constant.dart';
import '/view/utils/fixedSpace.dart';
import '/view/utils/primaryButton.dart';

class PicturesCard extends StatefulWidget {
  @override
  _PicturesCardState createState() => _PicturesCardState();
}

class _PicturesCardState extends State<PicturesCard> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        child: Column(
          children: [
            _buildButtons(),
            _selected == 0
                ? _buildProfilePictureCard()
                : _buildGalleryPicturesCard(),
          ],
        ));
  }

  Widget _buildButtons() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PROFİL FOTOĞRAFINIZ",
              style: styleH5(fontWeight: FontWeight.w600),
            ),
            fixedHeight,
            SizedBox(
              width: Get.width,
              child: primaryButton(
                onPressed: () {
                  setState(() {
                    _selected = 0;
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
            SizedBox(
              width: Get.width,
              child: primaryButton(
                onPressed: () {
                  setState(() {
                    _selected = 1;
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
                  Image.asset(
                    'assets/images/avatar.png',
                    width: Get.width,
                    height: 260,
                    fit: BoxFit.fill,
                  ),
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

  Widget _buildGalleryPicturesCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Scrollbar(
              child: SizedBox(
                width: Get.width,
                height: 550,
                child: ListView.separated(
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            width: Get.width,
                            height: 260,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: _buildDeleteButton(),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, i) => fixedHeight,
                ),
              ),
            ),
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
