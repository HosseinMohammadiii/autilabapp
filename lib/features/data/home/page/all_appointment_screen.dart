import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/new_appointment_card_widget.dart';

class AllAppointmentScreen extends StatefulWidget {
  const AllAppointmentScreen({super.key});

  @override
  State<AllAppointmentScreen> createState() => _AllAppointmentScreenState();
}

class _AllAppointmentScreenState extends State<AllAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void didUpdateWidget(covariant AllAppointmentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: DefaultTabController(
        animationDuration: const Duration(seconds: 1),
        length: 3,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile() {
              if (constraints.maxWidth < 600) {
                return true;
              } else {
                return false;
              }
            }

            return Scaffold(
              appBar: AppBar(
                leadingWidth: double.infinity,
                leading: appBarWidget(
                  context: context,
                  title: 'All Appointment',
                  isIcon: true,
                  isMobile: isMobile(),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(isMobile() ? 70 : 120),
                  child: Container(
                    width: double.infinity,
                    color: AutilabColor.white,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      height: isMobile() ? 50 : 72,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AutilabColor.lightGray,
                        borderRadius:
                            BorderRadius.circular(isMobile() ? 16 : 24),
                      ),
                      child: TabBar(
                        labelStyle: AutilabTextStyle.small18_400.copyWith(
                          color: Colors.black,
                        ),
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(isMobile() ? 16 : 24),
                          color: AutilabColor.bb,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          FittedBox(
                            child: Text(
                              'Approved',
                              style: AutilabTextStyle.small16_400
                                  .copyWith(fontSize: isMobile() ? 16 : 24),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'Cancelled',
                              style: AutilabTextStyle.small16_400
                                  .copyWith(fontSize: isMobile() ? 16 : 24),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'Pending',
                              style: AutilabTextStyle.small16_400
                                  .copyWith(fontSize: isMobile() ? 16 : 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      padding: AutilabMargin.marginFullScreen,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: isMobile() ? 256 : 388,
                          child: NewAppointmentsCardWidget(
                            color: const Color(0xff50DD81),
                            isMobile: isMobile(),
                            title: 'Approved',
                            image: 'assets/images/doctor2.jpg',
                            statusIcon: 'assets/icons/done_icon.svg',
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            raiteOnTap: () {},
                            onTap: () {
                              context.pushNamed(
                                AutiLabRoutes.detailAppointmentScreen,
                                extra: {
                                  'statusColor': const Color(0xff50DD81),
                                  'statusIcon': 'assets/icons/done_icon.svg',
                                  'image': 'assets/images/doctor2.jpg',
                                  'title': 'Approved',
                                  'descriptionStatus':
                                      'Your Appointment Has Been Approved',
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 6,
                      padding: AutilabMargin.marginFullScreen,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: isMobile() ? 256 : 388,
                          child: NewAppointmentsCardWidget(
                            isMobile: isMobile(),
                            color: const Color(0xffFF6363),
                            title: 'Cancelled',
                            image: 'assets/images/doctor_image.jpg',
                            statusIcon: 'assets/icons/close_icon.svg',
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            raiteOnTap: () {},
                            onTap: () {
                              context.pushNamed(
                                AutiLabRoutes.detailAppointmentScreen,
                                extra: {
                                  'statusColor': const Color(0xffFF6363),
                                  'statusIcon': 'assets/icons/close_icon.svg',
                                  'image': 'assets/images/doctor_image.jpg',
                                  'title': 'Cancelled',
                                  'descriptionStatus':
                                      'Your Appointment Has Been Canceled',
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 6,
                      padding: AutilabMargin.marginFullScreen,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: isMobile() ? 256 : 388,
                          child: NewAppointmentsCardWidget(
                            isMobile: isMobile(),
                            color: AutilabColor.gray,
                            title: 'Pending',
                            image: 'assets/images/doctor3.png',
                            statusIcon: 'assets/icons/minimize_icon.svg',
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            raiteOnTap: () {},
                            onTap: () {
                              context.pushNamed(
                                AutiLabRoutes.detailAppointmentScreen,
                                extra: {
                                  'statusColor': AutilabColor.gray,
                                  'statusIcon':
                                      'assets/icons/minimize_icon.svg',
                                  'image': 'assets/images/doctor3.png',
                                  'title': 'Pending',
                                  'descriptionStatus':
                                      'Your Appointment Is Being Reviewed',
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
