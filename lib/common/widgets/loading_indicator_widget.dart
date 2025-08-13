import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';

class LoadingProgressWidget extends StatelessWidget {
  const LoadingProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AutilabColor.bb,
        ),
      ),
    );
  }
}
