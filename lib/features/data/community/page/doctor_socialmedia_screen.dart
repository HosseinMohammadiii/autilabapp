import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar_back_screen.dart';
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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Doctor’s Social media', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 665,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 48),
                      decoration: BoxDecoration(
                        color: const Color(0xffECF0FF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                displayFollowersAndFollowing(
                                  count: '1 k',
                                  title: 'Followers',
                                ),
                                displayFollowersAndFollowing(
                                  count: '342',
                                  title: 'Following',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Dr. Sophia Martinez',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            '@sophia_mz',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AutilabColor.gray,
                                    ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'I am dr sophia martinez, I like dancing in the rain and travelling all around the world.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButtonWidget(
                                onTap: () {},
                                height: 41,
                                width: 120,
                                borderRadius: 16,
                                color: AutilabColor.bb,
                                margin: const EdgeInsets.only(left: 30),
                                text: 'Follow',
                                boxShadow: [
                                  BoxShadow(
                                    color: AutilabColor.black
                                        .withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              CustomButtonWidget(
                                onTap: () {},
                                height: 41,
                                width: 120,
                                borderRadius: 16,
                                color: AutilabColor.white,
                                margin: const EdgeInsets.only(right: 30),
                                text: 'Message',
                                boxShadow: [
                                  BoxShadow(
                                    color: AutilabColor.black
                                        .withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 34,
                          ),
                          TabBar(
                            controller: _tabController,
                            dividerColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            indicator: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: AutilabColor.gray,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            tabs: [
                              _titleTabBar(context, 'All'),
                              _titleTabBar(context, 'Photos'),
                              _titleTabBar(context, 'Videos'),
                              _titleTabBar(context, 'Article'),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                DisplayAllDoctorMediaWidget(),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/doctor_image.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ],
    );
  }
}
