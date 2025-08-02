import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class ExitPageDialogWidget extends StatelessWidget {
  const ExitPageDialogWidget({
    super.key,
    required this.isMobile,
  });
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: isMobile ? 56 : 106,
            width: isMobile ? 56 : 106,
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AutilabColor.yellow,
            ),
            child: SvgPicture.asset(
              'assets/icons/information.svg',
              colorFilter: const ColorFilter.mode(
                AutilabColor.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          Text(
            'Wait A Second !',
            style: AutilabTextStyle.medium20_500.copyWith(
              fontSize: isMobile ? 20 : 32,
            ),
          ),
          Padding(
            padding: AutilabMargin.marginFullScreen,
            child: Text(
              "Leaving now will erase all your answers and you'll have to start over. Do you want to stay and finish your test?",
              textAlign: TextAlign.center,
              style: AutilabTextStyle.small16_400.copyWith(
                fontSize: isMobile ? 16 : 24,
                color: AutilabColor.gray,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dialogButtonWidget(
                isMobile,
                AutilabColor.bb,
                AutilabColor.drawerWhite,
                'Exit Anyway',
                () {
                  context.pop(true);
                },
              ),
              dialogButtonWidget(
                isMobile,
                null,
                AutilabColor.bb,
                'Keep Going',
                () {
                  context.pop(false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Button widget for display in exit dialog page
  Widget dialogButtonWidget(
    bool isMobile,
    Color? borderColor,
    Color backgroundColor,
    String title,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isMobile ? 47 : 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != null ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AutilabTextStyle.small16_400.copyWith(
              fontSize: isMobile ? 16 : 24,
            ),
          ),
        ),
      ),
    );
  }
}
