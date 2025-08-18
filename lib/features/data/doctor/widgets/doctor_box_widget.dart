import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../utils/functions/cacheimahe_function.dart';
import '../data/model/doctor_model.dart';
import 'button_card.dart';

// ignore: must_be_immutable
class DoctorBoxWidget extends StatefulWidget {
  DoctorBoxWidget({
    super.key,
    this.isLike = false,
    this.isMobile = true,
    this.user,
    this.doctorSpecialities,
    this.doctorRate,
    this.gender,
  });
  bool isLike;
  final bool isMobile;
  final DoctorUser? user;
  final DoctorSpecialities? doctorSpecialities;
  final String? doctorRate;
  final String? gender;

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

  late String doctorFullName = '';
  @override
  void initState() {
    doctorFullName = '${widget.user?.firstName} ${widget.user?.lastName}';
    super.initState();
  }

//Control doctor gender
  Color controlDoctorGender(String gender) {
    if (gender == 'female') {
      return AutilabColor.bb;
    } else if (gender == 'male') {
      return AutilabColor.bb;
    } else {
      return AutilabColor.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  color: widget.gender == 'male'
                      ? AutilabColor.bb
                      : AutilabColor.gray,
                  // controlDoctorGender(widget.gender ?? 'male'),
                  fontSize: widget.isMobile ? 14 : 20,
                ),
              ),
              const Text(' | '),
              Text(
                'Female',
                style: AutilabTextStyle.medium14_500.copyWith(
                  color: widget.gender == 'female'
                      ? AutilabColor.bb
                      : AutilabColor.gray,
                  fontSize: widget.isMobile ? 14 : 20,
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              GestureDetector(
                onTap: () {
                  context
                      .pushNamed(AutiLabRoutes.doctorInformationScreen, extra: {
                    'isLike': widget.isLike,
                  });
                },
                child: Container(
                  height: widget.isMobile ? 32 : 48,
                  width: widget.isMobile ? 100 : 200,
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffEDC757),
                    borderRadius:
                        BorderRadius.circular(widget.isMobile ? 12 : 24),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Info',
                      textAlign: TextAlign.center,
                      style: AutilabTextStyle.small18_400.copyWith(
                        fontSize: widget.isMobile ? 14 : 28,
                      ),
                    ),
                  ),
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
            height: widget.isMobile ? 116 : 200,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                spacing: 24,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        width: widget.isMobile ? 116 : 200,
                        height: widget.isMobile ? 116 : 200,
                        cacheWidth: cacheImageFunction(
                            widget.isMobile ? 116 : 200, context),
                        cacheHeight: cacheImageFunction(
                            widget.isMobile ? 116 : 200, context),
                        'assets/images/doctor_image.jpg',
                        fit: BoxFit.cover,
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
                          Text(
                            doctorFullName,
                            overflow: TextOverflow.ellipsis,
                            style: widget.isMobile
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
                                  widget.doctorSpecialities?.name ?? '',
                                  style: AutilabTextStyle.small14_400.copyWith(
                                    fontSize: widget.isMobile ? 14 : 24,
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
                                  widget.doctorRate ?? '4.0',
                                  style: AutilabTextStyle.small14_400.copyWith(
                                    fontSize: widget.isMobile ? 14 : 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: widget.isMobile ? 32 : 68,
                                  child: ListView.builder(
                                    itemCount: icon.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ButtonCard(
                                        isMobile: widget.isMobile,
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
                                  width: widget.isMobile ? 32 : 68,
                                  height: widget.isMobile ? 32 : 68,
                                  child: LikeWidget(
                                    isLike: widget.isLike,
                                    isMobile: widget.isMobile,
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
            isMobile: widget.isMobile,
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
