import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';
import '../../utils/tabbar_delegate.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    // required this.leading,
    required this.tabLength,
    required this.tabBar,
    required this.tabBarView,
  });
  final int tabLength;
  final List<Widget> tabBar;
  final List<Widget> tabBarView;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(seconds: 1),
      length: tabLength,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // SliverAppBar(
            //   leading: leading,
            //   leadingWidth: double.infinity,
            // ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: TabbarViewDelegate(
                TabBar(
                  labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
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
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
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
