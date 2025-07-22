import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class NotificationBoxWidget extends StatelessWidget {
  const NotificationBoxWidget({
    super.key,
    this.isMobile = true,
  });
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 64 : 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: AutilabMargin.marginFullScreen,
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        border: Border.all(color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
      ),
      child: Row(
        spacing: 12,
        children: [
          Image.asset(
            'assets/images/notification_image.png',
            width: isMobile ? 32 : 68,
            height: isMobile ? 32 : 68,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Text(
              'Someone’s Liked Your Post',
              overflow: TextOverflow.ellipsis,
              style: AutilabTextStyle.small14_400.copyWith(
                fontSize: isMobile ? 14 : 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
