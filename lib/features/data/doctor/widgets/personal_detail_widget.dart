import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/theme_constant.dart';

class PersonalDetailWidget extends StatelessWidget {
  const PersonalDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/profile_icon.svg'),
        const SizedBox(
          width: 4,
        ),
        const Text(
          'Personal Details',
          style: AutilabTextStyle.medium18_500,
        ),
      ],
    );
  }
}
