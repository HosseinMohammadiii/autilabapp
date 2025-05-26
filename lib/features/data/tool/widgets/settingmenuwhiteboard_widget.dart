import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../doctor/widgets/drawer_box_widget.dart';

class SettingMenuWidget extends StatelessWidget {
  const SettingMenuWidget({
    super.key,
    required this.settingItems,
  });

  final List<DrawerItemClass> settingItems;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32,
      child: Container(
        width: 152,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: AutilabColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: settingItems.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: settingItems[index].backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                            'assets/icons/${settingItems[index].icon}'),
                      ),
                      Text(
                        settingItems[index].title,
                        style: AutilabTextStyle.small14_400,
                      ),
                    ],
                  ),
                ),
                if (index < settingItems.length - 1)
                  const Divider(
                    thickness: .5,
                    endIndent: 14,
                    indent: 14,
                    color: AutilabColor.bb,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
