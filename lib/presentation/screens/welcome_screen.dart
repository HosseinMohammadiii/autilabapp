import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constant_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/welcome_image.svg',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Welcome To Autilab!',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Lorem Ipsum Odor Amet, Consectetuer Adipiscing Consectetuer Elit.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            CustomButtonWidget(
              onTap: () {
                context.goNamed(
                  AutiLabRoutes.loginScreen,
                  extra: {
                    'isSignUp': false,
                  },
                );
              },
              height: 50,
              color: AutilabColor.bb,
              text: 'Login',
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            CustomButtonWidget(
              onTap: () {
                context.goNamed(
                  AutiLabRoutes.loginScreen,
                  extra: {
                    'isSignUp': true,
                  },
                );
              },
              height: 50,
              color: AutilabColor.white,
              text: 'Sign Up',
              width: 70,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AutilabColor.blue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
