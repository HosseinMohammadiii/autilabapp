import 'package:autilab_project/common/widgets/bubble_background_widget.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../common/widgets/appbar_back_screen.dart';

class SendEmailCodeScreen extends StatefulWidget {
  const SendEmailCodeScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<SendEmailCodeScreen> createState() => _SendEmailCodeScreenState();
}

class _SendEmailCodeScreenState extends State<SendEmailCodeScreen>
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
  void didUpdateWidget(covariant SendEmailCodeScreen oldWidget) {
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
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/enter_code_email_image.svg',
                              width: isMobile() ? 315 : 544,
                              height: isMobile() ? 240 : 370,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Padding(
                                padding: isMobile()
                                    ? AutilabMargin.marginFullScreen
                                    : const EdgeInsetsGeometry.only(left: 20),
                                child: Text(
                                  'We Will Send You One Time Password To',
                                  style: AutilabTextStyle.small16_400.copyWith(
                                    fontSize: isMobile() ? 16 : 24,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: isMobile()
                                    ? AutilabMargin.marginFullScreen
                                    : const EdgeInsetsGeometry.only(left: 4),
                                child: Text(
                                  widget.email,
                                  style: AutilabTextStyle.small18_400.copyWith(
                                    color: AutilabColor.blue,
                                    fontSize: isMobile() ? 18 : 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomButtonWidget(
                            isMobile: isMobile(),
                            onTap: () {
                              context.pushReplacementNamed(
                                  AutiLabRoutes.loginScreen);
                            },
                            height: 50,
                            margin: AutilabMargin.marginFullScreen,
                            color: AutilabColor.bb,
                            text: 'OK',
                            textStyle: AutilabTextStyle.small18_400,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BubbleBackgroundWidget(
                            isMobile: isMobile(),
                          ),
                        ],
                      ),
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
