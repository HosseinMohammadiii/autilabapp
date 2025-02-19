import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constant_routes.dart';
import '../../utils/functions/animation_control.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
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
  void didUpdateWidget(covariant WelcomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/welcome_image.svg',
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Welcome To Autilab!',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Lorem Ipsum Odor Amet, Consectetuer Adipiscing Consectetuer Elit.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        context.pushNamed(
                          AutiLabRoutes.loginScreen,
                          extra: {
                            'isSignUp': false,
                          },
                        );
                      },
                      height: 50,
                      color: AutilabColor.bb,
                      text: 'Login',
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        context.pushNamed(
                          AutiLabRoutes.loginScreen,
                          extra: {
                            'isSignUp': true,
                          },
                        );
                      },
                      height: 50,
                      color: AutilabColor.white,
                      text: 'Sign Up',
                      width: 70,
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AutilabColor.blue,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
