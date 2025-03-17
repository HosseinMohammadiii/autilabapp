import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/nearby_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/functions/animation_control.dart';

class NearbyCenterWidget extends StatefulWidget {
  const NearbyCenterWidget({
    super.key,
  });

  @override
  State<NearbyCenterWidget> createState() => _NearbyCenterWidgetState();
}

class _NearbyCenterWidgetState extends State<NearbyCenterWidget>
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
  void didUpdateWidget(covariant NearbyCenterWidget oldWidget) {
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/map_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Find Nearby centers',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Tap the map and select your location to see centers near you.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Suggestions',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
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
              return const NearbyCardWidget();
            },
          ),
        ],
      ),
    );
  }
}
