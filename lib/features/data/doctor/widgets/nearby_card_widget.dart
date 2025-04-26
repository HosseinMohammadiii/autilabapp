import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';

class NearbyCardWidget extends StatelessWidget {
  const NearbyCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/autism_help_center.png',
              fit: BoxFit.fill,
              width: 320,
              height: 213,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Autism Help Center',
                    style: AutilabTextStyle.medium18_500,
                  ),
                ),
                ButtonCard(
                  onTap: () {},
                  margin: const EdgeInsets.only(right: 8),
                  icon: 'assets/icons/heart.svg',
                ),
                ButtonCard(
                  onTap: () {},
                  margin: const EdgeInsets.all(0),
                  icon: 'assets/icons/messages.svg',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 72,
            child: Text(
              'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
              style: AutilabTextStyle.small14_400.copyWith(
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          CustomButtonWidget(
            onTap: () {
              context.pushNamed(AutiLabRoutes.nearbyCenterDetailScreen);
            },
            height: 50,
            margin: const EdgeInsets.only(bottom: 8, top: 24),
            color: AutilabColor.bb,
            text: 'See Details',
            textStyle: AutilabTextStyle.small18_400,
          ),
        ],
      ),
    );
  }
}
