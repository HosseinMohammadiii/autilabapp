import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/functions/animation_control.dart';

class ChoseRoleScreen extends StatefulWidget {
  const ChoseRoleScreen({super.key});

  @override
  State<ChoseRoleScreen> createState() => _ChoseRoleScreenState();
}

class _ChoseRoleScreenState extends State<ChoseRoleScreen>
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
  void didUpdateWidget(covariant ChoseRoleScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Choose Your Role Below'),
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 110,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 90),
                    padding: const EdgeInsets.only(left: 24),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AutilabColor.bb,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'Occupational \n Therapist',
                      style: AutilabTextStyle.medium18_500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child:
                        SvgPicture.asset('assets/icons/occupational_role.svg'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
