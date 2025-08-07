import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/common/widgets/snackbar_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/bubble_background_widget.dart';
import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/constants/constant_routes.dart';
import '../../../../../utils/functions/animation_control.dart';

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
                title: 'Back',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/enter_email_image.svg',
                              width: isMobile() ? 345 : 534,
                              height: isMobile() ? 255 : 350,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Text(
                              'Enter Your Email Address',
                              style: AutilabTextStyle.small16_400.copyWith(
                                fontSize: isMobile() ? 16 : 24,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          CustomTextfield(
                            isMobile: isMobile(),
                            textStyle: AutilabTextStyle.small14_400.copyWith(
                              color: emailController.text.isNotEmpty
                                  ? AutilabColor.black
                                  : AutilabColor.gray,
                              fontSize: isMobile() ? 14 : 20,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            borderRaduis: isMobile() ? 16 : 24,
                            textfieldPadding: AutilabMargin.marginFullScreen,
                            controller: emailController,
                            focusNode: emailFocusNode,
                            textInputType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            label: 'Email',
                            borderColor: AutilabColor.blue,
                          ),
                          CustomButtonWidget(
                            isMobile: isMobile(),
                            margin: AutilabMargin.marginFullScreen
                                .copyWith(top: 16, bottom: 16),
                            onTap: () {
                              if (emailController.text.isEmpty) {
                                displaySnackBar(
                                  context,
                                  'Please enter your email address',
                                  AutilabColor.bb,
                                );
                              } else {
                                context.pushNamed(
                                    AutiLabRoutes.sendEmailCodeScreen,
                                    extra: {
                                      'email': emailController.text,
                                    });
                              }
                            },
                            height: 50,
                            color: AutilabColor.bb,
                            text: 'Send Link',
                            textStyle: AutilabTextStyle.small18_400,
                          ),
                          BubbleBackgroundWidget(
                            isMobile: isMobile(),
                          ),
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
