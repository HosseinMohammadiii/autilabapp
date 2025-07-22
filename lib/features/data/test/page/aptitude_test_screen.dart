import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/functions/animation_control.dart';

class AptitudeTestScreen extends StatefulWidget {
  const AptitudeTestScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.onTap,
  });
  final String image;
  final String title;
  final String subTitle;
  final String description;
  final Function() onTap;

  @override
  State<AptitudeTestScreen> createState() => _AptitudeTestScreenState();
}

class _AptitudeTestScreenState extends State<AptitudeTestScreen>
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
  void didUpdateWidget(covariant AptitudeTestScreen oldWidget) {
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
                title: widget.title,
                isIcon: true,
                isMobile: isMobile()),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: isMobile() ? null : 470,
                          height: isMobile() ? null : 280,
                          child: SvgPicture.asset(widget.image),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          widget.subTitle,
                          style: AutilabTextStyle.medium20_500.copyWith(
                            fontSize: isMobile() ? 20 : 32,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: AutilabTextStyle.small16_400.copyWith(
                              fontSize: isMobile() ? 16 : 28,
                            ),
                          ),
                        ),
                        CustomButtonWidget(
                          isMobile: isMobile(),
                          onTap: () => widget.onTap(),
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 60),
                          color: AutilabColor.bb,
                          text: 'Get Started',
                          textStyle: AutilabTextStyle.small18_400,
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
