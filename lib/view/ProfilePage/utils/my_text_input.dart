import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final bool enabled;
  final bool obscureText;
  final bool validate;
  final TextInputType textInputType;
  final TextEditingController controller;
  MyTextInput(
      {this.hintText,
      this.controller,
      this.enabled = true,
      this.obscureText = false,
      this.validate = false,
      this.textInputType = TextInputType.text,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
            fontSize: 18,
          ),
          cursorColor: Color(0xffdc1b43),
          maxLines: maxLines,
          keyboardType: textInputType,
          enabled: enabled,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xff737373),
              letterSpacing: 0.5,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffdc1b43), width: 2),
            ),
          ),
          validator: validate
              ? (value) {
                  if (value.trim().isEmpty) {
                    return "Lütfen bu alanı doldurun";
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}
