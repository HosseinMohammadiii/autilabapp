import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class NotificationBoxWidget extends StatelessWidget {
  const NotificationBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: AutilabMargin.marginFullScreen,
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        border: Border.all(color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 12,
        children: [
          Image.asset('assets/images/notification_image.png'),
          Text(
            'Someone’s Liked Your Post',
            style: AutilabTextStyle.small14_400,
          ),
        ],
      ),
    );
  }
}
