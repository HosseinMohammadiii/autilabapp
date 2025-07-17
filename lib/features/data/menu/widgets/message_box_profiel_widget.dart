import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';

class MesseageBoxProfile extends StatelessWidget {
  const MesseageBoxProfile({
    super.key,
    required this.isMessage,
    this.content,
  });
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
        height: 71,
        padding: const EdgeInsets.all(10),
        margin: AutilabMargin.marginFullScreen,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AutilabColor.bb),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          spacing: 11,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/doctor_image.jpg',
                width: 45,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dr. Sophia Martinez',
                    style: AutilabTextStyle.medium14_500,
                  ),
                  Text(
                    'Use of social networks of experts and families',
                    style: AutilabTextStyle.small12_400
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isMessage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AutilabColor.yellow,
                ),
                child: Text(
                  content ?? '',
                  style: AutilabTextStyle.medium12_500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
