import 'package:flutter/material.dart';

import '../../constant.dart';

Widget footer() => Column(
      children: [
        fixedHeight,
        Center(
            child: Text(
                "${DateTime.now().year} © Matelive Tüm Hakları Saklıdır.")),
        fixedHeight,
      ],
    );
