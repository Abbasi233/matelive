import 'package:flutter/material.dart';

import '/constant.dart';

Widget textInput(
    {String hintText,
    TextEditingController controller,
    bool password = false}) {
  return TextFormField(
    style: styleH4(),
    controller: controller,
    cursorColor: kPrimaryColor,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: customFont(
        18,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      hoverColor: kPrimaryColor,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(kTextInputBorderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(kTextInputBorderRadius),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    ),
    obscureText: password,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Lütfen bu alanı doldurun.';
      }
      return null;
    },
  );
}
