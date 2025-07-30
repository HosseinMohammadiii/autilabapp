import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../common/widgets/responsive_widget.dart';
import '../../../../utils/functions/animation_control.dart';

class SuccessfulSubmitRateScreen extends StatefulWidget {
  const SuccessfulSubmitRateScreen({super.key});

  @override
  State<SuccessfulSubmitRateScreen> createState() =>
      _SuccessfulSubmitRateScreenState();
}

class _SuccessfulSubmitRateScreenState extends State<SuccessfulSubmitRateScreen>
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
  void didUpdateWidget(covariant SuccessfulSubmitRateScreen oldWidget) {
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
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: isMobile() ? 128 : 252,
                      height: isMobile() ? 128 : 252,
                      margin: const EdgeInsets.only(bottom: 48),
                      decoration: const BoxDecoration(
                        color: AutilabColor.yellow,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/tik.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    Text(
                      'Thank You For Your Feedback!',
                      textAlign: TextAlign.center,
                      style: AutilabTextStyle.medium20_500.copyWith(
                        fontSize: isMobile() ? 20 : 24,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "We're always working to serve you better.",
                      textAlign: TextAlign.center,
                      style: AutilabTextStyle.small16_400.copyWith(
                        color: AutilabColor.gray,
                        fontSize: isMobile() ? 16 : 20,
                      ),
                    ),
                    CustomButtonWidget(
                      isMobile: isMobile(),
                      onTap: () {
                        context.pop();
                        context.pop();
                      },
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 32),
                      color: AutilabColor.bb,
                      text: 'OK ',
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
