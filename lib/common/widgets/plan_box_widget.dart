import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';

class PlanBoxWidget extends StatelessWidget {
  const PlanBoxWidget({
    super.key,
    required this.title,
    this.description,
    required this.titleButton,
    required this.margin,
    this.widget,
    this.boxShadow,
    this.backgroundColor,
    this.borderColor,
    required this.onTap,
  });
  final String title;
  final String? description;
  final String titleButton;
  final double margin;
  final Widget? widget;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
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

    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(right: margin),
        decoration: BoxDecoration(
          color: backgroundColor ?? AutilabColor.white,
          border: Border.all(color: borderColor ?? AutilabColor.bb),
          borderRadius: BorderRadius.circular(24),
          boxShadow: boxShadow,
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
            Text(
              description ??
                  'An Initial Test To Determine How Much You\nAre At Risk Of Cancer Based Dr. Mitchell H',
              style: AutilabTextStyle.small16_400,
            ),
            const SizedBox(
              height: 32,
            ),
            widget ?? const SizedBox(),
            CustomButtonWidget(
              onTap: () => onTap(),
              height: 50,
              margin: const EdgeInsets.only(top: 32),
              color: AutilabColor.bb,
              text: titleButton,
              textStyle: AutilabTextStyle.small18_400,
            ),
          ],
        ),
      ),
    );
  }
}
