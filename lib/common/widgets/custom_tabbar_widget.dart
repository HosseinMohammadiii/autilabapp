import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../utils/tabbar_delegate.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.tabLength,
    required this.tabBar,
    required this.tabBarView,
    this.isScrollable,
  });
  final int tabLength;
  final List<Widget> tabBar;
  final List<Widget> tabBarView;
  final bool? isScrollable;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(seconds: 1),
      length: tabLength,
      child: NestedScrollView(
        physics: isScrollable == false
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: TabbarViewDelegate(
                widget: Container(
                  width: double.infinity,
                  color: AutilabColor.white,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AutilabColor.lightGray,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      labelStyle: AutilabTextStyle.small18_400.copyWith(
                        color: Colors.black,
                      ),
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AutilabColor.bb,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: tabBar,
                    ),
                  ),
                ),
                height: 60,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: tabBarView,
        ),
      ),
    );
  }
}
