import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachednetworkimageWidget extends StatelessWidget {
  const CachednetworkimageWidget({
    super.key,
    required this.imgUrl,
    required this.img,
    required this.isNetworkImage,
    this.width,
    this.height,
  });
  final String imgUrl;
  final Widget img;
  final bool isNetworkImage;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? CachedNetworkImage(
            imageUrl: imgUrl,
            errorWidget: (context, url, error) => const SizedBox(),
            placeholder: (context, url) => Center(
              child: Shimmer.fromColors(
                baseColor: const Color(0xffE1E1E1),
                highlightColor: const Color(0xffF3F3F2),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          )
        : img;
  }
}
