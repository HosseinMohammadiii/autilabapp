import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/plan_box_widget.dart';
import '../../../../common/widgets/responsive_widget.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/Lists/package_info_list.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/data/model/plan_model.dart';

class PackagesSubscribtion extends StatefulWidget {
  const PackagesSubscribtion({
    super.key,
    required this.planModel,
    required this.planDescription,
  });
  final List<PlanModel> planModel;
  final List<PlanFeatures>? planDescription;
  @override
  State<PackagesSubscribtion> createState() => _PackagesSubscribtionState();
}

class _PackagesSubscribtionState extends State<PackagesSubscribtion>
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
  void didUpdateWidget(covariant PackagesSubscribtion oldWidget) {
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

        return ResponsiveLayout(
          child: FadeTransition(
            opacity: animationHelper.fadeAnimation,
            child: Scaffold(
              appBar: appBarWidget(
                context: context,
                title: 'Subscribtion',
                isIcon: true,
                isMobile: isMobile(),
              ),
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
                          child: SizedBox(
                            height: 430,
                            child: PlanBoxWidget(
                              isMobile: isMobile(),
                              title: widget.planModel[index].name,
                              description: widget.planModel[index].description,
                              titleButton: 'Choose',
                              widget: widget.planDescription,
                              onTap: () {
                                context.pushNamed(
                                  AutiLabRoutes.payPackagesScreen,
                                  extra: {
                                    'title': widget.planModel[index].name,
                                    'description': widget
                                        .planDescription![index].description,
                                    'planModel': widget.planModel[index],
                                    'planDescription': widget.planDescription,
                                    'price':
                                        widget.planModel[index].price.toInt(),
                                  },
                                );
                              },
                              margin: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
