import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/widgets/custom_button_widget.dart';
import '../../core/constants/color_constant.dart';
import '../../core/constants/theme_constant.dart';
import '../../utils/functions/animation_control.dart';

class ItemNotFoundScreen extends StatefulWidget {
  const ItemNotFoundScreen({super.key});

  @override
  State<ItemNotFoundScreen> createState() => _ItemNotFoundScreenState();
}

class _ItemNotFoundScreenState extends State<ItemNotFoundScreen>
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
  void didUpdateWidget(covariant ItemNotFoundScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Dr Zhale Freit', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/item_notfound.svg'),
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'Item Not Found',
                      style: AutilabTextStyle.medium20_500,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Try Searching The Item With A Different\nKeyword.',
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
                      margin: AutilabMargin.marginFullScreen,
                      color: AutilabColor.bb,
                      text: 'Search Something Else',
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
