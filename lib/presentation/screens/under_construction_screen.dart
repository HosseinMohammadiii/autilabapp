import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/widgets/custom_button_widget.dart';
import '../../common/widgets/responsive_widget.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../utils/functions/animation_control.dart';

class UnderConstructionScreen extends StatefulWidget {
  const UnderConstructionScreen({super.key});

  @override
  State<UnderConstructionScreen> createState() =>
      _UnderConstructionScreenState();
}

class _UnderConstructionScreenState extends State<UnderConstructionScreen>
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
  void didUpdateWidget(covariant UnderConstructionScreen oldWidget) {
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
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/under_construction.svg',
                            width: isMobile() ? 160 : 240,
                            height: isMobile() ? 160 : 240,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Under Construction',
                            style: AutilabTextStyle.medium20_500.copyWith(
                              fontSize: isMobile() ? 20 : 32,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            "Work In Progress\nWe're Building Something Amazing",
                            style: AutilabTextStyle.small16_400.copyWith(
                              color: AutilabColor.gray,
                              fontSize: isMobile() ? 16 : 28,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          CustomButtonWidget(
                            isMobile: isMobile(),
                            onTap: () {},
                            height: 50,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 32),
                            color: AutilabColor.bb,
                            text: 'Get Home',
                            textStyle: AutilabTextStyle.small18_400,
                          )
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
