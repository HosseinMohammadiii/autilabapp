import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/nearby_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 441,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 46),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 46),
              decoration: BoxDecoration(
                color: AutilabColor.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AutilabColor.bb),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AutilabColor.bb,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/map_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Find Nearby centers',
                    style: AutilabTextStyle.medium20_500,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Tap the map and select your location to see centers near you.',
                    textAlign: TextAlign.center,
                    style: AutilabTextStyle.small16_400,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Suggestions',
                style: AutilabTextStyle.small20_400,
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
              return const NearbyCardWidget();
            },
          ),
        ],
      ),
    );
  }
}
