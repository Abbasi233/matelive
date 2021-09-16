import 'package:flutter/material.dart';

import '/constant.dart';
import '/extensions.dart';

Widget comment({String description, DateTime dateTime, Function onPressed}) =>
    Container(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kTextColor,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  description,
                  style: styleH5(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      dateTime.format(),
                      style: styleH6().copyWith(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(width: 10),
                    TextButton.icon(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.delete,
                        color: kOrangeColor,
                      ),
                      label: Text(
                        "Sil",
                        style: styleH6(color: kOrangeColor)
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
