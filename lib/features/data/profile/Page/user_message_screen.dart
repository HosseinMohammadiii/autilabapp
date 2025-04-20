import 'package:autilab_project/common/widgets/appbar_back_screen.dart';

import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/message_box_profiel_widget.dart';

class UserMessageScreen extends StatefulWidget {
  const UserMessageScreen({super.key});

  @override
  State<UserMessageScreen> createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final searchController = TextEditingController();

  final searchFocusNode = FocusNode();

  bool isChecked = false;

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
  void didUpdateWidget(covariant UserMessageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Message', isIcon: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // spacing: 16,
              children: [
                const SizedBox(
                  height: 48,
                ),
                const MesseageBoxProfile(
                  isMessage: true,
                  content: '2',
                ),
                const SizedBox(
                  height: 16,
                ),
                const MesseageBoxProfile(
                  isMessage: true,
                  content: '1',
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: MesseageBoxProfile(
                        isMessage: false,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
