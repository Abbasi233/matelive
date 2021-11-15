import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:matelive/controller/api.dart';
import 'package:matelive/model/login.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/view/utils/primaryButton.dart';
import 'package:matelive/view/utils/snackbar.dart';

import 'my_text_input.dart';
import '/constant.dart';
import '../../utils/my_text.dart';
import '/extensions.dart';

class AccountInfoCard extends StatelessWidget {
  final adController = TextEditingController(text: ProfileDetail().name);
  final soyadController = TextEditingController(text: ProfileDetail().surname);
  final cinsiyetController = TextEditingController();
  final ePostaController = TextEditingController(text: ProfileDetail().email);
  final telController = TextEditingController(text: ProfileDetail().phone);
  final dogumController = TextEditingController(text: ProfileDetail().birthday);
  final aciklamacontroller = HtmlEditorController();
  final facebookController =
      TextEditingController(text: ProfileDetail().socialMedias.facebook);
  final instagramController =
      TextEditingController(text: ProfileDetail().socialMedias.instagram);
  final twitterController =
      TextEditingController(text: ProfileDetail().socialMedias.twitter);
  final pinterestController =
      TextEditingController(text: ProfileDetail().socialMedias.pinterest);
  final websiteController =
      TextEditingController(text: ProfileDetail().socialMedias.website);

  final genders = {0: "Kadın", 1: "Erkek", 2: "Belirtmeyi Tercih Etmiyorum"};
  final selectedGender = ProfileDetail().gender.obs;

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
              MyText('Adınız'),
              MyTextInput(controller: adController),
              fixedHeight,
              MyText('Soyadınız'),
              MyTextInput(controller: soyadController),
              fixedHeight,
              MyText('Cinsiyetiniz'),
              Obx(
                () => DropdownButton(
                  onChanged: (value) {
                    selectedGender.value = value;
                  },
                  value: selectedGender.value,
                  items: genders.keys.map((i) {
                    return DropdownMenuItem(
                      child: Text(genders[i]),
                      value: i,
                    );
                  }).toList(),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  isExpanded: true,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontSize: 18,
                  ),
                  icon: ImageIcon(
                    Image.asset('assets/icons/arrow_expand.png').image,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
              fixedHeight,
              MyText('E-Posta Adresiniz'),
              MyTextInput(controller: ePostaController),
              fixedHeight,
              MyText('Telefon Numaranız'),
              MyTextInput(
                  controller: telController,
                  textInputType: TextInputType.phone,
                  hintText: '5XX XXX XX XX'),
              fixedHeight,
              MyText('Doğum Tarihiniz'),
              GestureDetector(
                onTap: () async {
                  var result = await Get.dialog(
                    DatePickerDialog(
                      initialDate: dogumController.text.formatToDate(),
                      firstDate: DateTime(1960),
                      lastDate: DateTime.now().subtract(
                        Duration(days: 365 * 18),
                      ),
                    ),
                  );

                  if (result != null) {
                    var selectedDate = result as DateTime;
                    print(selectedDate.formatToString());
                    dogumController.text = selectedDate.formatToString();
                  }
                },
                child: MyTextInput(
                  controller: dogumController,
                  enabled: false,
                  textInputType: TextInputType.datetime,
                  hintText: 'GG/AA/YYYY',
                ),
              ),
              fixedHeight,
              MyText('Profil Açıklamanız'),
              fixedHeight,
              SizedBox(
                height: 200,
                child: HtmlEditor(
                  controller: aciklamacontroller,
                  htmlEditorOptions: HtmlEditorOptions(
                    initialText: ProfileDetail().description,
                    hint: "Burayı doldurunuz...",
                  ),
                  otherOptions: OtherOptions(height: 400),
                  htmlToolbarOptions: HtmlToolbarOptions(
                    defaultToolbarButtons: [
                      FontButtons(),
                    ],
                  ),
                ),
              ),
              fixedHeight,
              Text(
                "SOSYAL MEDYA BİLGİLERİ",
                style: styleH5(fontWeight: FontWeight.w600),
              ),
              fixedHeight,
              MyText('Facebook'),
              MyTextInput(
                controller: facebookController,
                hintText: "Facebook",
              ),
              fixedHeight,
              MyText('Instagram'),
              MyTextInput(
                controller: instagramController,
                hintText: "Instagram",
              ),
              fixedHeight,
              MyText('Twitter'),
              MyTextInput(
                controller: twitterController,
                hintText: "Twitter",
              ),
              fixedHeight,
              MyText('Pinterest'),
              MyTextInput(
                controller: pinterestController,
                hintText: "Pinterest",
              ),
              fixedHeight,
              MyText('Website'),
              MyTextInput(
                controller: websiteController,
                hintText: "Website",
              ),
              fixedHeight,
              primaryButton(
                text: Text(
                  "Hesap Bilgilerini Güncelle",
                  style: styleH4(
                    fontSize: 18,
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                imageIcon: ImageIcon(
                  AssetImage('assets/icons/forward_button.png'),
                  size: 22,
                  color: kWhiteColor,
                ),
                onPressed: () async {
                  var body = {
                    "name": adController.text,
                    "surname": soyadController.text,
                    "gender": selectedGender.value,
                    "phone": telController.text,
                    "birthday": dogumController.text,
                    "description": await aciklamacontroller.getText(),
                    "social_medias": {
                      "facebook": facebookController.text,
                      "instagram": instagramController.text,
                      "twitter": twitterController.text,
                      "pinterest": pinterestController.text,
                      "website": websiteController.text,
                    }
                  };
                  print(body);

                  var result = await API().updateProfile(Login().token, body);
                  if (result.keys.first) {
                    successSnackbar(result.values.first);
                  } else {
                    failureSnackbar(result.values.first);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
