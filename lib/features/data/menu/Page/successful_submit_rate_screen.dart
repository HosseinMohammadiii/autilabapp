import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';

class SuccessfulSubmitRateScreen extends StatelessWidget {
  const SuccessfulSubmitRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 128,
              height: 128,
              margin: const EdgeInsets.only(bottom: 48),
              decoration: const BoxDecoration(
                color: AutilabColor.yellow,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/tik.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
            const Text(
              'Thank You For Your Feedback!',
              textAlign: TextAlign.center,
              style: AutilabTextStyle.medium20_500,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "We're always working to serve you better.",
              textAlign: TextAlign.center,
              style: AutilabTextStyle.small16_400
                  .copyWith(color: AutilabColor.gray),
            ),
            CustomButtonWidget(
              onTap: () {
                context.pop();
                context.pop();
              },
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              color: AutilabColor.bb,
              text: 'OK ',
              textStyle: AutilabTextStyle.small18_400,
            ),
          ],
        ),
      ),
    );
  }
}
