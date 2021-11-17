import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matelive/constant.dart';
import 'package:matelive/model/profile_detail.dart';
import 'package:matelive/view/utils/show_image.dart';

class GalleryCard extends StatefulWidget {
  const GalleryCard({Key key}) : super(key: key);

  @override
  _GalleryCardState createState() => _GalleryCardState();
}

class _GalleryCardState extends State<GalleryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text("Fotoğraf Galerisi", style: styleH2(),),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemCount: ProfileDetail().gallery.length + 1,
            itemBuilder: (context, index) {
              if (index != ProfileDetail().gallery.length) {
                return GestureDetector(
                  onTap: () {
                    Get.dialog(showImage(ProfileDetail().gallery[index].image));
                  },
                  child: CachedNetworkImage(
                    imageUrl: ProfileDetail().gallery[index].image,
                    imageBuilder: (context, provider) => Container(
                      decoration: BoxDecoration(
                        image:
                            DecorationImage(image: provider, fit: BoxFit.cover),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: kPrimaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              }
              return IconButton(
                icon: Icon(
                  Icons.add_box_rounded,
                  color: kPrimaryColor,
                ),
                iconSize: 48,
                onPressed: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
