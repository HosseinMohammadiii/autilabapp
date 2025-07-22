import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class TimeBoxDoctorCard extends StatelessWidget {
  const TimeBoxDoctorCard({
    super.key,
    this.isMobile = true,
  });
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 30 : 64,
      width: isMobile ? null : 400,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        border: Border.all(color: AutilabColor.bb),
        borderRadius: BorderRadius.circular(isMobile ? 12 : 24),
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
                  width: isMobile ? 16 : 40,
                  height: isMobile ? 16 : 40,
                  colorFilter: const ColorFilter.mode(
                    AutilabColor.blue,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  ' Tues 03 March ',
                  style: isMobile
                      ? AutilabTextStyle.medium14_500
                      : AutilabTextStyle.small24_400,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            height: isMobile ? 16 : 32,
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
                  width: isMobile ? 16 : 40,
                  height: isMobile ? 16 : 40,
                  colorFilter: const ColorFilter.mode(
                    AutilabColor.blue,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  '13:30',
                  style: isMobile
                      ? AutilabTextStyle.medium14_500
                      : AutilabTextStyle.small24_400,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
