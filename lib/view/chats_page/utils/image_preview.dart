import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matelive/controller/getX/chat_controller.dart';
import 'package:matelive/view/utils/appBar.dart';

import '../../../constant.dart';

class ChatImagePreview extends StatelessWidget {
  ChatImagePreview(this.image, {Key key}) : super(key: key);
  final XFile image;
  final chatController = Get.find<ChatController>();

  final messageController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        child: Text(
          "Resim Önizlemesi",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.file(
              File(image.path),
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25),
                        ),
                        color: Colors.white,
                      ),
                      child: Material(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25),
                          right: Radius.circular(25),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  hintText: "Mesaj Giriniz...",
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: kPrimaryColor,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () => Get.back(result: messageController.text),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade900,
    );
  }
}
