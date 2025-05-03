import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';
import '../../../../common/widgets/appbar_back_screen.dart';
import '../widgets/signup_icon_widget.dart';

// ignore: must_be_immutable
class LogInScreen extends StatefulWidget {
  const LogInScreen({
    super.key,
  });

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final userNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
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
  void didUpdateWidget(covariant LogInScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/images/logIn_image.svg'),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextfield(
                      controller: userNameController,
                      focusNode: userNameFocusNode,
                      textInputAction: TextInputAction.next,
                      label: 'UserName',
                      maxLines: 1,
                      borderColor: AutilabColor.blue,
                    ),
                    CustomTextfield(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      isObscureText: true,
                      label: 'Password',
                      maxLines: 1,
                      borderColor: AutilabColor.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(AutiLabRoutes.sendEmailScreen);
                        },
                        child: const Text(
                          'Forget Password?',
                          style: AutilabTextStyle.small14_400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        context.goNamed(AutiLabRoutes.homeScreen);
                      },
                      height: 50,
                      color: AutilabColor.bb,
                      text: 'LogIn',
                      textStyle: AutilabTextStyle.small16_400,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 3,
                            indent: 20,
                            color: AutilabColor.bb,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Or Sign up With',
                            style: AutilabTextStyle.small12_400,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 3,
                            endIndent: 20,
                            color: AutilabColor.bb,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularWidgetSignUp(
                          image: 'assets/images/google_logo.svg',
                          onTap: () {},
                        ),
                        circularWidgetSignUp(
                          image: 'assets/images/facbook_logo.svg',
                          onTap: () {},
                        ),
                        circularWidgetSignUp(
                          image: 'assets/images/apple_logo.svg',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
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
