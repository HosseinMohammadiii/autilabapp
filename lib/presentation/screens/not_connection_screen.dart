import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/functions/animation_control.dart';

class NotConnectionInternetScreen extends StatefulWidget {
  const NotConnectionInternetScreen({super.key});

  @override
  State<NotConnectionInternetScreen> createState() =>
      _NotConnectionInternetScreenState();
}

class _NotConnectionInternetScreenState
    extends State<NotConnectionInternetScreen> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant NotConnectionInternetScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
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
                    SvgPicture.asset('assets/icons/no_internet.svg'),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'No Internet Connection',
                      style: AutilabTextStyle.medium20_500,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Your Internet Connection Is Currently\nNot Available Please Check Or Try Again.',
                      style: AutilabTextStyle.small16_400.copyWith(
                        color: AutilabColor.gray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomButtonWidget(
                      onTap: () {},
                      height: 50,
                      color: AutilabColor.bb,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 32),
                      text: 'Try Again',
                      textStyle: AutilabTextStyle.small18_400,
                    )
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
