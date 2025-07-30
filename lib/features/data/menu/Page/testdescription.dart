import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/utils/functions/animation_control.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/responsive_widget.dart';

class TestdescriptionResult extends StatefulWidget {
  const TestdescriptionResult({
    super.key,
    required this.description,
  });
  final String description;

  @override
  State<TestdescriptionResult> createState() => _TestdescriptionResultState();
}

class _TestdescriptionResultState extends State<TestdescriptionResult>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  bool isScroll = false;

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
  void didUpdateWidget(covariant TestdescriptionResult oldWidget) {
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
                title: 'Test Description',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.description,
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile() ? 14 : 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
