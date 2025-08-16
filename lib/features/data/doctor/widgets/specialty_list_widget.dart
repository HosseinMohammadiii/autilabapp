import 'package:autilab_project/common/widgets/cached_network_image_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/Lists/category_items.dart';
import '../../../../utils/functions/cacheimahe_function.dart';

class SpecialtiesListWidget extends StatelessWidget {
  const SpecialtiesListWidget({
    super.key,
    this.isMobile = true,
    this.recentModel,
    required this.height,
    required this.width,
    this.heightImage,
    this.widthImage,
    this.radius,
    this.itemCount,
    required this.textStyle,
  });
  final bool isMobile;
  final List<RecentVisitedModel>? recentModel;
  final double height;
  final double width;
  final double? heightImage;
  final double? widthImage;
  final double? radius;
  final int? itemCount;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentModel?.length ?? categoryItemsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(AutiLabRoutes.doctorSpecialityScreen);
            },
            child: Container(
              height: height,
              width: width,
              margin: EdgeInsets.only(
                left: index == 0 ? 20 : 0,
                right: index == categoryItemsList.length - 1 ? 8 : 14,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: categoryItemsList[index].color,
                borderRadius: BorderRadius.circular(radius ?? 24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: widthImage ?? 56,
                    height: heightImage ?? 56,
                    child: CachednetworkimageWidget(
                      imgUrl: recentModel?[index].imagePath ?? '',
                      width: widthImage,
                      height: heightImage,
                      isShowShimmer: false,
                      borderRadius: 8,
                      img: Image.asset(
                        categoryItemsList[index].image,
                        cacheWidth: cacheImageFunction(
                            widthImage?.toInt() ?? 56, context),
                        cacheHeight: cacheImageFunction(
                            widthImage?.toInt() ?? 56, context),
                      ),
                      isNetworkImage:
                          recentModel?[index].imagePath != null ? true : false,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        recentModel?[index].name.replaceAll(' ', '\n') ??
                            categoryItemsList[index].title,
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
