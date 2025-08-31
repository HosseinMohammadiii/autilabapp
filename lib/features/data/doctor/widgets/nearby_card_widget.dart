import 'package:autilab_project/common/widgets/cached_network_image_widget.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/data/model/center_model.dart';
import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:autilab_project/features/data/tool/widgets/likewidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../utils/functions/cacheimahe_function.dart';

// ignore: must_be_immutable
class NearbyCardWidget extends StatefulWidget {
  NearbyCardWidget({
    super.key,
    this.isMobile = true,
    this.isShowButton,
    this.isLike,
    this.center,
  });
  final bool isMobile;
  final bool? isShowButton;
  bool? isLike;
  final CenterModel? center;

  @override
  State<NearbyCardWidget> createState() => _NearbyCardWidgetState();
}

class _NearbyCardWidgetState extends State<NearbyCardWidget> {
  bool isLike = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.isMobile ? 16 : 24),
            child: CachednetworkimageWidget(
              width: widget.isMobile ? 320 : 722,
              height: widget.isMobile ? 213 : 315,
              imgUrl: widget.center?.imageurl ?? '',
              img: Image.asset(
                'assets/images/autism_help_center.jpg',
                fit: BoxFit.fill,
                width: widget.isMobile ? 320 : 722,
                height: widget.isMobile ? 213 : 315,
                cacheWidth:
                    cacheImageFunction(widget.isMobile ? 320 : 722, context),
                cacheHeight:
                    cacheImageFunction(widget.isMobile ? 213 : 315, context),
              ),
              isNetworkImage: widget.center?.imageurl == null ? false : true,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.center?.name ?? 'Autism Help Center',
                    style: AutilabTextStyle.medium18_500.copyWith(
                      fontSize: widget.isMobile ? 18 : 32,
                    ),
                  ),
                ),
                ButtonCard(
                  isMobile: widget.isMobile,
                  onTap: () {
                    context.pushNamed(
                      AutiLabRoutes.doctorMessageScreen,
                      extra: {
                        'image': 'assets/images/autism_help_center.png',
                        'name': widget.center?.name ?? 'Autism Help Center',
                        'expertise': '',
                      },
                    );
                  },
                  margin: const EdgeInsets.all(0),
                  icon: 'assets/icons/messages.svg',
                ),
                Container(
                  width: widget.isMobile ? 32 : 68,
                  height: widget.isMobile ? 32 : 68,
                  margin: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    color: AutilabColor.bb,
                    borderRadius:
                        BorderRadius.circular(widget.isMobile ? 12 : 24),
                  ),
                  child: LikeWidget(
                    isMobile: widget.isMobile,
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
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 72,
            child: Text(
              widget.center?.centerinformation ??
                  'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
              style: AutilabTextStyle.small14_400.copyWith(
                  overflow: widget.isShowButton == false
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  fontSize: widget.isMobile ? 14 : 24),
              maxLines: 3,
              textAlign: TextAlign.left,
            ),
          ),
          Visibility(
            visible: widget.isShowButton ?? true,
            child: CustomButtonWidget(
              isMobile: widget.isMobile,
              onTap: () {
                context
                    .pushNamed(AutiLabRoutes.nearbyCenterDetailScreen, extra: {
                  'isLike': widget.isLike,
                  'centerModel': widget.center,
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
