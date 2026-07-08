import 'package:autilab_project/common/widgets/cached_network_image_widget.dart';
// import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class SpecialtiesListWidget extends StatelessWidget {
  const SpecialtiesListWidget({
    super.key,
    this.isMobile = true,
    this.specialtyModel,
    required this.height,
    required this.width,
    this.heightImage,
    this.widthImage,
    this.radius,
    required this.textStyle,
  });
  final bool isMobile;
  final RecentVisitedModel? specialtyModel;
  final double height;
  final double width;
  final double? heightImage;
  final double? widthImage;
  final double? radius;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(
          left: 20,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(int.parse(specialtyModel?.codeColor ?? '0xffFF7979')),
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
                imgUrl: specialtyModel?.imagePath ?? '',
                width: widthImage,
                height: heightImage,
                boxFit: BoxFit.scaleDown,
                isShowShimmer: false,
                borderRadius: 8,
                img: Image.asset(specialtyModel?.imagePath ??
                    'assets/images/behaviorism_image.png'),
                // isNetworkImage:
                //     specialtyModel?.imagePath != null ? true : false,
                isNetworkImage: false,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  specialtyModel?.name.replaceAll(' ', '\n') ?? 'ddd',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
