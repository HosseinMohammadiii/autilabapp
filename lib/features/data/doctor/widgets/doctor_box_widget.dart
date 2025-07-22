import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import 'button_card.dart';

// ignore: must_be_immutable
class DoctorBoxWidget extends StatefulWidget {
  DoctorBoxWidget({
    super.key,
    this.isLike = false,
  });
  bool isLike;

  @override
  State<DoctorBoxWidget> createState() => _DoctorBoxWidgetState();
}

class _DoctorBoxWidgetState extends State<DoctorBoxWidget> {
  List<String> icon = [
    // 'assets/icons/global_buttomnavigation.svg',
    'assets/icons/messages.svg',
    'assets/icons/calendar.svg',
  ];
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Male',
                style: AutilabTextStyle.medium14_500.copyWith(
                  color: AutilabColor.gray,
                ),
              ),
              const Text(' | '),
              Text(
                'Female',
                style: AutilabTextStyle.medium14_500.copyWith(
                  color: AutilabColor.blue,
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              Expanded(
                flex: 3,
                child: CustomButtonWidget(
                  onTap: () {
                    context.pushNamed(AutiLabRoutes.doctorInformationScreen,
                        extra: {
                          'isLike': widget.isLike,
                        });
                  },
                  height: 32,
                  width: 100,
                  borderRadius: 12,
                  margin: const EdgeInsets.all(0),
                  color: const Color(0xffEDC757),
                  text: 'Info',
                  textStyle: AutilabTextStyle.small14_400,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 103,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        width: 116,
                        height: 116,
                        child: Image.asset(
                          'assets/images/doctor_image.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              'Dr. Sophia Martinez',
                              style: AutilabTextStyle.medium18_400.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          FittedBox(
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
                                Text(
                                  '5.0',
                                  style: AutilabTextStyle.small14_400,
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 32,
                                  child: ListView.builder(
                                    itemCount: icon.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ButtonCard(
                                        onTap: () {
                                          switch (index) {
                                            // case 0:
                                            //   context.pushNamed(AutiLabRoutes
                                            //       .doctorSocialMediaScreen);
                                            case 0:
                                              context.pushNamed(
                                                AutiLabRoutes
                                                    .doctorMessageScreen,
                                                extra: {
                                                  'image':
                                                      'assets/images/doctor_image.jpg',
                                                  'name': 'Dr. Sophia Martinez',
                                                  'expertise': 'Speech Therapy',
                                                },
                                              );
                                            case 1:
                                              context.pushNamed(
                                                AutiLabRoutes
                                                    .doctorWorkscheduleScreen,
                                                extra: {
                                                  'isLike': widget.isLike,
                                                },
                                              );
                                          }
                                        },
                                        icon: icon[index],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: LikeWidget(
                                    isLike: widget.isLike,
                                    backgroundColor: AutilabColor.bb,
                                    onTap: () {
                                      setState(() {
                                        widget.isLike = !widget.isLike;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButtonWidget(
            onTap: () {
              context.pushNamed(AutiLabRoutes.makeAppointmentScreen, extra: {
                'isLike': widget.isLike,
              });
            },
            height: 50,
            margin: const EdgeInsets.only(top: 24),
            color: AutilabColor.bb,
            text: 'Make Appointment',
            textStyle: AutilabTextStyle.small18_400,
          ),
        ],
      ),
    );
  }
}
