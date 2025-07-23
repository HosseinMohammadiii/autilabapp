import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: Scaffold(
            appBar: appBarWidget(
              context: context,
              title: 'Back',
              isIcon: true,
              isMobile: isMobile(),
            ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 64,
                        ),
                        SvgPicture.asset(
                          'assets/images/welcome_image.svg',
                          height: isMobile() ? 242 : 540,
                          width: isMobile() ? 306 : 574,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Welcome To Autilab!',
                          style: AutilabTextStyle.medium20_500.copyWith(
                            fontSize: isMobile() ? 20 : 32,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Big support. Bright smiles. Welcome to AutiLab!',
                            textAlign: TextAlign.center,
                            style: AutilabTextStyle.small16_400.copyWith(
                              fontSize: isMobile() ? 16 : 28,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButtonWidget(
                          isMobile: isMobile(),
                          onTap: () {
                            context.pushNamed(
                              AutiLabRoutes.loginScreen,
                            );
                          },
                          height: 50,
                          borderRadius: 16,
                          color: AutilabColor.bb,
                          text: 'Login',
                          textStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButtonWidget(
                          isMobile: isMobile(),
                          onTap: () {
                            context.pushNamed(
                              AutiLabRoutes.signUpScreen,
                            );
                          },
                          height: 50,
                          color: AutilabColor.white,
                          text: 'Sign Up',
                          width: 70,
                          margin: const EdgeInsets.all(0),
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
      },
    );
  }
}
