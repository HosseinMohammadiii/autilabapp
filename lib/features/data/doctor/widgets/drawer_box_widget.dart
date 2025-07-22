import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class DrawerBoxWidget extends StatelessWidget {
  const DrawerBoxWidget({
    super.key,
    this.isMobile = true,
    required this.drawerItem,
    required this.onTap,
  });
  final bool isMobile;
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
                      width: isMobile ? 24 : 40,
                      height: isMobile ? 24 : 40,
                      padding: EdgeInsets.all(isMobile ? 6 : 8),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: drawerItem[index].backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        drawerItem[index].icon,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        drawerItem[index].title,
                        style: AutilabTextStyle.small14_400.copyWith(
                          fontSize: isMobile ? 14 : 20,
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
