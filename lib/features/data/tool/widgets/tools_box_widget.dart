import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class ToolsBoxWidget extends StatelessWidget {
  const ToolsBoxWidget({
    super.key,
    this.isMobile = true,
    required this.title,
    required this.description,
    required this.titleButton,
    required this.svg,
    required this.onTap,
  });
  final bool isMobile;
  final String title;
  final String description;
  final String titleButton;
  final String svg;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AutilabMargin.marginFullScreen,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 16,
        children: [
          SizedBox(
            width: isMobile ? null : 470,
            height: isMobile ? null : 280,
            child: SvgPicture.asset(svg),
          ),
          Text(
            title,
            style: AutilabTextStyle.medium18_500.copyWith(
              fontSize: isMobile ? 18 : 28,
            ),
          ),
          Text(
            description,
            style: AutilabTextStyle.small14_400.copyWith(
              fontSize: isMobile ? 14 : 24,
            ),
            textAlign: TextAlign.center,
          ),
          CustomButtonWidget(
            isMobile: isMobile,
            onTap: () => onTap(),
            height: 50,
            margin: const EdgeInsets.all(0),
            color: AutilabColor.bb,
            text: titleButton,
            textStyle: AutilabTextStyle.small18_400,
          ),
        ],
      ),
    );
  }
}
