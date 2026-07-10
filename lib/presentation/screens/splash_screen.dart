import 'package:autilab_project/common/widgets/responsive_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/network/shared_preferences.dart';
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
          displaySplashPage(context);
        }
      },
    );
    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: const Size(0, 0), child: AppBar()),
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
      ),
    );
  }

  displaySplashPage(BuildContext context) async {
    if (await SharedPreferencesData.isUserLogIn()) {
      context.goNamed(AutiLabRoutes.bottomNavigationScreen);
    } else if (!await SharedPreferencesData.firstTimeLogIn()) {
      context.goNamed(AutiLabRoutes.welcomeScreen);
    } else {
      context.goNamed(AutiLabRoutes.programIntroductionScreen);
    }
  }
}
