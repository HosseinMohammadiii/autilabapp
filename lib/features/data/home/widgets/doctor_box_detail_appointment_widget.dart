import 'package:autilab_project/features/data/home/widgets/time_box_doctor_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class DoctorBoxDetialAppointmentWidget extends StatelessWidget {
  const DoctorBoxDetialAppointmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: AutilabMargin.marginFullScreen,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          FittedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/doctor_image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const FittedBox(
                  child: Text(
                    'Dr. Sophia Martinez',
                    style: AutilabTextStyle.medium18_500,
                  ),
                ),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        'Psychotherapy',
                        style: AutilabTextStyle.small14_400.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xffEDC757),
                      ),
                      const Text(
                        '5.0',
                        style: AutilabTextStyle.small14_400,
                      ),
                    ],
                  ),
                ),
                const FittedBox(
                  child: TimeBoxDoctorCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
