import 'package:flutter/material.dart';

class TabbarViewDelegate extends SliverPersistentHeaderDelegate {
  Widget widget;
  final double height;
  TabbarViewDelegate({required this.widget, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
