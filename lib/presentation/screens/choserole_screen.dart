import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/menu/Page/rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../utils/functions/animation_control.dart';

class ChoseRoleScreen extends StatefulWidget {
  const ChoseRoleScreen({super.key});

  @override
  State<ChoseRoleScreen> createState() => _ChoseRoleScreenState();
}

class _ChoseRoleScreenState extends State<ChoseRoleScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  RadioCharacter? character;

  bool isDoctorRole = false;
  bool isClientRole = false;
  final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(1);

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));
    character = RadioCharacter.secondeCharacter;
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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                fillOverscroll: false,
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ChoseRoleWidget(
                        stackAlignment: Alignment.centerRight,
                        textAlignment: Alignment.centerLeft,
                        image: 'occupational_role.svg',
                        title1: 'Occupational\nTherapist',
                        margin: const EdgeInsets.only(right: 35),
                        padding: const EdgeInsets.only(left: 24),
                        checkBox: RadioButtonWidget(
                          radioCharacter: character!,
                          value: RadioCharacter.characterOne,
                          onChanged: (value) {
                            setState(() {
                              character = value;
                            });
                          },
                          title:
                              'Provider Of Specialized Treatment And Education Services',
                          textStyle: AutilabTextStyle.small16_400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ChoseRoleWidget(
                        stackAlignment: Alignment.centerLeft,
                        textAlignment: Alignment.centerRight,
                        image: 'client_role.svg',
                        title1: 'Occupational\nTherapy\nClient',
                        margin: const EdgeInsets.only(left: 35),
                        padding: const EdgeInsets.only(right: 24),
                        checkBox: RadioButtonWidget(
                          radioCharacter: character!,
                          value: RadioCharacter.secondeCharacter,
                          onChanged: (value) {
                            setState(() {
                              character = value;
                            });
                          },
                          title:
                              'User Of Medical Staff Services And Specialist Training',
                          textStyle: AutilabTextStyle.small16_400,
                        ),
                      ),
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        if (selectedIndexNotifier.value != null) {
                          context.pushNamed(AutiLabRoutes.welcomeScreen);
                        }
                      },
                      height: 50,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 32),
                      color: AutilabColor.bb,
                      text: 'Get Start',
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
  }
}

class ChoseRoleWidget extends StatelessWidget {
  const ChoseRoleWidget({
    super.key,
    required this.stackAlignment,
    required this.textAlignment,
    required this.image,
    required this.title1,
    required this.margin,
    required this.padding,
    required this.checkBox,
  });

  final AlignmentGeometry stackAlignment;
  final AlignmentGeometry textAlignment;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final String image;
  final String title1;
  final Widget checkBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Stack(
          alignment: stackAlignment,
          children: [
            Container(
              height: 110,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 80),
              padding: padding,
              alignment: textAlignment,
              decoration: BoxDecoration(
                color: AutilabColor.bb,
                borderRadius: BorderRadius.circular(24),
              ),
              child: FittedBox(
                child: Text(
                  title1,
                  style: AutilabTextStyle.medium18_500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Padding(
                padding: margin,
                child: SvgPicture.asset(
                  'assets/icons/$image',
                  height: 135,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: checkBox,
        ),
      ],
    );
  }
}
