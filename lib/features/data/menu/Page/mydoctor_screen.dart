import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_tabbar_widget.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_bloc.dart';
import 'package:autilab_project/features/data/home/presentation/bloc/home_state.dart';
import 'package:autilab_project/utils/functions/appointment_check_status_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_button_widget.dart';
import '../../../../common/widgets/responsive_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../presentation/screens/not_connection_screen.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/presentation/bloc/home_event.dart';
import '../widgets/expiredappointment_widget.dart';
import '../widgets/validAppointment_widget.dart';

class MydoctorScreen extends StatefulWidget {
  const MydoctorScreen({super.key});

  @override
  State<MydoctorScreen> createState() => _MydoctorScreenState();
}

class _MydoctorScreenState extends State<MydoctorScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    BlocProvider.of<HomeBloc>(context).add(DisplayHomeContent());
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MydoctorScreen oldWidget) {
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

        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AutilabColor.bb,
                ),
              );
            }
            if (state is HomeErrorHandling) {
              return NotConnectionInternetScreen(
                onChange: () async {
                  context.read<HomeBloc>().add(DisplayHomeContent());
                },
              );
            }
            if (state is HomeFetchData) {
              return state.homeResponse.fold(
                (l) {
                  return NotConnectionInternetScreen(
                    onChange: () async {
                      context.read<HomeBloc>().add(DisplayHomeContent());
                    },
                  );
                },
                (response) {
                  return ResponsiveLayout(
                    child: FadeTransition(
                      opacity: animationHelper.fadeAnimation,
                      child: Scaffold(
                        appBar: appBarWidget(
                          context: context,
                          title: 'My Doctor',
                          isIcon: true,
                          isMobile: isMobile(),
                        ),
                        body: SafeArea(
                          child: CustomTabBarWidget(
                            isMobile: isMobile(),
                            tabLength: 2,
                            tabbarSpace: 32,
                            tabBar: [
                              Visibility(
                                visible: isMobile(),
                                replacement: const Text(
                                  'Valid Appointment',
                                  style: AutilabTextStyle.small24_400,
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Valid Appointment',
                                    style: AutilabTextStyle.small16_400,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isMobile(),
                                replacement: const Text(
                                  'Expired Appointment',
                                  style: AutilabTextStyle.small24_400,
                                ),
                                child: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Expired Appointment',
                                    style: AutilabTextStyle.small16_400,
                                  ),
                                ),
                              ),
                            ],
                            tabBarView: [
                              for (var element
                                  in response[0].newappointmentModel) ...{
                                if (element.status == 'APPROVED') ...{
                                  ValidAppointmentWidget(
                                    color: statusCheckColor('APPROVED').$3,
                                    title: statusCheckColor('APPROVED').$2,
                                    statusIcon: statusCheckColor('APPROVED').$1,
                                    isMobile: isMobile(),
                                  ),
                                } else ...{
                                  widgetNotFoundItem(isMobile, context),
                                }
                              },
                              for (var element
                                  in response[0].newappointmentModel) ...{
                                if (element.status == 'CANCELED') ...{
                                  ExpiredAppointmentWidget(
                                    isMobile: isMobile(),
                                    color: statusCheckColor('CANCELED').$3,
                                    title: statusCheckColor('CANCELED').$2,
                                    statusIcon: statusCheckColor('CANCELED').$1,
                                  ),
                                } else ...{
                                  widgetNotFoundItem(isMobile, context),
                                }
                              },
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }

//Widget for when an item is unavailable
  Widget widgetNotFoundItem(bool Function() isMobile, BuildContext context) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/item_notfound.svg',
          width: isMobile() ? 160 : 240,
          height: isMobile() ? 160 : 240,
        ),
        Text(
          'Item Not Found',
          style: AutilabTextStyle.medium20_500.copyWith(
            fontSize: isMobile() ? 20 : 32,
          ),
        ),
        CustomButtonWidget(
          isMobile: isMobile(),
          onTap: () {
            context.goNamed(AutiLabRoutes.doctorScreen);
          },
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          color: AutilabColor.bb,
          text: 'Search Something Else',
          textStyle: AutilabTextStyle.small18_400,
        ),
      ],
    );
  }
}
