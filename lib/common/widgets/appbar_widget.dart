import 'package:autilab_project/common/widgets/cached_network_image_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

PreferredSizeWidget appBarWidget(BuildContext context) {
  return AppBar(
    leadingWidth: double.infinity,
    leading: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // scaffoldKey.currentState?.openDrawer();
            },
            child: const Icon(Icons.menu),
          ),
          Column(
            children: [
              Text(
                'Current location',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AutilabColor.gray,
                    ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/gps.svg'),
                    Text(
                      'Toronto,Canada',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachednetworkimageWidget(
              imgUrl: '',
              img: Image.asset('assets/images/child_image.png'),
              isNetworkImage: false,
            ),
          ),
        ],
      ),
    ),
  );
}
