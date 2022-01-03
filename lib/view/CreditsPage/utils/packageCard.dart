import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '/constant.dart';
import '/model/login.dart';
import '/model/credit.dart';
import '/model/profile_detail.dart';
import '/view/utils/primaryButton.dart';
import '/controller/in-app-purchase.dart';
import '/view/CreditsPage/utils/base64.dart';

Widget creditCard({Credit credit, bool mostPopuler = false}) => Container(
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
                credit.title,
                style:
                    styleH3(fontWeight: FontWeight.w600, color: kTextColorSoft),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                credit.price.split(String.fromCharCode(160))[1] + " TL",
                style: styleH1(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor,
                ),
              ),
              Text(
                credit.description,
                style: styleH5(fontWeight: FontWeight.w500),
              ),
              primaryButton(
                text: Text("Paketi Seç"),
                onPressed: () {
                  var iapController = Get.find<IAPController>();
                  var userId = ProfileDetail().id;
                  var creditToken = toBase64(
                      toBase64((userId * 27 * 13).toString()) +
                          toBase64(Login().token) +
                          toBase64(toBase64(credit.id)) +
                          toBase64((userId * (userId + 15122021)).toString()));
                  iapController.requestBody = {
                    "token": creditToken,
                    "credit_pack_id": credit.id,
                  };
                  iapController.buy(credit);
                },
              ),
            ],
          ),
        ),
      ),
    );
