import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/color_constant.dart';

class DrawerBoxWidget extends StatelessWidget {
  const DrawerBoxWidget({
    super.key,
    required this.drawerItem,
    required this.onTap,
  });

  final List<DrawerItemClass> drawerItem;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AutilabColor.drawerWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        itemCount: drawerItem.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () => onTap(index),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: drawerItem[index].backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(drawerItem[index].icon),
                    ),
                    Expanded(
                      child: Text(
                        drawerItem[index].title,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              if (index != drawerItem.length - 1)
                const Divider(
                  thickness: 0.5,
                  color: AutilabColor.bb,
                ),
            ],
          );
        },
      ),
    );
  }
}

class DrawerItemClass {
  String title;
  String icon;
  Color backgroundColor;
  DrawerItemClass(this.title, this.icon, this.backgroundColor);
}
