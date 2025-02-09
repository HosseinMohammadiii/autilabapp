import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constant_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  @override
  void initState() {
    super.initState();
    //Animation duration define
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    //Define animate animation
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 2).animate(animation);

    animation.addStatusListener((status) {
      //Animation revers whene completed
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //Navigat to loginScreen whene dismissed animation
        context.goNamed(AutiLabRoutes.programIntroductionScreen);
      }
    });
    animation.forward();
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
              opacity: _fadeInFadeOut,
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
