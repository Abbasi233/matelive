import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePageController extends GetxController {
  var pageNo = 0.obs;

  void changePage(PageController _controller) {
    _controller.animateToPage(
      _controller.page.round() + 1,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void emitPageNumber(PageController _controller) {
    pageNo.value = _controller.page.round();
  }
}
