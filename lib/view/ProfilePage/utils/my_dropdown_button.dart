import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final String defaultText;
  final List<String> values; //Just mockup for now.

  MyDropdownButton(this.defaultText, this.values);

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: DropdownButton<String>(
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
        items: widget.values.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        isExpanded: true,
        style: TextStyle(
          color: Color(0xff737373),
          letterSpacing: 0.5,
        ),
        hint: Text(
          _selectedValue,
          style: TextStyle(
            color: Color(0xff737373),
            letterSpacing: 0.5,
          ),
        ),
        icon: ImageIcon(
          Image.asset('assets/icons/arrow_expand.png').image,
          size: 16,
        ),
      ),
    );
  }
}
