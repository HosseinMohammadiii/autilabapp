import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class ToolsBoxWidget extends StatelessWidget {
  const ToolsBoxWidget({
    super.key,
    required this.title,
    required this.description,
    required this.titleButton,
    required this.svg,
    required this.onTap,
  });
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
          SvgPicture.asset(svg),
          Text(
            title,
            style: AutilabTextStyle.medium18_500,
          ),
          Text(
            description,
            style: AutilabTextStyle.small14_400,
            textAlign: TextAlign.center,
          ),
          CustomButtonWidget(
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
