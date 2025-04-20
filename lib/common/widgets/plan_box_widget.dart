import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';

class PlanBoxWidget extends StatelessWidget {
  const PlanBoxWidget({
    super.key,
    required this.title,
    required this.margin,
    required this.onTap,
  });
  final String title;
  final double margin;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    //Widget for display plans title
    Widget titlePlanWidget({
      required String title,
    }) {
      return Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AutilabColor.yellow,
            ),
            child: SvgPicture.asset(
              'assets/icons/crown_icon.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(
            title,
            style: AutilabTextStyle.medium24_500,
          ),
        ],
      );
    }

//Display description plans cards
    Widget descriptionPlanWidget() {
      return Row(
        children: [
          Container(
            width: 23,
            height: 23,
            margin: const EdgeInsets.only(right: 4),
            decoration: const BoxDecoration(
              color: AutilabColor.yellow,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/tick_icon.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          const Text(
            ' Initial Test To Determine How Much You Are',
            style: AutilabTextStyle.small14_400,
          ),
        ],
      );
    }

    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(right: margin),
      decoration: BoxDecoration(
        color: AutilabColor.white,
        border: Border.all(color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titlePlanWidget(
            title: title,
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 0.5,
            color: AutilabColor.black,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'An Initial Test To Determine How Much You Are At Risk Of Cancer Based Dr. Mitchell H',
            style: AutilabTextStyle.small16_400,
          ),
          const SizedBox(
            height: 32,
          ),
          descriptionPlanWidget(),
          const SizedBox(
            height: 8,
          ),
          descriptionPlanWidget(),
          const SizedBox(
            height: 8,
          ),
          descriptionPlanWidget(),
          const SizedBox(
            height: 8,
          ),
          descriptionPlanWidget(),
          CustomButtonWidget(
            onTap: () => onTap(),
            height: 50,
            margin: const EdgeInsets.only(top: 32),
            color: AutilabColor.bb,
            text: 'See Advance Package',
            textStyle: AutilabTextStyle.small18_400,
          ),
        ],
      ),
    );
  }
}
