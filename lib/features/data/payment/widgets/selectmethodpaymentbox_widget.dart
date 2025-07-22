import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class SelectMethodPayBoxWidget extends StatelessWidget {
  const SelectMethodPayBoxWidget({
    super.key,
    this.isMobile = true,
    required this.selectedIndexNotifier,
    this.isBorder = true,
    required this.title,
    required this.logo,
    required this.index,
  });
  final bool isMobile;
  final ValueNotifier<int?> selectedIndexNotifier;
  final bool isBorder;
  final String title;
  final String logo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 56 : 72,
      padding: EdgeInsets.all(isBorder ? 16 : 0),
      margin: isBorder ? AutilabMargin.marginFullScreen : null,
      decoration: BoxDecoration(
        border: Border.all(
            color: isBorder ? AutilabColor.black : Colors.transparent),
        borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
      ),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Row(
              children: [
                ValueListenableBuilder<int?>(
                  valueListenable: selectedIndexNotifier,
                  builder: (context, selectedIndex, child) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndexNotifier.value = index;
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AutilabColor.black),
                          shape: BoxShape.circle,
                        ),
                        child: selectedIndex == index
                            ? const Icon(
                                Icons.done_rounded,
                                size: 16,
                              )
                            : const SizedBox(),
                      ),
                    );
                  },
                ),
                Text(
                  title,
                  style: AutilabTextStyle.medium16_500.copyWith(
                    fontSize: isMobile ? 16 : 24,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isBorder,
            replacement: Row(
              spacing: 4,
              children: [
                SvgPicture.asset(
                  'assets/icons/discover_logo.svg',
                  height: isMobile ? 12 : 32,
                ),
                SvgPicture.asset(
                  'assets/icons/visa_logo.svg',
                  height: isMobile ? 12 : 32,
                ),
                SvgPicture.asset(
                  'assets/icons/mastercard_logo.svg',
                  height: isMobile ? 12 : 32,
                ),
              ],
            ),
            child: SvgPicture.asset(
              logo,
            ),
          ),
        ],
      ),
    );
  }
}
