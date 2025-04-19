import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/Lists/category_items.dart';

class SpecialtiesListWidget extends StatelessWidget {
  const SpecialtiesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 113,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryItemsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.goNamed(AutiLabRoutes.doctorSpecialityScreen);
            },
            child: Container(
              height: 113,
              width: 132,
              margin: EdgeInsets.only(
                right: index == categoryItemsList.length - 1 ? 0 : 20,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: categoryItemsList[index].color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(categoryItemsList[index].image),
                  Text(
                    categoryItemsList[index].title,
                    style: AutilabTextStyle.medium14_500,
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
