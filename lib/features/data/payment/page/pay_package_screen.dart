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
    required this.price,
  });
  final String title;
  final String? description;
  final Widget? options;
  final int? price;

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
              title: 'Package',
              isIcon: true,
              isMobile: isMobile(),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: AutilabMargin.marginFullScreen,
                      child: Text(
                        'Your Selected Package',
                        style: AutilabTextStyle.medium20_500.copyWith(
                          fontSize: isMobile() ? 20 : 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 48),
                        child: PlanBoxWidget(
                          title: widget.title,
                          isMobile: isMobile(),
                          titleButton: 'Pay',
                          description: widget.description,
                          backgroundColor: const Color(0xffECF0FF),
                          borderColor: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: AutilabColor.black.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          widget: [
                            PalnItemWidget(
                              isMobile: isMobile(),
                              title: 'Full access to the tools section',
                            ),
                            PalnItemWidget(
                              isMobile: isMobile(),
                              title: 'Access to aptitude test',
                            ),
                            PalnItemWidget(
                              isMobile: isMobile(),
                              title: 'Access to Personality Screening test',
                            ),
                            PalnItemWidget(
                              isMobile: isMobile(),
                              title: 'Unlimited appointment booking',
                            ),
                            PalnItemWidget(
                              isMobile: isMobile(),
                              title: 'Access to nearby centers',
                            ),
                            PalnItemWidget(
                              isMobile: isMobile(),
                              title: 'Doctor appointment booking discount',
                            ),
                          ],
                          margin: 0,
                          onTap: () {
                            if (widget.title == 'Free Plan') {
                              context.goNamed(AutiLabRoutes.homeScreen);
                            } else {
                              context.pushNamed(
                                AutiLabRoutes.personalDetailPaymentScreen,
                                extra: {
                                  'title': widget.title,
                                  'description': widget.description,
                                  'price': widget.price,
                                },
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
      },
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
        Text(
          ' Initial Test To Determine How Much You Are',
          style: AutilabTextStyle.small14_400,
        ),
      ],
    );
  }
}
