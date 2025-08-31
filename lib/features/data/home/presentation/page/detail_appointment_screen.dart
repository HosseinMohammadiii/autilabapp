import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_textfield.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/auth/presentetion/bloc/auth_state.dart';
import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';
import 'package:autilab_project/features/data/doctor/widgets/box_detail_widget.dart';
import 'package:autilab_project/features/data/home/presentation/page/all_appointment_screen.dart';
import 'package:autilab_project/features/data/home/widgets/box_shape_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/network/locator.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../../../../utils/functions/calculatbirthdate_function.dart';
import '../../../auth/presentetion/bloc/auth_bloc.dart';
import '../../../auth/presentetion/bloc/auth_event.dart';
import '../../../doctor/presentation/page/nearby_center_details_screen.dart';
import '../../data/model/newappointment_model.dart';
import '../../widgets/doctor_box_detail_appointment_widget.dart';

class DetailAppointmentScreen extends StatefulWidget {
  const DetailAppointmentScreen({
    super.key,
    this.doctorModel,
    this.newappointmentModel,
    required this.statusColor,
    required this.statusIcon,
    required this.image,
    required this.title,
    required this.descriptionStatus,
    this.dateTimeSchedule,
  });

  final DoctorModel? doctorModel;
  final NewappointmentModel? newappointmentModel;
  final Color? statusColor;
  final String statusIcon;
  final String image;
  final String title;
  final String descriptionStatus;
  final DateTimeSchedule? dateTimeSchedule;
  @override
  State<DetailAppointmentScreen> createState() =>
      _DetailAppointmentScreenState();
}

class _DetailAppointmentScreenState extends State<DetailAppointmentScreen>
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
  void didUpdateWidget(covariant DetailAppointmentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: FadeTransition(
        opacity: animationHelper.fadeAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile() {
              if (constraints.maxWidth < 600) {
                return true;
              } else {
                return false;
              }
            }

            return Scaffold(
              appBar: appBarWidget(
                  context: context,
                  title: 'Detail Appointment',
                  isIcon: true,
                  isMobile: isMobile()),
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 22,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: DoctorBoxDetialAppointmentWidget(
                        image: widget.image,
                        doctorName:
                            '${widget.doctorModel?.doctorUser.firstName} ${widget.doctorModel?.doctorUser.lastName}',
                        doctorSpecialtyl:
                            widget.doctorModel?.doctorSpecialities[0].name,
                        isMobile: isMobile(),
                        dateTimeSchedule: widget.dateTimeSchedule,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        widget.descriptionStatus,
                        style: AutilabTextStyle.small16_400
                            .copyWith(fontSize: isMobile() ? 16 : 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        'By The Doctor',
                        style: AutilabTextStyle.small16_400.copyWith(
                          color: AutilabColor.bb,
                          fontSize: isMobile() ? 16 : 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: isMobile() ? 50 : 68,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.statusColor?.withValues(alpha: 0.3) ??
                              Colors.transparent,
                          border: Border.all(
                            color: widget.statusColor ?? Colors.transparent,
                          ),
                          borderRadius:
                              BorderRadius.circular(isMobile() ? 16 : 32),
                        ),
                        child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StatusShapeWidget(
                              isMobile: isMobile(),
                              color:
                                  widget.statusColor ?? const Color(0xff50DD81),
                              statusIcon: widget.statusIcon,
                            ),
                            Text(
                              widget.title,
                              style: AutilabTextStyle.small16_400
                                  .copyWith(fontSize: isMobile() ? 16 : 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 48,
                      ),
                    ),
                    const SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: Divider(
                          thickness: 1,
                          color: AutilabColor.gray,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
                          icon: 'assets/icons/profile_icon.svg',
                          title: 'Patient Details',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: BlocProvider(
                          create: (context) => AuthenticationBloc(locator.get())
                            ..add(DisplayInformationUser()),
                          child: BlocBuilder<AuthenticationBloc,
                              AuthenticationState>(
                            builder: (context, state) {
                              if (state is AuthenticationLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AutilabColor.bb,
                                  ),
                                );
                              }
                              if (state is FetchUserDataResponse) {
                                return state.response.fold(
                                  (error) {
                                    return Text(error);
                                  },
                                  (userData) {
                                    return Column(
                                      spacing: 12,
                                      children: [
                                        BoxDetailWidget(
                                            isMobile: isMobile(),
                                            title: 'Full Name',
                                            subtitle:
                                                '${userData.firstName} ${userData.lastName}'),
                                        BoxDetailWidget(
                                          isMobile: isMobile(),
                                          title: 'Age',
                                          subtitle:
                                              calculateAge(userData.birthdate)
                                                  .toString(),
                                        ),
                                        BoxDetailWidget(
                                          isMobile: isMobile(),
                                          title: 'Gender',
                                          subtitle: userData.gender,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: Divider(
                          thickness: 1,
                          color: AutilabColor.gray,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 48,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: TitleAndIconWidget(
                          isMobile: isMobile(),
                          icon: 'assets/icons/info-circle.svg',
                          title: 'Problem Description',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomTextfield(
                        isMobile: isMobile(),
                        label: '',
                        isEnable: false,
                        borderRaduis: isMobile() ? 24 : 32,
                        textfieldPadding: AutilabMargin.marginFullScreen,
                        padding: EdgeInsets.all(isMobile() ? 16 : 24),
                        controller: TextEditingController(
                          text: widget.newappointmentModel?.description ??
                              'My son is 10 years old and on the more severe end of the autism spectrum. He often has high muscle tone and tends to keep his body very stiff, especially when sitting down or trying to stand up. Because of this muscle tightness, he sometimes struggles to move properly or go up stairs.',
                        ),
                        backgroundColor: AutilabColor.primary,
                        borderColor: AutilabColor.gray,
                        textStyle: AutilabTextStyle.small14_400.copyWith(
                          color: AutilabColor.black,
                          fontSize: isMobile() ? 14 : 20,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
