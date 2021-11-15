import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class AccountSettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HESAP AYARLARI",
                style: styleH5(fontWeight: FontWeight.w600),
              ),
              fixedHeight,
              _buildLabel('Profil fotoğrafımı kimler görebilir?'),
              // MyDropdownButton('Tüm Matelive Üyeleri', <String>[
              //   'Sadece Ben',
              //   'Tüm Matelive Üyeleri',
              //   'Sadece Beğendiğim Üyeler',
              //   'Sadece Favorilere Eklediğim Üyeler',
              // ]),
              // fixedHeight,
              // _buildLabel('Galeri görsellerimi kimler görebilir?'),
              // MyDropdownButton('Tüm Matelive Üyeleri', <String>[
              //   'Sadece Ben',
              //   'Tüm Matelive Üyeleri',
              //   'Sadece Beğendiğim Üyeler',
              //   'Sadece Favorilere Eklediğim Üyeler',
              // ]),
              // fixedHeight,
              // _buildLabel('Sosyal medya adreslerimi kimler\ngörebilir?'),
              // MyDropdownButton('Tüm Matelive Üyeleri', <String>[
              //   'Sadece Ben',
              //   'Tüm Matelive Üyeleri',
              //   'Sadece Beğendiğim Üyeler',
              //   'Sadece Favorilere Eklediğim Üyeler',
              // ]),
              // fixedHeight,
              // _buildLabel('Profil açıklamamı kimler görebilir?'),
              // MyDropdownButton('Tüm Matelive Üyeleri', <String>[
              //   'Sadece Ben',
              //   'Tüm Matelive Üyeleri',
              //   'Sadece Beğendiğim Üyeler',
              //   'Sadece Favorilere Eklediğim Üyeler',
              // ]),
              fixedHeight,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Row(
      children: [
        Icon(Icons.arrow_forward_ios, size: 18),
        SizedBox(width: 5),
        Text(title, style: TextStyle(fontSize: 17)),
      ],
    );
  }
}
