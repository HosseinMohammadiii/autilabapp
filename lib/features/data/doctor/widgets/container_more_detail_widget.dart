import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class ContainerDetailBox extends StatelessWidget {
  const ContainerDetailBox({
    super.key,
    required this.detail,
  });
  final String detail;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height / 3,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 48),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        border: Border.all(width: 0.5, color: AutilabColor.gray),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        detail,
        style: AutilabTextStyle.small14_400,
      ),
    );
  }
}
