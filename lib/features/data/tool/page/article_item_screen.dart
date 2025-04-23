import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class ArticleItemScreen extends StatefulWidget {
  const ArticleItemScreen({super.key});

  @override
  State<ArticleItemScreen> createState() => _ArticleItemScreenState();
}

class _ArticleItemScreenState extends State<ArticleItemScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ArticleItemScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('data'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
