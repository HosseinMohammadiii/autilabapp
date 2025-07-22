import 'package:autilab_project/features/data/home/widgets/time_box_doctor_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class DoctorBoxDetialAppointmentWidget extends StatelessWidget {
  const DoctorBoxDetialAppointmentWidget({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: AutilabMargin.marginFullScreen,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        height: 116,
        child: Row(
          spacing: 12,
          children: [
            SizedBox(
              width: 116,
              height: 116,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Dr. Sophia Martinez',
                      style: AutilabTextStyle.medium18_500,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
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
                        Text(
                          '5.0',
                          style: AutilabTextStyle.small14_400,
                        ),
                      ],
                    ),
                  ),
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: TimeBoxDoctorCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
