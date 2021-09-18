import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '/view/utils/fixedSpace.dart';

class AccountInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HESAP BİLGİLERİ",
                style: styleH5(fontWeight: FontWeight.w600),
              ),
              fixedHeight,
              Text(
                'Adınız',
                style: TextStyle(
                  color: Color(0xff282828),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              TextField(
                cursorColor: Color(0xffdc1b43),
                decoration: InputDecoration(
                  hintText: 'Mobil',
                  hintStyle: TextStyle(
                    color: Color(0xff737373),
                    letterSpacing: 0.5,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffdc1b43))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
