import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../utils/my_text.dart';
import 'my_text_input.dart';
import '../../../constant.dart';
import '/view/utils/fixedSpace.dart';

class SocialMediaInfoCard extends StatelessWidget {
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
                "SOSYA MEDYA BİLGİLERİ",
                style: styleH5(fontWeight: FontWeight.w600),
              ),
              fixedHeight,
              MyText('Facebook'),
              MyTextInput(),
              fixedHeight,
              MyText('Instagram'),
              MyTextInput(),
              fixedHeight,
              MyText('Twitter'),
              MyTextInput(),
              fixedHeight,
              MyText('Pinterest'),
              MyTextInput(),
              fixedHeight,
              MyText('Website'),
              MyTextInput(),
            ],
          ),
        ),
      ),
    );
  }
}
