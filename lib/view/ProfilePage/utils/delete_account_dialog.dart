import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:matelive/view/auth/utils/text_input.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key key}) : super(key: key);
  @override
  _DeleteAccountDialogState createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.all(20),
      child: AlertDialog(
        title: Text("Hesabımı Sil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hesabınızı silmek üzeresiniz. Bu işlem geri döndürülemez. İşlemi tamamlamak için şifrenizi girmelisiniz.",
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 10),
            textInput(
              hintText: "Şifre",
              controller: _controller,
              password: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "Sil",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Get.back(result: _controller.text),
          ),
          TextButton(
            child: Text("Vazgeç"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }
}
