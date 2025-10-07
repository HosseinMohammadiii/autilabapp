import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/common/widgets/snackbar_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/auth/data/model/user_param.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_bloc.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_event.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_state.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/network/shared_preferences.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../common/widgets/appbar_back_screen.dart';
import '../../../home/presentation/bloc/home_event.dart';

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
                              'assets/images/logIn_image.svg',
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
                            textfieldPadding: AutilabMargin.marginFullScreen,
                            controller: userNameController,
                            focusNode: userNameFocusNode,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            label: 'Email',
                            maxLines: 1,
                            borderColor: AutilabColor.blue,
                          ),
                          CustomTextfield(
                            isMobile: isMobile(),
                            textfieldPadding: AutilabMargin.marginFullScreen
                                .copyWith(top: 16, bottom: 4),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .pushNamed(AutiLabRoutes.sendEmailScreen);
                              },
                              child: Text(
                                'Forget Password?',
                                style: AutilabTextStyle.small14_400.copyWith(
                                  fontSize: isMobile() ? 14 : 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocConsumer<AuthenticationBloc, AuthenticationState>(
                            listener: (context, state) async {
                              if (state is AuthenticationError) {
                                displaySnackBar(
                                  context,
                                  state.errorMessage.toString(),
                                  AutilabColor.bb,
                                );
                              }
                              if (state is AuthenticationResponse) {
                                state.response.fold(
                                    (error) => displaySnackBar(
                                          context,
                                          error.message,
                                          AutilabColor.bb,
                                        ), (respose) async {
                                  await SharedPreferencesData.userLogIn(true);
                                  await SharedPreferencesData.isFirstTimeLogIn(
                                      false);

                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(DisplayInformationUser());
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(DisplayHomeContent());

                                  context.goNamed(
                                      AutiLabRoutes.bottomNavigationScreen);
                                });
                              }
                            },
                            builder: (context, state) {
                              return CustomButtonWidget(
                                isMobile: isMobile(),
                                isLoading: state is AuthenticationLoading,
                                margin: AutilabMargin.marginFullScreen
                                    .copyWith(top: 32, bottom: 48),
                                onTap: () {
                                  if (userNameController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    //Call SignUpRequest Event
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(
                                      LogInRequest(
                                        userParam: UserParam(
                                          email: userNameController.text,
                                          password: passwordController.text,
                                          firstName: 'ss',
                                          lastName: 'ss',
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
                                color: AutilabColor.bb,
                                text: 'LogIn',
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
                          //         style: AutilabTextStyle.small12_400.copyWith(
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
