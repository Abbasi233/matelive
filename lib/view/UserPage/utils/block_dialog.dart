import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BlockDialog extends StatefulWidget {
  const BlockDialog({Key key}) : super(key: key);
  @override
  _BlockDialogState createState() => _BlockDialogState();
}

class _BlockDialogState extends State<BlockDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.all(20),
      child: AlertDialog(
        title: Text("Engelle"),
        content: Text("Bu kullanıcıyı engellemek istediğinize emin misiniz."),
        actions: [
          TextButton(
            child: Text(
              "Engelle",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Get.back(result: true),
          ),
          TextButton(
            child: Text("Vazgeç"),
            onPressed: () => Get.back(result: false),
          ),
        ],
      ),
    );
  }
}
