import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class MySubscribtionScreen extends StatefulWidget {
  const MySubscribtionScreen({super.key});

  @override
  State<MySubscribtionScreen> createState() => _MySubscribtionScreenState();
}

class _MySubscribtionScreenState extends State<MySubscribtionScreen>
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
  void didUpdateWidget(covariant MySubscribtionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'My Subscribtion', isIcon: true),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: AutilabMargin.marginFullScreen,
                child: Center(
                  child: PlanBoxWidget(
                    title: 'Free Plan',
                    margin: 0,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
