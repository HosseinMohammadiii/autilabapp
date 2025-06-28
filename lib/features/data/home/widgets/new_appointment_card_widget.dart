import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import 'box_shape_widget.dart';
import 'time_box_doctor_card_widget.dart';

class NewAppointmentsCardWidget extends StatelessWidget {
  const NewAppointmentsCardWidget({
    super.key,
    required this.color,
    required this.title,
    required this.statusIcon,
    required this.margin,
    required this.onTap,
    required this.image,
  });
  final Function() onTap;
  final String image;
  final Color color;
  final String title;
  final String statusIcon;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      margin: margin,
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Row(
              spacing: 4,
              children: [
                StatusShapeWidget(color: color, statusIcon: statusIcon),
                const Text(
                  'Status :',
                  style: AutilabTextStyle.medium14_500,
                ),
                Text(
                  title,
                  style: AutilabTextStyle.medium14_500,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          SizedBox(
            height: 115,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 116,
                        height: 116,
                        child: Image.asset(
                          image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          ),
          CustomButtonWidget(
            onTap: () {
              onTap();
            },
            height: 50,
            margin: const EdgeInsets.all(0),
            color: AutilabColor.bb,
            text: 'Detail Appointment',
            textStyle: AutilabTextStyle.small18_400,
          ),
        ],
      ),
    );
  }
}
