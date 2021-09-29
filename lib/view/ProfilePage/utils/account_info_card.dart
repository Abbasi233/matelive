import 'package:get/get.dart';
import 'package:flutter/material.dart';

// import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:html_editor_enhanced/utils/callbacks.dart';
// import 'package:html_editor_enhanced/utils/file_upload_model.dart';
// import 'package:html_editor_enhanced/utils/options.dart';
// import 'package:html_editor_enhanced/utils/plugins.dart';
// import 'package:html_editor_enhanced/utils/shims/dart_ui.dart';
// import 'package:html_editor_enhanced/utils/shims/dart_ui_fake.dart';
// import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
// import 'package:html_editor_enhanced/utils/toolbar.dart';
// import 'package:html_editor_enhanced/utils/utils.dart';

import 'my_text_input.dart';
import 'my_dropdown_button.dart';
import '../../../constant.dart';
import '../../utils/my_text.dart';

class AccountInfoCard extends StatelessWidget {
  // final HtmlEditorController controller = HtmlEditorController();

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
              MyTextInput(),
              fixedHeight,
              MyText('Soyadınız'),
              MyTextInput(),
              fixedHeight,
              MyText('Cinsiyetiniz'),
              MyDropdownButton('Lütfen Seçiniz', <String>[
                'Kadın',
                'Erkek',
                'Belirtmeyi Tercih Etmiyorum',
              ]),
              fixedHeight,
              fixedHeight,
              fixedHeight,
              MyText('E-Posta Adresiniz'),
              MyTextInput(),
              fixedHeight,
              MyText('Telefon Numaranız'),
              MyTextInput(hintText: '5XX XXX XX XX'),
              fixedHeight,
              MyText('Doğum Tarihiniz'),
              MyTextInput(hintText: 'GG/AA/YYYY'),
              fixedHeight,
              MyText('Profil Açıklamanız'),
              fixedHeight,
              // SizedBox(
              //   height: 200,
              //   child: HtmlEditor(
              //     controller: controller, //required
              //     htmlEditorOptions: HtmlEditorOptions(
              //       initialText: 'sdfsdfsdf',
              //       hint: "Your text here...",
              //       //initalText: "text content initial, if any",
              //     ),
              //     otherOptions: OtherOptions(
              //       height: 400,
              //     ),
              //     htmlToolbarOptions: HtmlToolbarOptions(
              //       defaultToolbarButtons: [
              //         FontButtons(),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
