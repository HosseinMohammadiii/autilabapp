import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/nearby_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';
import '../../../../utils/functions/cacheimahe_function.dart';
import '../../../../utils/functions/open_location_function.dart';

class NearbyCenterScreen extends StatefulWidget {
  const NearbyCenterScreen({
    super.key,
  });

  @override
  State<NearbyCenterScreen> createState() => _NearbyCenterScreenState();
}

class _NearbyCenterScreenState extends State<NearbyCenterScreen>
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
  void didUpdateWidget(covariant NearbyCenterScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile() {
          if (constraints.maxWidth < 600) {
            return true;
          } else {
            return false;
          }
        }

        return FadeTransition(
          opacity: animationHelper.fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  // width: double.infinity,
                  height: isMobile() ? 441 : 601,
                  padding: EdgeInsets.all(isMobile() ? 24 : 32),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    color: AutilabColor.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AutilabColor.bb),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            openMap(context, 49.2331, -123.0992);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(isMobile() ? 16 : 24),
                              border: Border.all(
                                color: AutilabColor.bb,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(isMobile() ? 16 : 24),
                              child: Image.asset(
                                'assets/images/map_image.png',
                                width: double.infinity,
                                fit: BoxFit.fill,
                                cacheWidth: cacheImageFunction(
                                    isMobile() ? 450 : 600, context),
                                cacheHeight: cacheImageFunction(
                                    isMobile() ? 450 : 600, context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Find Nearby centers',
                        style: AutilabTextStyle.medium20_500.copyWith(
                          fontSize: isMobile() ? 20 : 28,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Tap The Map And Select Your Location To See The Centers Near You.',
                        textAlign: TextAlign.center,
                        style: AutilabTextStyle.small16_400.copyWith(
                          fontSize: isMobile() ? 16 : 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    'Suggestions',
                    style: AutilabTextStyle.small20_400.copyWith(
                      fontSize: isMobile() ? 20 : 40,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return NearbyCardWidget(
                    isMobile: isMobile(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
