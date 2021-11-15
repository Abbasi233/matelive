import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void showProgressDialog() => Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: _showProgressIndicator(),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("İşlem Yapılıyor")],
          ),
        ),
      ),
      barrierDismissible: false,
    );

void closeProgressDialog() => Get.back();

Widget _showProgressIndicator() => Platform.isAndroid
    ? const Center(child: CircularProgressIndicator())
    : const Center(child: CupertinoActivityIndicator());
