import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:matelive/constant.dart';
import 'package:matelive/view/utils/appBar.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage(this.asset, this.title, {Key key}) : super(key: key);
  final String asset;
  final String title;

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        child: Text(
          widget.title,
          style: styleH4(),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SfPdfViewer.asset(
          widget.asset,
        ),
      ),
    );
  }
}
