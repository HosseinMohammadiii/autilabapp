import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({
    super.key,
    required this.timeAvailable,
  });

  final String timeAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AutilabColor.bb,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        timeAvailable,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
