import 'package:autilab_project/common/widgets/bubble_background_widget.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/appbar_login_section.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SendEmailCodeScreen extends StatefulWidget {
  const SendEmailCodeScreen({super.key});

  @override
  State<SendEmailCodeScreen> createState() => _SendEmailCodeScreenState();
}

class _SendEmailCodeScreenState extends State<SendEmailCodeScreen>
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
  void didUpdateWidget(covariant SendEmailCodeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                      'assets/images/enter_code_email_image.svg'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'We will send you one time password to',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'example@gmail.com',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AutilabColor.blue,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 52,
                      fieldWidth: 52,
                      inactiveBorderWidth: 0.5,
                      activeColor: AutilabColor.blue,
                      inactiveColor: AutilabColor.black,
                    ),
                    cursorColor: AutilabColor.black,
                    onCompleted: (v) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                CustomButtonWidget(
                  onTap: () {
                    context.pushReplacementNamed(
                        AutiLabRoutes.buttomNavigationScreen);
                  },
                  height: 50,
                  color: AutilabColor.bb,
                  text: 'Send Code',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const BubbleBackgroundWidget(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
