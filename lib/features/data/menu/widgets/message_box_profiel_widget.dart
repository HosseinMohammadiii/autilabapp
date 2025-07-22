import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';

class MesseageBoxProfile extends StatelessWidget {
  const MesseageBoxProfile({
    super.key,
    this.isMobile = true,
    required this.isMessage,
    this.content,
  });
  final bool isMobile;
  final bool isMessage;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AutiLabRoutes.doctorMessageScreen,
          extra: {
            'image': 'assets/images/doctor_image.jpg',
            'name': 'Dr. Sophia Martinez',
            'expertise': 'Speech Therapy',
          },
        );
      },
      child: Container(
        height: isMobile ? 71 : 112,
        padding: EdgeInsets.all(isMobile ? 10 : 16),
        margin: AutilabMargin.marginFullScreen,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
        ),
        child: Row(
          spacing: 11,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/doctor_image.jpg',
                width: isMobile ? 45 : 80,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dr. Sophia Martinez',
                    style: AutilabTextStyle.medium14_500.copyWith(
                      fontSize: isMobile ? 14 : 18,
                    ),
                  ),
                  Text(
                    'Use of social networks of experts and families',
                    overflow: TextOverflow.ellipsis,
                    style: AutilabTextStyle.small12_400.copyWith(
                      color: AutilabColor.gray,
                      fontSize: isMobile ? 12 : 16,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isMessage,
              child: Container(
                width: isMobile ? 26 : 40,
                height: isMobile ? 26 : 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AutilabColor.yellow,
                ),
                child: Text(
                  content ?? '',
                  style: AutilabTextStyle.medium12_500.copyWith(
                    fontSize: isMobile ? 12 : 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
