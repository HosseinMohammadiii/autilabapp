//Widget appBar for login section
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget appBarWidget({
  required BuildContext context,
  required String title,
  bool? isIcon,
  bool isMobile = true,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leadingWidth: double.infinity,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Visibility(
            visible: isIcon ?? false,
            replacement: Flexible(
              child: GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                child: Text(
                  title,
                  style: AutilabTextStyle.small18_400
                      .copyWith(fontSize: isMobile ? 18 : 28),
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(
                      'assets/icons/arrow_back.svg',
                      width: isMobile ? 24 : 48,
                      height: isMobile ? 24 : 48,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: AutilabTextStyle.small18_400
                      .copyWith(fontSize: isMobile ? 18 : 28),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
