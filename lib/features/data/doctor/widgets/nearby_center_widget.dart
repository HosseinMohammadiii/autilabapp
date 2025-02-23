import 'package:autilab_project/features/data/doctor/widgets/nearby_card_widget.dart';
import 'package:flutter/material.dart';

class NearbyCenterWidget extends StatelessWidget {
  const NearbyCenterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
            height: 441,
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 45),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffECF0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/map_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Find Nearby centers',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 8,
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
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
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
        SliverList.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const NearbyCardWidget();
          },
        ),
      ],
    );
  }
}
