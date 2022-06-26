import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget deleteMessageDialog() => AlertDialog(
      title: Text("Silme İşlemi"),
      content: Text("Mesajı silmek istediğinize emin misiniz?"),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: true),
          child: Text(
            "Sil",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text("Vazgeç"),
        ),
      ],
    );
