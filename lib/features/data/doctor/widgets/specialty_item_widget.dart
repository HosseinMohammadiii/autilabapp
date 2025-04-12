import 'package:flutter/material.dart';

import '../../../../utils/Lists/category_items.dart';

class SpecialtyItemWidget extends StatelessWidget {
  const SpecialtyItemWidget({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: categoryItemsList[index].color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Image.asset(
            categoryItemsList[index].image,
            width: 32,
            height: 32,
          ),
          Text(
            categoryItemsList[index].title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
