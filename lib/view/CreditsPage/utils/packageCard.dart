import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matelive/view/utils/primaryButton.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '/constant.dart';

Widget packageCard(
        {String title,
        double price,
        String packageName,
        bool mostPopuler = false}) =>
    Container(
      height: 300,
      margin: EdgeInsets.only(top: 30),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: kTextColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Container(
          foregroundDecoration: mostPopuler
              ? RotatedCornerDecoration(
                  color: kPrimaryColor,
                  geometry: BadgeGeometry(
                      width: 115, height: 115, cornerRadius: kBorderRadius),
                  textSpan: TextSpan(
                    text: "En Sevilen!",
                    style: customFont(
                      22,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : null,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    styleH3(fontWeight: FontWeight.w600, color: kTextColorSoft),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                price.toStringAsFixed(2) + " TL",
                style: styleH1(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor,
                ),
              ),
              Text(
                packageName,
                style: styleH5(fontWeight: FontWeight.w500),
              ),
              primaryButton(text: Text("Paketi Seç"), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
