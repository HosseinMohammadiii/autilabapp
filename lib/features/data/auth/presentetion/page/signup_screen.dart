import 'package:autilab_project/common/widgets/snackbar_widget.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_bloc.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_event.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/custom_button_widget.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../core/constants/constant_routes.dart';
import '../../../../../core/network/shared_preferences.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../common/widgets/appbar_back_screen.dart';
import '../../data/model/user_param.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
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
                            isMobile: isMobile(),
                            textStyle: AutilabTextStyle.small14_400.copyWith(
                              fontSize: isMobile() ? 14 : 20,
                            ),
                            lblColor: passwordController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            padding: EdgeInsets.symmetric(
                                vertical: isMobile() ? 0 : 20, horizontal: 15),
                            borderRaduis: isMobile() ? 16 : 24,
                            textfieldPadding: AutilabMargin.marginFullScreen
                                .copyWith(bottom: 16),
                            controller: firstNameController,
                            focusNode: firstNameFocusNode,
                            textInputAction: TextInputAction.next,
                            label: 'FirstName',
                            maxLines: 1,
                            borderColor: AutilabColor.blue,
                            textInputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                          ),
                          CustomTextfield(
                            isMobile: isMobile(),
                            textStyle: AutilabTextStyle.small14_400.copyWith(
                              fontSize: isMobile() ? 14 : 20,
                            ),
                            lblColor: passwordController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            padding: EdgeInsets.symmetric(
                                vertical: isMobile() ? 0 : 20, horizontal: 15),
                            borderRaduis: isMobile() ? 16 : 24,
                            textfieldPadding: AutilabMargin.marginFullScreen
                                .copyWith(bottom: 16),
                            controller: lastNameController,
                            focusNode: lastNameFocusNode,
                            textInputAction: TextInputAction.next,
                            label: 'LastName',
                            maxLines: 1,
                            borderColor: AutilabColor.blue,
                            textInputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]')),
                            ],
                          ),
                          CustomTextfield(
                            isMobile: isMobile(),
                            textfieldPadding: AutilabMargin.marginFullScreen
                                .copyWith(bottom: 16),
                            textStyle: AutilabTextStyle.small14_400.copyWith(
                              fontSize: isMobile() ? 14 : 20,
                            ),
                            lblColor: passwordController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            padding: EdgeInsets.symmetric(
                                vertical: isMobile() ? 0 : 20, horizontal: 15),
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
                            isMobile: isMobile(),
                            textfieldPadding: AutilabMargin.marginFullScreen
                                .copyWith(bottom: 4),
                            textStyle: AutilabTextStyle.small14_400.copyWith(
                              fontSize: isMobile() ? 14 : 20,
                            ),
                            lblColor: passwordController.text.isNotEmpty
                                ? AutilabColor.black
                                : AutilabColor.gray,
                            padding: EdgeInsets.symmetric(
                                vertical: isMobile() ? 0 : 20, horizontal: 15),
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
                          BlocConsumer<AuthenticationBloc, AuthenticationState>(
                            listener: (context, state) {
                              if (state is AuthenticationError) {
                                displaySnackBar(
                                  context,
                                  state.errorMessage.toString(),
                                  AutilabColor.bb,
                                );
                              }
                              if (state is AuthenticationResponse) {
                                state.response.fold(
                                  (error) {
                                    displaySnackBar(
                                      context,
                                      error,
                                      AutilabColor.bb,
                                    );
                                  },
                                  (response) async {
                                    await SharedPreferencesData.userLogIn(true);
                                    await SharedPreferencesData
                                        .isFirstTimeLogIn(false);

                                    context.goNamed(
                                        AutiLabRoutes.bottomNavigationScreen);
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              return CustomButtonWidget(
                                isMobile: isMobile(),
                                isLoading: state is AuthenticationLoading,
                                onTap: () {
                                  if (firstNameController.text.isNotEmpty &&
                                      emailController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    //Call SignUpRequest Event
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(
                                      SignUpRequest(
                                        userParam: UserParam(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      ),
                                    );
                                  } else {
                                    displaySnackBar(
                                      context,
                                      'Please fill in all fields.',
                                      AutilabColor.bb,
                                    );
                                  }
                                },
                                height: 50,
                                margin: AutilabMargin.marginFullScreen
                                    .copyWith(bottom: 48, top: 32),
                                color: AutilabColor.bb,
                                text: 'Sign Up',
                                textStyle: AutilabTextStyle.small16_400,
                              );
                            },
                          ),
                          // Row(
                          //   children: [
                          //     const Expanded(
                          //       child: Divider(
                          //         thickness: 3,
                          //         indent: 20,
                          //         color: AutilabColor.bb,
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 8),
                          //       child: Text(
                          //         'Or Sign up With',
                          //         style: AutilabTextStyle.small14_400.copyWith(
                          //           color: const Color(0xff555252),
                          //           fontSize: isMobile() ? 12 : 18,
                          //         ),
                          //       ),
                          //     ),
                          //     const Expanded(
                          //       child: Divider(
                          //         thickness: 3,
                          //         endIndent: 20,
                          //         color: AutilabColor.bb,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // Row(
                          //   spacing: 16,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     circularWidgetSignUp(
                          //       isMobile: isMobile(),
                          //       image: 'assets/images/google_logo.svg',
                          //       onTap: () {},
                          //     ),
                          //     circularWidgetSignUp(
                          //       isMobile: isMobile(),
                          //       image: 'assets/images/facbook_logo.svg',
                          //       onTap: () {},
                          //     ),
                          //     circularWidgetSignUp(
                          //       isMobile: isMobile(),
                          //       image: 'assets/images/apple_logo.svg',
                          //       onTap: () {},
                          //     ),
                          //   ],
                          // ),
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
          ),
        );
      },
    );
  }
}
