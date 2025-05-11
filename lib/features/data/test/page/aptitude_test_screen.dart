import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';

class AptitudeTestScreen extends StatefulWidget {
  const AptitudeTestScreen({super.key});

  @override
  State<AptitudeTestScreen> createState() => _AptitudeTestScreenState();
}

class _AptitudeTestScreenState extends State<AptitudeTestScreen>
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
  void didUpdateWidget(covariant AptitudeTestScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(context: context, title: 'Aptitude Test', isIcon: true),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/aptitudetest.svg'),
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    'Talent Identification Test',
                    style: AutilabTextStyle.medium20_500,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Lorem Ipsum Odor Amet, Consectetuer Adipiscing Consectetuer Elit.',
                    textAlign: TextAlign.center,
                    style: AutilabTextStyle.medium20_500,
                  ),
                  CustomButtonWidget(
                    onTap: () {
                      context.pushNamed(AutiLabRoutes.quizScreen);
                    },
                    height: 50,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 60),
                    color: AutilabColor.bb,
                    text: 'Get Started',
                    textStyle: AutilabTextStyle.small18_400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
