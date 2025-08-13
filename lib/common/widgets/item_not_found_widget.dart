import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ItemNotFoundWidget extends StatelessWidget {
  const ItemNotFoundWidget({
    super.key,
    required this.isMobile,
  });
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/item_notfound.svg',
          width: isMobile ? 160 : 240,
          height: isMobile ? 160 : 240,
        ),
        Text(
          'Item Not Found',
          style: AutilabTextStyle.medium20_500.copyWith(
            fontSize: isMobile ? 20 : 32,
          ),
        ),
        CustomButtonWidget(
          isMobile: isMobile,
          onTap: () {
            context.goNamed(AutiLabRoutes.doctorScreen);
          },
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          color: AutilabColor.bb,
          text: 'Search Something Else',
          textStyle: AutilabTextStyle.small18_400,
        ),
      ],
    );
  }
}
