import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:matelive/constant.dart';

Widget showProgressIndicator(BuildContext context) =>
    (Theme.of(context).platform == TargetPlatform.android)
        ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
        : Center(child: CupertinoActivityIndicator());
