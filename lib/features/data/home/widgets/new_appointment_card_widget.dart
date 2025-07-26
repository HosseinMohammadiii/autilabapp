import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/cacheimahe_function.dart';
import 'box_shape_widget.dart';
import 'time_box_doctor_card_widget.dart';

class NewAppointmentsCardWidget extends StatelessWidget {
  const NewAppointmentsCardWidget({
    super.key,
    required this.color,
    this.backgroundColor,
    this.isMobile = true,
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
  final bool isMobile;
  final bool isShowRate;
  final Color color;
  final Color? backgroundColor;
  final String title;
  final String statusIcon;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 4,
            children: [
              StatusShapeWidget(
                color: color,
                statusIcon: statusIcon,
                isMobile: isMobile,
              ),
              Text(
                'Status :',
                style: AutilabTextStyle.medium14_500
                    .copyWith(fontSize: isMobile ? 14 : 20),
              ),
              Text(
                title,
                style: AutilabTextStyle.medium14_500
                    .copyWith(fontSize: isMobile ? 14 : 20),
              ),
              if (isShowRate) ...[
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AutiLabRoutes.ratingScreen);
                  },
                  child: Container(
                    height: isMobile ? 24 : 32,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AutilabColor.bb,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: const Color(0xffEDC757),
                          size: isMobile ? 16 : 18,
                        ),
                        Text(
                          'Rate Now',
                          style: AutilabTextStyle.small12_400.copyWith(
                            fontSize: isMobile ? 12 : 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          const SizedBox(
            height: 6,
          ),
          const Spacer(),
          SizedBox(
            height: isMobile ? 100 : 200,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
                      child: SizedBox(
                        width: isMobile ? 116 : 200,
                        height: isMobile ? 116 : 200,
                        child: Image.asset(
                          image,
                          cacheWidth:
                              cacheImageFunction(isMobile ? 116 : 200, context),
                          cacheHeight:
                              cacheImageFunction(isMobile ? 116 : 200, context),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        Text(
                          'Dr. Sophia Martinez',
                          overflow: TextOverflow.ellipsis,
                          style: isMobile
                              ? AutilabTextStyle.medium18_500
                              : AutilabTextStyle.medium18_500
                                  .copyWith(fontSize: 32),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Speech Therapy',
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
          ),
          const Spacer(),
          CustomButtonWidget(
            isMobile: isMobile,
            onTap: () {
              onTap();
            },
            height: isMobile ? 50 : 72,
            margin: const EdgeInsets.only(top: 12),
            color: AutilabColor.bb,
            text: 'Detail Appointment',
            borderRadius: isMobile ? 16 : 24,
            textStyle: AutilabTextStyle.small18_400
                .copyWith(fontSize: isMobile ? 18 : 28),
          ),
        ],
      ),
    );
  }
}
