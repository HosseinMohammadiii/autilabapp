import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/plan_item_widget.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 32),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AutilabColor.yellow,
                ),
                child: SvgPicture.asset(
                  'assets/icons/crown_icon.svg',
                  // fit: BoxFit.scaleDown,
                ),
              ),
              const Text(
                'You Don’t Have Any Subscribtion',
                style: AutilabTextStyle.medium20_500,
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: AutilabMargin.marginFullScreen,
                child: Text(
                  'Your Internet Connection Is Currently ,Not Available Please Check Or Try Again.',
                  textAlign: TextAlign.center,
                  style: AutilabTextStyle.medium16_500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButtonWidget(
                onTap: () {
                  context.pushNamed(AutiLabRoutes.subscribtionPackagesScreen);
                },
                height: 50,
                color: AutilabColor.bb,
                text: 'See Package',
                margin: AutilabMargin.marginFullScreen,
                textStyle: AutilabTextStyle.small18_400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
