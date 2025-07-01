import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class TimeBoxDoctorCard extends StatelessWidget {
  const TimeBoxDoctorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      // alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        border: Border.all(color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AutilabColor.blue,
                    BlendMode.srcIn,
                  ),
                ),
                const Text(
                  ' Tues 03 March ',
                  style: AutilabTextStyle.medium12_500,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            height: 16,
            width: 2,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              color: AutilabColor.bb,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              spacing: 2,
              children: [
                SvgPicture.asset(
                  'assets/icons/clock_icon.svg',
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AutilabColor.blue,
                    BlendMode.srcIn,
                  ),
                ),
                const Text(
                  '13:30',
                  style: AutilabTextStyle.medium12_500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
