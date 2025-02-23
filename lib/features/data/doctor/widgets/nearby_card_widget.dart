import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class NearbyCardWidget extends StatelessWidget {
  const NearbyCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 445,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 12,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/autism_help_center.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Autism Help Center',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
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
            height: 16,
          ),
          SizedBox(
            height: 72,
            child: Text(
              'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    overflow: TextOverflow.fade,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          CustomButtonWidget(
            onTap: () {},
            height: 50,
            margin: const EdgeInsets.only(bottom: 8, top: 8),
            color: AutilabColor.bb,
            text: 'See Details',
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
