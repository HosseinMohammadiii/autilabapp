import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';

class NotSuccessfulPaymentScreen extends StatefulWidget {
  const NotSuccessfulPaymentScreen({super.key});

  @override
  State<NotSuccessfulPaymentScreen> createState() =>
      _NotSuccessfulPaymentScreenState();
}

class _NotSuccessfulPaymentScreenState extends State<NotSuccessfulPaymentScreen>
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
  void didUpdateWidget(covariant NotSuccessfulPaymentScreen oldWidget) {
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
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: AutilabMargin.marginFullScreen,
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/not_successful_payment.svg',
                            width: isMobile() ? null : 574,
                            height: isMobile() ? null : 470,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Your Payment Was Not Successful',
                            style: AutilabTextStyle.medium20_500.copyWith(
                              fontSize: isMobile() ? 20 : 32,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            "Your Payment For The One-Year Package Was Not Successful",
                            style: AutilabTextStyle.small16_400.copyWith(
                              color: AutilabColor.gray,
                              fontSize: isMobile() ? 16 : 28,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          CustomButtonWidget(
                            isMobile: isMobile(),
                            onTap: () {
                              context.pushNamed(
                                  AutiLabRoutes.successfulPaymentScreen);
                            },
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 32),
                            color: AutilabColor.bb,
                            text: 'Pay Again',
                            textStyle: AutilabTextStyle.small18_400,
                          )
                        ],
                      ),
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
