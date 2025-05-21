import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/expiredappointment_widget.dart';
import '../widgets/validAppointment_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'My Doctor', isIcon: true),
        body: const SafeArea(
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
              ValidAppointmentWidget(),
              ExpiredAppointmentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
