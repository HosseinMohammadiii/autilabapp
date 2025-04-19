import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/color_constant.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchFocusNode,
    required this.searchController,
  });

  final FocusNode searchFocusNode;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: searchFocusNode,
      controller: searchController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        prefixIcon: SvgPicture.asset(
          fit: BoxFit.none,
          'assets/icons/search_icon.svg',
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
