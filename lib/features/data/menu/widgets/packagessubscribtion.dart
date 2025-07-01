import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/plan_box_widget.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../home/widgets/plan_item_widget.dart';

class PackagesSubscribtion extends StatelessWidget {
  const PackagesSubscribtion({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titlePlanList = ['Free Plan', '99\$/Month', "299\$/Years"];

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
                    titleButton: 'Choose',
                    widget: [
                      PalnItemWidget(),
                      PalnItemWidget(),
                      PalnItemWidget(),
                      PalnItemWidget(),
                    ],
                    onTap: () {
                      context.pushNamed(
                        AutiLabRoutes.payPackagesScreen,
                        extra: {
                          'title': titlePlanList[index],
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
