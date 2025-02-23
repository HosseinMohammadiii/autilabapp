//Method for display Specialties category dialog
import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';

void showCustomDialog(BuildContext context, Widget widget) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: Dialog(
          backgroundColor: AutilabColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: widget,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 600),
  );
}
