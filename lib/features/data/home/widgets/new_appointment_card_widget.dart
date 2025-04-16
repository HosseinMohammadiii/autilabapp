import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

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
        children: [
          Row(
            spacing: 4,
            children: [
              Container(
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  statusIcon,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
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
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          Row(
            spacing: 12,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(image),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  const Text(
                    'Dr. Sophia Martinez',
                    style: AutilabTextStyle.medium18_500,
                  ),
                  Row(
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
                  Container(
                    height: 32,
                    width: 186,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xffECF0FF),
                      border: Border.all(color: AutilabColor.bb),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          colorFilter: const ColorFilter.mode(
                            AutilabColor.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Text(
                          ' Tues 03 March ',
                          style: AutilabTextStyle.medium12_500,
                        ),
                        Container(
                          height: 16,
                          width: 2,
                          decoration: const BoxDecoration(
                            color: AutilabColor.bb,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/clock_icon.svg',
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
            ],
          ),
          CustomButtonWidget(
            onTap: () => onTap(),
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
