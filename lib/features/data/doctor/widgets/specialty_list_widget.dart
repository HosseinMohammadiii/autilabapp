import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/Lists/category_items.dart';

class SpecialtiesListWidget extends StatelessWidget {
  const SpecialtiesListWidget({
    super.key,
    required this.height,
    required this.width,
    this.heightImage,
    this.widthImage,
    this.radius,
    required this.textStyle,
  });
  final double height;
  final double width;
  final double? heightImage;
  final double? widthImage;
  final double? radius;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItemsList.length,
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
                children: [
                  SizedBox(
                    width: widthImage ?? 56,
                    height: heightImage ?? 56,
                    child: Image.asset(
                      categoryItemsList[index].image,
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      categoryItemsList[index].title,
                      style: textStyle,
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
