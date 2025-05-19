import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/doctor_box_widget.dart';
import 'package:autilab_project/features/data/home/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/new_appointment_card_widget.dart';

class MydoctorScreen extends StatefulWidget {
  const MydoctorScreen({super.key});

  @override
  State<MydoctorScreen> createState() => _MydoctorScreenState();
}

class _MydoctorScreenState extends State<MydoctorScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MydoctorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<Color> statusColor = [
    const Color(0xff50DD81),
  ];
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'My Doctor', isIcon: true),
        body: SafeArea(
          child: CustomTabBarWidget(
            tabLength: 2,
            tabBar: [
              Text(
                'Valid Appointment',
                style: AutilabTextStyle.small16_400,
              ),
              Text(
                'Expired Appointment',
                style: AutilabTextStyle.small16_400,
              ),
            ],
            tabBarView: [
              ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return NewAppointmentsCardWidget(
                    color: const Color(0xff50DD81),
                    title: 'Approved',
                    statusIcon: 'assets/icons/done_icon.svg',
                    image: 'assets/images/doctor_image.png',
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 16),
                    onTap: () {
                      print(statusColor[0]);
                      context.pushNamed(
                        AutiLabRoutes.detailAppointmentScreen,
                        extra: {
                          'statusColor': const Color(0xff50DD81),
                          'statusIcon': 'assets/icons/done_icon.svg',
                          'title': 'Approved',
                        },
                      );
                    },
                  );
                },
              ),
              Text(
                'Expired Appointment',
                style: AutilabTextStyle.small16_400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
