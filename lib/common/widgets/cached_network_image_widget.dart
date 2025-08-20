import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/functions/cacheimahe_function.dart';

class CachednetworkimageWidget extends StatelessWidget {
  const CachednetworkimageWidget({
    super.key,
    this.isMobile = true,
    this.isShowShimmer = true,
    required this.imgUrl,
    required this.img,
    required this.isNetworkImage,
    this.width,
    this.height,
    this.borderRadius,
  });
  final bool isMobile;
  final bool isShowShimmer;
  final String imgUrl;
  final Widget img;
  final bool isNetworkImage;
  final double? width;
  final double? height;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return isNetworkImage
        ? CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
            errorListener: (value) {},
            errorWidget: (context, url, error) => SizedBox(
                  child: Image.asset(
                    'assets/images/avatar.png',
                    fit: BoxFit.cover,
                    width: isMobile ? 104 : 168,
                    height: isMobile ? 104 : 168,
                    cacheWidth:
                        cacheImageFunction(isMobile ? 104 : 168, context),
                    cacheHeight:
                        cacheImageFunction(isMobile ? 104 : 168, context),
                  ),
                ),
            placeholder: (context, url) {
              if (isShowShimmer) {
                Center(
                  child: Shimmer.fromColors(
                    baseColor: const Color(0xffE1E1E1),
                    highlightColor: const Color(0xffF3F3F2),
                    child: Container(
                      width: width ?? double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(borderRadius ?? 25),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            })
        : img;
  }
}
