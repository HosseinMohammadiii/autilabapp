//Widget appBar for login section
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget appBarWidget(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    leadingWidth: double.infinity,
    elevation: 0,
    scrolledUnderElevation: 0,
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
  );
}
