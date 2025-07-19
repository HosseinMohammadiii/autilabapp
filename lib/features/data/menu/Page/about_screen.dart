import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/functions/animation_control.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
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
  void didUpdateWidget(covariant AboutScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'About AutiLab', isIcon: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AutilabMargin.marginFullScreen,
              child: Column(
                // spacing: 48,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  SvgPicture.asset(
                    'assets/images/about_image.svg',
                    height: 180,
                    width: 350,
                    // fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Text(
                    "AutiLab was created with one simple belief — that every child on the autism spectrum deserves care that truly understands them. It’s a space where differences are understood, and every unique journey is respected. Designed to support children with autism and their families, the app offers accessible, evidence-based tools for early intervention, personalized learning, and ongoing progress tracking.Our goal is to empower parents, therapists, and educators with practical resources that truly make a difference in each child's development journey. ",
                    style: AutilabTextStyle.small16_400,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
