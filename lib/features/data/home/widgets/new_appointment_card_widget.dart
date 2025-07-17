import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import 'box_shape_widget.dart';
import 'time_box_doctor_card_widget.dart';

class NewAppointmentsCardWidget extends StatelessWidget {
  const NewAppointmentsCardWidget({
    super.key,
    required this.color,
    this.backgroundColor,
    this.isShowRate = false,
    required this.title,
    required this.statusIcon,
    required this.margin,
    required this.onTap,
    required this.raiteOnTap,
    required this.image,
  });
  final Function() onTap;
  final Function() raiteOnTap;
  final String image;
  final bool isShowRate;
  final Color color;
  final Color? backgroundColor;
  final String title;
  final String statusIcon;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(16),
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
              if (isShowRate) ...[
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AutiLabRoutes.ratingScreen);
                  },
                  child: Container(
                    height: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AutilabColor.bb,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xffEDC757),
                          size: 16,
                        ),
                        Text(
                          'Rate Now',
                          style: AutilabTextStyle.small12_400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          const Spacer(),
          SizedBox(
            height: 116,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dr. Sophia Martinez',
                          overflow: TextOverflow.ellipsis,
                          style: AutilabTextStyle.medium18_500,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Speech Therapy',
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
          ),
          const Spacer(),
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
