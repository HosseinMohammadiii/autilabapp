import 'package:autilab_project/features/data/doctor/page/find_doctor_screen.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_tabbar_widget.dart';

import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import 'nearby_center_screen.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
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
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DoctorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: const Scaffold(
        body: SafeArea(
          child: CustomTabBarWidget(
            tabLength: 2,
            tabBar: [
              FittedBox(
                child: Text(
                  'Find Specialist',
                  style: AutilabTextStyle.small18_400,
                ),
              ),
              FittedBox(
                child: Text(
                  'Nearby centers',
                  style: AutilabTextStyle.small18_400,
                ),
              ),
            ],
            tabBarView: [
              FindDoctorScreen(),
              NearbyCenterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
