import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchFocusNode,
    required this.searchController,
    this.isMobile = true,
  });

  final bool isMobile;
  final FocusNode searchFocusNode;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: searchFocusNode,
      controller: searchController,
      cursorColor: Colors.black,
      style: AutilabTextStyle.small14_400.copyWith(
        fontSize: isMobile ? 14 : 24,
      ),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15, vertical: isMobile ? 16 : 20),
        prefixIcon: SvgPicture.asset(
          fit: BoxFit.scaleDown,
          'assets/icons/search_icon.svg',
          width: isMobile ? 24 : 32,
          height: isMobile ? 24 : 32,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AutilabColor.black,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AutilabColor.black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: AutilabColor.black,
            width: 1,
          ),
        ),
      ),
      onChanged: (value) {},
      onTapOutside: (event) {
        //Unfocus TextField
        searchFocusNode.unfocus();
      },
    );
  }
}
