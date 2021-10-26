import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:matelive/view/UserPage/user_page.dart';
import 'package:matelive/view/utils/primaryButton.dart';

Widget userCard({
  @required String username,
  @required String age,}
) {
  const double _fixedSize = 40;
  return Card(
    margin: const EdgeInsets.only(bottom: 30),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius)),
    elevation: 4,
    child: Container(
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/avatar.png"),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  stops: [
                    0.03,
                    0.9
                  ]),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Icon(LineAwesomeIcons.hand_pointing_right_1),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(55, _fixedSize),
                          fixedSize: Size(_fixedSize, _fixedSize),
                          shape: CircleBorder(),
                          primary: kWhiteColor, // <-- Button color
                          onPrimary: kBlackColor, // <-- Splash color
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Icon(LineAwesomeIcons.heart),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(55, _fixedSize),
                          fixedSize: Size(_fixedSize, _fixedSize),
                          shape: CircleBorder(),
                          primary: kWhiteColor, // <-- Button color
                          onPrimary: kBlackColor, // <-- Splash color
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Center(
                          child: Icon(LineAwesomeIcons.bookmark),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(55, _fixedSize),
                          fixedSize: Size(_fixedSize, _fixedSize),
                          shape: CircleBorder(),
                          primary: kWhiteColor, // <-- Button color
                          onPrimary: kBlackColor, // <-- Splash color
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: styleH2(color: kWhiteColor),
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          age,
                          style: styleH4(color: kWhiteColor),
                        ),
                        primaryButton(
                            padding: Get.width * 0.1,
                            text: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LineAwesomeIcons.user),
                                SizedBox(width: 5),
                                Text("Profil"),
                              ],
                            ),
                            onPressed: () {
                              Get.to(()=> UserPage(username));
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
