import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    super.key,
    required this.isSignUp,
  });
  final bool isSignUp;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final userNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Text(
              'Back',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: widget.isSignUp
                    ? SvgPicture.asset('assets/images/signUp_image.svg')
                    : SvgPicture.asset('assets/images/logIn_image.svg'),
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
              if (widget.isSignUp) ...[
                CustomTextfield(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  label: 'Email',
                  maxLines: 1,
                  borderColor: AutilabColor.blue,
                ),
              ],
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
                child: Text(
                  widget.isSignUp
                      ? 'Already have an account?'
                      : 'Forget Password?',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButtonWidget(
                onTap: () {},
                height: 50,
                color: AutilabColor.bb,
                text: widget.isSignUp ? 'Sign Up' : 'LogIn',
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 16,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Or Sign up With',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: const Color(0xff555252),
                            fontWeight: FontWeight.w400,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circularWidgetSignUp(
                    image: 'assets/images/google_logo.svg',
                    onTap: () {},
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  circularWidgetSignUp(
                    image: 'assets/images/facbook_logo.svg',
                    onTap: () {},
                  ),
                  const SizedBox(
                    width: 8,
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
      ),
    );
  }

//Widget for display Icons to SignUp Account
  Widget circularWidgetSignUp({
    required String image,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AutilabColor.lightGray,
          border: Border.all(
            color: AutilabColor.blue,
            width: 0.5,
          ),
        ),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
