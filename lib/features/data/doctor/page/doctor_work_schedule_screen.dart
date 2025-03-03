import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class DoctorWorkScheduleScreen extends StatefulWidget {
  const DoctorWorkScheduleScreen({super.key});

  @override
  State<DoctorWorkScheduleScreen> createState() =>
      _DoctorWorkScheduleScreenState();
}

class _DoctorWorkScheduleScreenState extends State<DoctorWorkScheduleScreen>
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
  void didUpdateWidget(covariant DoctorWorkScheduleScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [],
          ),
        ),
      ),
    );
  }
}
