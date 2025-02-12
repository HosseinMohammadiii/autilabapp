import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constant_routes.dart';
import '../../utils/functions/animation_control.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(vsync: this);

    animationHelper.animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          animationHelper.animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          context.goNamed(AutiLabRoutes.programIntroductionScreen);
        }
      },
    );
    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationHelper.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeTransition(
              opacity: animationHelper.fadeAnimation,
              child: SvgPicture.asset(
                'assets/icons/autilab_logo.svg',
                colorFilter: const ColorFilter.mode(
                  AutilabColor.blue,
                  BlendMode.srcIn,
                ),
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
