import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';

// ignore: must_be_immutable
class NearbyCardWidget extends StatefulWidget {
  NearbyCardWidget({
    super.key,
    this.isShowButton,
    this.isLike,
  });
  final bool? isShowButton;
  bool? isLike;

  @override
  State<NearbyCardWidget> createState() => _NearbyCardWidgetState();
}

class _NearbyCardWidgetState extends State<NearbyCardWidget> {
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FittedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/autism_help_center.png',
                fit: BoxFit.fill,
                width: 320,
                height: 213,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Autism Help Center',
                    style: AutilabTextStyle.medium18_500,
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: AutilabColor.bb,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: LikeWidget(
                    backgroundColor: AutilabColor.bb,
                    isLike: widget.isLike ?? false,
                    onTap: () {
                      setState(() {
                        isLike = !isLike;
                        widget.isLike = isLike;
                      });
                    },
                  ),
                ),
                ButtonCard(
                  onTap: () {
                    context.pushNamed(
                      AutiLabRoutes.doctorMessageScreen,
                      extra: {
                        'image': 'assets/images/autism_help_center.png',
                        'name': 'Autism Help Center',
                        'expertise': '',
                      },
                    );
                  },
                  margin: const EdgeInsets.all(0),
                  icon: 'assets/icons/messages.svg',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 72,
            child: Text(
              'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
              style: AutilabTextStyle.small14_400.copyWith(
                overflow: widget.isShowButton == false
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),
              maxLines: 3,
              textAlign: TextAlign.justify,
            ),
          ),
          Visibility(
            visible: widget.isShowButton ?? true,
            child: CustomButtonWidget(
              onTap: () {
                context
                    .pushNamed(AutiLabRoutes.nearbyCenterDetailScreen, extra: {
                  'isLike': widget.isLike,
                });
              },
              height: 50,
              margin: const EdgeInsets.only(bottom: 8, top: 24),
              color: AutilabColor.bb,
              text: 'See Details',
              textStyle: AutilabTextStyle.small18_400,
            ),
          ),
        ],
      ),
    );
  }
}
