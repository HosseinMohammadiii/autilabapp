import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/loading_indicator_widget.dart';
import '../../../../common/widgets/responsive_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/network/locator.dart';
import '../../../../presentation/screens/not_connection_screen.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../auth/presentetion/bloc/auth_bloc.dart';
import '../../auth/presentetion/bloc/auth_event.dart';
import '../../home/data/model/plan_model.dart';
import '../../home/presentation/bloc/home_bloc.dart';
import '../../home/presentation/bloc/home_state.dart';

class MySubscribtionScreen extends StatefulWidget {
  const MySubscribtionScreen({super.key});

  @override
  State<MySubscribtionScreen> createState() => _MySubscribtionScreenState();
}

class _MySubscribtionScreenState extends State<MySubscribtionScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  List<PlanModel> planModel = [];
  List<PlanFeatures> feuturePlanModel = [];

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
  void didUpdateWidget(covariant MySubscribtionScreen oldWidget) {
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
                title: 'My Subscribtion',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: BlocProvider(
                  create: (context) =>
                      HomeBloc(locator.get())..add(DisplayHomeContent()),
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is HomeFetchData) {
                        state.homeResponse.fold(
                          (l) {},
                          (response) {
                            for (var plan in response) {
                              planModel = plan.planModel;
                              for (var feature in plan.planModel) {
                                feuturePlanModel = feature.planFeatures;
                              }
                            }
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const LoadingProgressWidget();
                      }
                      if (state is HomeErrorHandling) {
                        return NotConnectionInternetScreen(
                          onChange: () async {
                            context.read<HomeBloc>().add(DisplayHomeContent());
                          },
                        );
                      }
                      if (state is HomeFetchData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.only(bottom: 48),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AutilabColor.yellow,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/crown_icon.svg',
                                height: isMobile() ? 128 : 240,
                                width: isMobile() ? 128 : 240,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              'You Don’t Have Any Subscribtion',
                              style: AutilabTextStyle.medium20_500.copyWith(
                                fontSize: isMobile() ? 20 : 32,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: AutilabMargin.marginFullScreen,
                              child: Text(
                                'You Have Not Activated Any Packages. You Can View All Packages From The Button Below.',
                                textAlign: TextAlign.center,
                                style: AutilabTextStyle.small16_400.copyWith(
                                  color: AutilabColor.gray,
                                  fontSize: isMobile() ? 16 : 28,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomButtonWidget(
                              isMobile: isMobile(),
                              onTap: () {
                                context.pushNamed(
                                    AutiLabRoutes.subscribtionPackagesScreen,
                                    extra: {
                                      'planModel': planModel,
                                      'planFeuture': feuturePlanModel,
                                    });
                              },
                              height: 50,
                              color: AutilabColor.bb,
                              text: 'See Package',
                              margin: AutilabMargin.marginFullScreen,
                              textStyle: AutilabTextStyle.small18_400,
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
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
