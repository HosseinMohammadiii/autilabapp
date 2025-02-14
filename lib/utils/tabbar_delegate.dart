import 'package:flutter/material.dart';

import '../core/constants/color_constant.dart';

class TabbarViewDelegate extends SliverPersistentHeaderDelegate {
  TabbarViewDelegate(this._tabbar);
  final TabBar _tabbar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: double.infinity,
      height: 50,
      color: AutilabColor.white,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AutilabColor.lightGray,
          borderRadius: BorderRadius.circular(16),
        ),
        child: _tabbar,
      ),
    );
  }

  @override
  double get maxExtent => _tabbar.preferredSize.height;

  @override
  double get minExtent => _tabbar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
