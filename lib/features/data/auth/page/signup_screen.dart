import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/core/network/dio_provider.dart';
import 'package:autilab_project/features/data/auth/data/datasource/authentication_user_datasource.dart';
import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:autilab_project/features/data/auth/data/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/constant_routes.dart';
import '../../../../core/network/shared_preferences.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../../../common/widgets/appbar_back_screen.dart';
import '../widgets/signup_icon_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final userNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
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
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SignupScreen oldWidget) {
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
              title: 'Back',
              isIcon: true,
              isMobile: isMobile(),
            ),
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
                          child: SvgPicture.asset(
                            'assets/images/signUp_image.svg',
                            height: isMobile() ? 187 : 400,
                            width: isMobile() ? 276 : 574,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomTextfield(
                          textStyle: AutilabTextStyle.small14_400.copyWith(
                            color: userNameController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            fontSize: isMobile() ? 14 : 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          borderRaduis: isMobile() ? 16 : 24,
                          textfieldPadding: AutilabMargin.marginFullScreen
                              .copyWith(bottom: 16),
                          controller: userNameController,
                          focusNode: userNameFocusNode,
                          textInputAction: TextInputAction.next,
                          label: 'UserName',
                          maxLines: 1,
                          borderColor: AutilabColor.blue,
                        ),
                        CustomTextfield(
                          textfieldPadding: AutilabMargin.marginFullScreen
                              .copyWith(bottom: 16),
                          textStyle: AutilabTextStyle.small14_400.copyWith(
                            color: emailController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            fontSize: isMobile() ? 14 : 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          borderRaduis: isMobile() ? 16 : 24,
                          controller: emailController,
                          focusNode: emailFocusNode,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          label: 'Email',
                          maxLines: 1,
                          borderColor: AutilabColor.blue,
                        ),
                        CustomTextfield(
                          textfieldPadding: AutilabMargin.marginFullScreen
                              .copyWith(bottom: 4),
                          textStyle: AutilabTextStyle.small14_400.copyWith(
                            color: passwordController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            fontSize: isMobile() ? 14 : 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          borderRaduis: isMobile() ? 16 : 24,
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
                          padding: AutilabMargin.marginFullScreen,
                          child: GestureDetector(
                            onTap: () {
                              context.goNamed(AutiLabRoutes.loginScreen);
                            },
                            child: Text(
                              'Already have an account?',
                              style: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 18,
                              ),
                            ),
                          ),
                        ),
                        CustomButtonWidget(
                          isMobile: isMobile(),
                          onTap: () async {
                            // AuthenticationRepository auth =
                            //     AuthenticationRepositoryRemoot(
                            //   AuthenticationUserDatasourceRemoot(
                            //     Dio(
                            //       BaseOptions(
                            //         baseUrl:
                            //             "https://api.autilab.com/api/auth/register",
                            //         headers: {
                            //           'Content-Type': 'application/json',
                            //           // 'Authorization':
                            //           //     'Bearer ${SharedPreferencesData.getUserToken()}',
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // );
                            // var response = await auth.registerUser(
                            //   UserModel(
                            //     email: emailController.text,
                            //     userName: userNameController.text,
                            //     firstName: userNameController.text,
                            //     lastName: userNameController.text,
                            //     password: passwordController.text,
                            //   ),
                            // );
                            context.goNamed(AutiLabRoutes.homeScreen);
                          },
                          height: 50,
                          margin: AutilabMargin.marginFullScreen
                              .copyWith(bottom: 48, top: 32),
                          color: AutilabColor.bb,
                          text: 'Sign Up',
                          textStyle: AutilabTextStyle.small16_400,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 3,
                                indent: 20,
                                color: AutilabColor.bb,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Or Sign up With',
                                style: AutilabTextStyle.small14_400.copyWith(
                                  color: const Color(0xff555252),
                                  fontSize: isMobile() ? 12 : 18,
                                ),
                              ),
                            ),
                            const Expanded(
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
                              isMobile: isMobile(),
                              image: 'assets/images/google_logo.svg',
                              onTap: () {},
                            ),
                            circularWidgetSignUp(
                              isMobile: isMobile(),
                              image: 'assets/images/facbook_logo.svg',
                              onTap: () {},
                            ),
                            circularWidgetSignUp(
                              isMobile: isMobile(),
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
      },
    );
  }
}
