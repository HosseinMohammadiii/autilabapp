import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
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
  DoctorBoxWidget(
      {super.key,
      this.isLike = false,
      this.isMobile = true,
      this.user,
      this.doctorSpecialities,
      this.doctorRate,
      // this.gender,
      this.id});
  bool isLike;
  final bool isMobile;
  final DoctorUser? user;
  final RecentVisitedModel? doctorSpecialities;
  final String? doctorRate;
  // final String? gender;
  final int? id;

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
                  color: widget.user?.gender == 'male'
                      ? AutilabColor.bb
                      : AutilabColor.gray,
                  fontSize: widget.isMobile ? 14 : 20,
                ),
              ),
              const Text(' | '),
              Text(
                'Female',
                style: AutilabTextStyle.medium14_500.copyWith(
                  color: widget.user?.gender == 'female'
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
                    'doctorUser': widget.user,
                    'doctorSpecialities': widget.doctorSpecialities,
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
                        widget.user?.photo ?? 'assets/images/doctor_image.jpg',
                        width: widget.isMobile ? 116 : 200,
                        height: widget.isMobile ? 116 : 200,
                        cacheWidth: cacheImageFunction(
                            widget.isMobile ? 116 : 200, context),
                        cacheHeight: cacheImageFunction(
                            widget.isMobile ? 116 : 200, context),
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
                            // 'Dr. Sophia Martinez',
                            overflow: TextOverflow.ellipsis,
                            style: widget.isMobile
                                ? AutilabTextStyle.medium18_500
                                : AutilabTextStyle.medium18_500
                                    .copyWith(fontSize: 32),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.doctorSpecialities?.name ??
                                      'Speech Therapy',
                                  style: AutilabTextStyle.small14_400.copyWith(
                                    fontSize: widget.isMobile ? 14 : 24,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
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
                          FittedBox(
                            fit: BoxFit.scaleDown,
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
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 24),
                                        child: ButtonCard(
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
                                                    'image': widget
                                                            .user?.photo ??
                                                        'assets/images/doctor_image.jpg',
                                                    'name': doctorFullName,
                                                    'expertise': widget
                                                        .doctorSpecialities
                                                        ?.name,
                                                  },
                                                );
                                              case 1:
                                                context.pushNamed(
                                                  AutiLabRoutes
                                                      .doctorWorkscheduleScreen,
                                                  extra: {
                                                    'isLike': widget.isLike,
                                                    'doctorUser': widget.user,
                                                    'specialty': widget
                                                        .doctorSpecialities,
                                                  },
                                                );
                                            }
                                          },
                                          icon: icon[index],
                                        ),
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
              context.pushNamed(
                AutiLabRoutes.makeAppointmentScreen,
                extra: {
                  'isLike': widget.isLike,
                  'doctorUser': widget.user,
                  'specialty': widget.doctorSpecialities,
                  'id': widget.id,
                },
              );
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
