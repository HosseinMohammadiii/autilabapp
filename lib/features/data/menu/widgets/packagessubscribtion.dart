import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/plan_box_widget.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/Lists/package_info_list.dart';
import '../../home/widgets/plan_item_widget.dart';

class PackagesSubscribtion extends StatelessWidget {
  const PackagesSubscribtion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidget(context: context, title: 'Subscribtion', isIcon: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: AutilabMargin.marginFullScreen,
                itemCount: titlePlanList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: PlanBoxWidget(
                    title: titlePlanList[index],
                    description: descriptionPlanList[index],
                    titleButton: 'Choose',
                    widget: const [
                      PalnItemWidget(
                        title: 'Full access to the tools section',
                      ),
                      PalnItemWidget(
                        title: 'Access to aptitude test',
                      ),
                      PalnItemWidget(
                        title: 'Access to personality test',
                      ),
                      PalnItemWidget(
                        title: 'Unlimited appointment booking',
                      ),
                      PalnItemWidget(
                        title: 'Access to nearby centers',
                      ),
                      PalnItemWidget(
                        title: 'Doctor appointment booking discount',
                      ),
                    ],
                    onTap: () {
                      int price = 0;
                      if (index == 1) {
                        price = 99;
                      } else {
                        price = 299;
                      }
                      context.pushNamed(
                        AutiLabRoutes.payPackagesScreen,
                        extra: {
                          'title': titlePlanList[index],
                          'description': descriptionPlanList[index],
                          'price': price,
                        },
                      );
                    },
                    margin: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
