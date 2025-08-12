import 'package:autilab_project/features/data/home/widgets/time_box_doctor_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/cacheimahe_function.dart';

class DoctorBoxDetialAppointmentWidget extends StatelessWidget {
  const DoctorBoxDetialAppointmentWidget({
    super.key,
    required this.image,
    this.doctorName,
    this.doctorSpecialtyl,
    this.isMobile = true,
  });
  final String? doctorName;
  final String? doctorSpecialtyl;
  final String image;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 150 : 248,
      width: double.infinity,
      margin: AutilabMargin.marginFullScreen,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        height: isMobile ? 116 : 200,
        child: Row(
          spacing: isMobile ? 12 : 25,
          children: [
            SizedBox(
              width: isMobile ? 116 : 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                child: Image.asset(
                  image,
                  cacheWidth: cacheImageFunction(isMobile ? 116 : 200, context),
                  cacheHeight:
                      cacheImageFunction(isMobile ? 116 : 200, context),
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
                      doctorName ?? 'Dr. Sophia Martinez',
                      style: isMobile
                          ? AutilabTextStyle.medium18_500
                          : AutilabTextStyle.medium18_500
                              .copyWith(fontSize: 32),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          doctorSpecialtyl ?? 'Psychotherapy',
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile ? 14 : 24,
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
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile ? 14 : 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: TimeBoxDoctorCard(
                      isMobile: isMobile,
                    ),
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
