import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/responsive_widget.dart';
import '../../../../core/constants/color_constant.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return ResponsiveLayout(
          child: FadeTransition(
            opacity: animationHelper.fadeAnimation,
            child: Scaffold(
              appBar: appBarWidget(
                context: context,
                title: 'My Subscribtion',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.only(bottom: 48),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AutilabColor.yellow,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/crown_icon.svg',
                        height: isMobile() ? 128 : 240,
                        width: isMobile() ? 128 : 240,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      'You Don’t Have Any Subscribtion',
                      style: AutilabTextStyle.medium20_500.copyWith(
                        fontSize: isMobile() ? 20 : 32,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: AutilabMargin.marginFullScreen,
                      child: Text(
                        'You Have Not Activated Any Packages. You Can View All Packages From The Button Below.',
                        textAlign: TextAlign.center,
                        style: AutilabTextStyle.small16_400.copyWith(
                          color: AutilabColor.gray,
                          fontSize: isMobile() ? 16 : 28,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomButtonWidget(
                      isMobile: isMobile(),
                      onTap: () {
                        context.pushNamed(
                            AutiLabRoutes.subscribtionPackagesScreen);
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
          ),
        );
      },
    );
  }
}
