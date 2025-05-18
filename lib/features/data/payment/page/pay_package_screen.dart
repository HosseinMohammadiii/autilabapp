import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/plan_box_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/home/widgets/plan_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';

class PayPackageScreen extends StatefulWidget {
  const PayPackageScreen({
    super.key,
    required this.title,
    required this.description,
    required this.options,
  });
  final String title;
  final String? description;
  final Widget? options;

  @override
  State<PayPackageScreen> createState() => _PayPackageScreenState();
}

class _PayPackageScreenState extends State<PayPackageScreen>
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
  void didUpdateWidget(covariant PayPackageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Package', isIcon: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Text(
                    'Your Selected Package',
                    style: AutilabTextStyle.medium20_500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Padding(
                    padding: AutilabMargin.marginFullScreen,
                    child: PlanBoxWidget(
                      title: widget.title,
                      titleButton: 'Pay',
                      description:
                          "An Initial Test To Determine How Much You Are At Risk Of Cancer Based.",
                      backgroundColor: const Color(0xffECF0FF),
                      borderColor: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: AutilabColor.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      widget: const Column(
                        spacing: 8,
                        children: [
                          PalnItemWidget(
                            title: '25 Projects',
                          ),
                          PalnItemWidget(
                            title: '25 Projects',
                          ),
                          PalnItemWidget(
                            title: 'Up to 10,000 subscribers',
                          ),
                          PalnItemWidget(
                            title: 'Up to 10,000 subscribers',
                          ),
                          PalnItemWidget(
                            title: 'Up to 10,000 subscribers',
                          ),
                          PalnItemWidget(
                            title: 'Up to 10,000 subscribers',
                          ),
                        ],
                      ),
                      margin: 0,
                      onTap: () {
                        if (widget.title == 'Free Plan') {
                          context.goNamed(AutiLabRoutes.homeScreen);
                        } else {
                          context.pushNamed(
                            AutiLabRoutes.personalDetailPaymentScreen,
                            extra: {'title': widget.title},
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Display description plans cards
  Widget descriptionPlanWidget() {
    return Row(
      children: [
        Container(
          width: 23,
          height: 23,
          margin: const EdgeInsets.only(right: 4),
          decoration: const BoxDecoration(
            color: AutilabColor.yellow,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/tick_icon.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        const Text(
          ' Initial Test To Determine How Much You Are',
          style: AutilabTextStyle.small14_400,
        ),
      ],
    );
  }
}
