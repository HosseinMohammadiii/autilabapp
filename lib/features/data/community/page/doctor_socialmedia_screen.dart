import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
import '../../../../common/widgets/responsive_widget.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/all_media_doctor_widget.dart'
    show DisplayAllDoctorMediaWidget;

class DoctorSocialMediaScreen extends StatefulWidget {
  const DoctorSocialMediaScreen({super.key});

  @override
  State<DoctorSocialMediaScreen> createState() =>
      _DoctorSocialMediaScreenState();
}

class _DoctorSocialMediaScreenState extends State<DoctorSocialMediaScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  late AnimationHelper animationHelper;
  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DoctorSocialMediaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: FadeTransition(
        opacity: animationHelper.fadeAnimation,
        child: Scaffold(
          appBar: appBarWidget(
              context: context, title: 'Doctor’s Social media', isIcon: true),
          body: SafeArea(
            child: DefaultTabController(
              length: 4,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 48, bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xffECF0FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) {
                        return [
                          SliverToBoxAdapter(
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffECF0FF),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            displayFollowersAndFollowing(
                                              count: '1 k',
                                              title: 'Followers',
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                  'assets/images/doctor_image.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            displayFollowersAndFollowing(
                                              count: '342',
                                              title: 'Following',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        'Dr. Sophia Martinez',
                                        style: AutilabTextStyle.medium16_500,
                                      ),
                                      Text(
                                        '@sophia_mz',
                                        style: AutilabTextStyle.small12_400
                                            .copyWith(
                                          color: AutilabColor.gray,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Text(
                                          'I am dr sophia martinez, I like dancing in the rain and travelling all around the world.',
                                          textAlign: TextAlign.center,
                                          style: AutilabTextStyle.small14_400,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomButtonWidget(
                                            onTap: () {},
                                            height: 41,
                                            width: 120,
                                            borderRadius: 16,
                                            color: AutilabColor.bb,
                                            margin: const EdgeInsets.only(
                                                right: 30),
                                            text: 'Follow',
                                            boxShadow: [
                                              BoxShadow(
                                                color: AutilabColor.black
                                                    .withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                            textStyle:
                                                AutilabTextStyle.small16_400,
                                          ),
                                          CustomButtonWidget(
                                            onTap: () {},
                                            height: 41,
                                            width: 120,
                                            borderRadius: 16,
                                            color: AutilabColor.white,
                                            margin:
                                                const EdgeInsets.only(left: 30),
                                            text: 'Message',
                                            boxShadow: [
                                              BoxShadow(
                                                color: AutilabColor.black
                                                    .withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                            textStyle:
                                                AutilabTextStyle.small16_400,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 34),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverPersistentHeader(
                            floating: true,
                            pinned: true,
                            delegate: TabbarViewDelegate(
                              TabBar(
                                indicatorColor: AutilabColor.gray,
                                dividerHeight: 0,
                                controller: _tabController,
                                tabs: [
                                  _titleTabBar(context, 'All'),
                                  _titleTabBar(context, 'Photos'),
                                  _titleTabBar(context, 'Videos'),
                                  _titleTabBar(context, 'Article'),
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        controller: _tabController,
                        children: const [
                          DisplayAllDoctorMediaWidget(),
                          SizedBox(height: 100),
                          SizedBox(height: 100),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//Widget for display title TabBar
  Widget _titleTabBar(BuildContext context, String title) {
    return FittedBox(
      child: Text(
        title,
        style: AutilabTextStyle.small14_400,
      ),
    );
  }

//Widget for display followers count & following count
  Widget displayFollowersAndFollowing({
    required String count,
    required String title,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: AutilabTextStyle.medium16_400,
        ),
        Text(
          title,
          style: AutilabTextStyle.small14_400.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class TabbarViewDelegate extends SliverPersistentHeaderDelegate {
  TabbarViewDelegate(this._tabbar);
  final TabBar _tabbar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xffECF0FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: _tabbar,
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
