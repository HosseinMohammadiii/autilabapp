//Widget appBar for login section
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget appBarWidget({
  required BuildContext context,
  required String title,
  bool? isIcon,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leadingWidth: double.infinity,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Visibility(
            visible: isIcon ?? false,
            replacement: GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
