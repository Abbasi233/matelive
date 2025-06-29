import 'package:flutter/material.dart';

import '/constant.dart';

Widget miniCard(String title, Widget value, Color lineColor) => Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: kTextColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Column(
            children: [
              Text(
                title,
                style: styleH6(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              value,
              SizedBox(height: 5),
              Container(
                height: 7,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: lineColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
