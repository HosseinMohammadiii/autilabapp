import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/bubble_background_widget.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/functions/animation_control.dart';

class SendEmailScreen extends StatefulWidget {
  const SendEmailScreen({super.key});

  @override
  State<SendEmailScreen> createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

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
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SendEmailScreen oldWidget) {
    animationHelper.restartAnimation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Back', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/enter_email_image.svg',
                        width: 350,
                        height: 271,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        'Enter Your Email Address',
                        style: AutilabTextStyle.small16_400,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    CustomTextfield(
                      textfieldPadding: AutilabMargin.marginFullScreen,
                      controller: emailController,
                      focusNode: emailFocusNode,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      label: 'Email',
                      borderColor: AutilabColor.blue,
                    ),
                    CustomButtonWidget(
                      margin: AutilabMargin.marginFullScreen
                          .copyWith(top: 16, bottom: 16),
                      onTap: () {
                        context.pushNamed(AutiLabRoutes.sendEmailCodeScreen);
                      },
                      height: 50,
                      color: AutilabColor.bb,
                      text: 'Send Code',
                      textStyle: AutilabTextStyle.small18_400,
                    ),
                    const BubbleBackgroundWidget(),
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
