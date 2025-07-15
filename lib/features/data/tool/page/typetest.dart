import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/features/data/tool/widgets/tools_box_widget.dart';
import 'package:autilab_project/utils/functions/animation_control.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constant_routes.dart';

class TypetestScreen extends StatefulWidget {
  const TypetestScreen({super.key});

  @override
  State<TypetestScreen> createState() => _TypetestScreenState();
}

class _TypetestScreenState extends State<TypetestScreen>
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
  void didUpdateWidget(covariant TypetestScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'Take A Test', isIcon: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                ToolsBoxWidget(
                  title: 'Talent Identification Test',
                  description:
                      "Aptitude Test To Identify Children's Talents And Improve Their Future",
                  titleButton: 'Do The Test',
                  svg: 'assets/images/talent_image.svg',
                  onTap: () {
                    context.pushNamed(AutiLabRoutes.aptitudeTestScreen, extra: {
                      'image': 'assets/images/talent_image.svg',
                      'title': 'Aptitude Test',
                      'subTitle': 'Talent Identification Test',
                      'description':
                          "Discover your child's hidden potentials and help them grow endlessly.",
                      'onTap': () {
                        context.pushNamed(AutiLabRoutes.quizMultiSelectScreen);
                      },
                    });
                  },
                ),
                ToolsBoxWidget(
                  title: 'Personality Test',
                  description:
                      "Discover Deeper Insights Into Your Unique Personality With Our Autism-Focused Assessment",
                  titleButton: 'Do The Test',
                  svg: 'assets/images/personality_image.svg',
                  onTap: () {
                    context.pushNamed(AutiLabRoutes.aptitudeTestScreen, extra: {
                      'image': 'assets/images/personality_image.svg',
                      'title': 'Personality Test',
                      'subTitle': 'Personality Test',
                      'description':
                          "Discover your child's personality and help them find the right path in life.",
                      'onTap': () {
                        context.pushNamed(AutiLabRoutes.quizMultiSelectScreen);
                      },
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
