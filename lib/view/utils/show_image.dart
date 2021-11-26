import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/constant.dart';
import '/model/user_detail.dart';

Widget showImage(
    {String imageUrl, List<Gallery> gallery, int galleryIndex = 0}) {
  final pageController = PageController(initialPage: galleryIndex);
  return GestureDetector(
    onTap: () => Get.back(),
    child: Container(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: EdgeInsets.all(Get.width * 0.06),
        child: gallery != null
            ? PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemCount: gallery.length,
                itemBuilder: (context, index) => Image.network(
                  gallery[index].image,
                  fit: BoxFit.contain,
                ),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, provider) => Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: kPrimaryColor,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
      ),
    ),
  );
}
