import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '/constant.dart';

Widget showProgressIndicator(BuildContext context) =>
    (Theme.of(context).platform == TargetPlatform.android)
        ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
        : Center(child: CupertinoActivityIndicator());
