import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:autilab_project/common/widgets/test_result_widget.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/plan_box_widget.dart';
import '../../../../utils/functions/animation_control.dart';

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({super.key});

  @override
  State<TestHistoryScreen> createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen>
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
  void didUpdateWidget(covariant TestHistoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar:
            appBarWidget(context: context, title: 'Test History', isIcon: true),
        body: const SafeArea(
          child: CustomTabBarWidget(
            tabLength: 2,
            tabBar: [
              const Text(
                'Personality Test',
                style: AutilabTextStyle.small16_400,
              ),
              const Text(
                'Talent Test',
                style: AutilabTextStyle.small16_400,
              ),
            ],
            tabBarView: [
              SingleChildScrollView(
                child: Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        style: AutilabTextStyle.small16_400,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Aptitude Test Result',
                        style: AutilabTextStyle.small18_400,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TestResultWidget(),
                    ],
                  ),
                ),
              ),
              Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}
