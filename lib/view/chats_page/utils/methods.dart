import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '/view/utils/progressIndicator.dart';

Widget customFooter() {
  return CustomFooter(
    height: 100,
    loadStyle: LoadStyle.ShowWhenLoading,
    builder: (BuildContext context, LoadStatus mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text("Yüklemek için kaydırın");
      } else if (mode == LoadStatus.loading) {
        body = showProgressIndicator(context);
      } else if (mode == LoadStatus.failed) {
        body = Text("Yüklenirken hata oluştu. Tekrar deneyin.");
      } else if (mode == LoadStatus.canLoading) {
        body = Text("Yüklemek için bırakın");
      } else {
        body = Text("Liste Sonu");
      }
      return Container(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
