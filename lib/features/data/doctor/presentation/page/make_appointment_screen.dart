import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/features/data/doctor/presentation/page/nearby_center_details_screen.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../common/widgets/textfiledbox_description.dart';
import '../../../../../core/constants/color_constant.dart';
import '../../../../../core/constants/theme_constant.dart';
import '../../../../../utils/Lists/time_date_list.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../data/model/doctor_model.dart';
import '../../widgets/calendar_box_widget.dart';
import '../../widgets/doctor_container_box_widget.dart';
import '../../widgets/select_time_widget.dart';

// ignore: must_be_immutable
class MakeAppointmentScreen extends StatefulWidget {
  MakeAppointmentScreen({
    super.key,
    this.isLike = false,
    this.user,
    this.specialty,
  });
  bool? isLike;
  final DoctorUser? user;
  final RecentVisitedModel? specialty;

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen>
    with TickerProviderStateMixin {
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final descriptionController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final ageFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  late AnimationHelper animationHelper;
  String _monthName = '';
  String selectDate = '';
  String selectTime = '';
  String genderType = 'Male';

  bool isOpen = false;

  DateTime date = DateTime.now();

  int montNumber = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    _monthName = DateFormat.MMMM().format(DateTime.now());
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MakeAppointmentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  String formatSelectedDate(DateTime date) {
    String weekday = DateFormat('E').format(date); // Mon, Tue, Wed...
    String day = DateFormat('d').format(date); // 1, 2, 3...
    String month = DateFormat('MMMM').format(date); // January, February...

    return '$weekday $day $month';
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
                isIcon: true,
                title: 'Make Appointment',
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: DoctorBox(
                        isMobile: isMobile(),
                        isLike: widget.isLike,
                        user: widget.user,
                        specialty: widget.specialty,
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
                          icon: 'assets/icons/calendar_tick_icon.svg',
                          title: 'Available Dates',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: Row(
                            spacing: 14,
                            children: [
                              Text(
                                _monthName,
                                style: AutilabTextStyle.small18_400.copyWith(
                                  fontSize: isMobile() ? 18 : 24,
                                ),
                              ),
                              isOpen
                                  ? SvgPicture.asset(
                                      'assets/icons/arrow_up.svg',
                                      width: isMobile() ? 16 : 24,
                                      height: isMobile() ? 16 : 24,
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/arrow_down.svg',
                                      width: isMobile() ? 16 : 24,
                                      height: isMobile() ? 16 : 24,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          CalendarGrid(
                            isMobile: isMobile(),
                            date: montNumber,
                            onTap: (day) {
                              setState(() {
                                selectDate = DateFormat('EEE d')
                                    .format(day ?? DateTime.now());

                                date = day ?? DateTime.now();
                              });
                            },
                            isSelect: true,
                          ),
                          Visibility(
                            visible: isOpen,
                            child: Container(
                              width: isMobile() ? 130 : 167,
                              padding: const EdgeInsets.all(12),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffF6F6F6),
                                border: Border.all(color: AutilabColor.blue),
                                borderRadius:
                                    BorderRadius.circular(isMobile() ? 16 : 24),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: montNameList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOpen = false;
                                            _monthName = montNameList[index];
                                            montNumber = index;
                                            selectDate = '';
                                          });
                                        },
                                        child: Text(
                                          montNameList[index],
                                          style: AutilabTextStyle.small16_400
                                              .copyWith(
                                            fontSize: isMobile() ? 16 : 24,
                                          ),
                                        ),
                                      ),
                                      if (index < montNameList.length - 1)
                                        const Divider(
                                          thickness: 1,
                                          color: AutilabColor.gray,
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          spacing: 8,
                          children: [
                            _displayIsAvailableWidget(
                              context,
                              'Open For Booking',
                              AutilabColor.bb,
                              isMobile(),
                            ),
                            _displayIsAvailableWidget(
                              context,
                              'Already Booked',
                              const Color(0xffFBE4E4),
                              isMobile(),
                            ),
                            _displayIsAvailableWidget(
                              context,
                              'This Is A Non-Working Day',
                              AutilabColor.lightGray,
                              isMobile(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(
                              visible: selectDate.isNotEmpty,
                              child: Row(
                                children: [
                                  Text(
                                    'You selected , ',
                                    style: AutilabTextStyle.small16_400
                                        .copyWith(
                                            fontSize: isMobile() ? 16 : 20),
                                  ),
                                  Text(
                                    formatSelectedDate(date),
                                    // '$selectDate $_monthName',
                                    style: AutilabTextStyle.medium16_500
                                        .copyWith(
                                            color: AutilabColor.bb,
                                            fontSize: isMobile() ? 16 : 20),
                                  ),
                                ],
                              ),
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
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
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
                          icon: 'assets/icons/clock_icon.svg',
                          title: 'Available Times',
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
                      sliver: SelectTimeWidget(
                        isMobile: isMobile(),
                        onTap: (time) {
                          setState(() {
                            selectTime = time ?? '';
                          });
                        },
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
                        child: Column(
                          spacing: 8,
                          children: [
                            _displayIsAvailableWidget(
                              context,
                              'Open For Booking',
                              AutilabColor.bb,
                              isMobile(),
                            ),
                            _displayIsAvailableWidget(
                              context,
                              'Already Booked',
                              const Color(0xffFBE4E4),
                              isMobile(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(
                              visible: selectTime.isNotEmpty,
                              child: Row(
                                children: [
                                  Text(
                                    'You selected , ',
                                    style: AutilabTextStyle.small16_400
                                        .copyWith(
                                            fontSize: isMobile() ? 16 : 20),
                                  ),
                                  Text(
                                    selectTime,
                                    style: AutilabTextStyle.medium16_500
                                        .copyWith(
                                            color: AutilabColor.bb,
                                            fontSize: isMobile() ? 16 : 20),
                                  ),
                                ],
                              ),
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
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Divider(
                          thickness: 1,
                          color: AutilabColor.gray,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
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
                        height: 24,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: textFieldWidget(
                          isMobile: isMobile(),
                          context: context,
                          title: 'Full Name',
                          controller: fullNameController,
                          focusNode: fullNameFocusNode,
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
                        child: textFieldWidget(
                          isMobile: isMobile(),
                          context: context,
                          title: 'Age',
                          controller: ageController,
                          focusNode: ageFocusNode,
                          textInputType: TextInputType.number,
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
                        child: Text(
                          'Gender',
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile() ? 14 : 20,
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 8,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                genderType = 'Male';
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: genderType == 'Male'
                                    ? AutilabColor.blue
                                    : Colors.transparent,
                                border: Border.all(
                                    color: genderType == 'Male'
                                        ? Colors.transparent
                                        : AutilabColor.blue),
                                borderRadius:
                                    BorderRadius.circular(isMobile() ? 16 : 24),
                              ),
                              child: Text(
                                'Male',
                                style: AutilabTextStyle.medium16_500.copyWith(
                                  color: genderType == 'Male'
                                      ? AutilabColor.white
                                      : AutilabColor.black,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                genderType = 'Female';
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: genderType == 'Female'
                                    ? AutilabColor.blue
                                    : Colors.transparent,
                                border: Border.all(
                                    color: genderType == 'Female'
                                        ? Colors.transparent
                                        : AutilabColor.blue),
                                borderRadius:
                                    BorderRadius.circular(isMobile() ? 16 : 24),
                              ),
                              child: Text(
                                'Female',
                                style: AutilabTextStyle.medium16_500.copyWith(
                                  color: genderType == 'Female'
                                      ? AutilabColor.white
                                      : AutilabColor.black,
                                ),
                              ),
                            ),
                          ),
                          // CustomButtonWidget(
                          //   onTap: () {
                          //     setState(() {
                          //       genderType = 'Male';
                          //     });
                          //   },
                          //   height: 40,
                          //   width: 100,
                          //   margin: const EdgeInsets.only(left: 20),
                          //   borderRadius: 12,
                          //   color: genderType == 'Male'
                          //       ? AutilabColor.blue
                          //       : Colors.transparent,
                          //   bordeColor: genderType == 'Male'
                          //       ? Colors.transparent
                          //       : AutilabColor.blue,
                          //   text: 'Male',
                          //   // textStyle: genderType == 'Male'
                          //   //     ? AutilabTextStyle.medium16_500.copyWith(
                          //   //         color: AutilabColor.white,
                          //   //       )
                          //   //     : AutilabTextStyle.small16_400.copyWith(
                          //   //         color: AutilabColor.black,
                          //   //       ),
                          //   textStyle: AutilabTextStyle.medium16_500.copyWith(
                          //     color: AutilabColor.white,
                          //   ),
                          //   isMobile: isMobile(),
                          // ),
                          // CustomButtonWidget(
                          //   onTap: () {
                          //     setState(() {
                          //       genderType = 'Female';
                          //     });
                          //   },
                          //   height: 40,
                          //   width: 100,
                          //   margin: const EdgeInsets.only(left: 12),
                          //   borderRadius: 12,
                          //   color: genderType == 'Female'
                          //       ? AutilabColor.blue
                          //       : const Color(0xff9C9595)
                          //           .withValues(alpha: 0.44),
                          //   text: 'Female',
                          //   textStyle: genderType == 'Female'
                          //       ? AutilabTextStyle.medium16_500.copyWith(
                          //           color: AutilabColor.white,
                          //         )
                          //       : AutilabTextStyle.small16_400.copyWith(
                          //           color: AutilabColor.black,
                          //         ),
                          // ),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: AutilabMargin.marginFullScreen,
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
                          title: 'Describe your problem',
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            TextFieldBoxEnterDescription(
                              textStyle: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 20,
                              ),
                              borderRadius: isMobile() ? 16 : 24,
                              hintText: 'Enter your Problem here...',
                              descriptionController: descriptionController,
                              descriptionFocusNode: descriptionFocusNode,
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
                    SliverToBoxAdapter(
                      child: CustomButtonWidget(
                        isMobile: isMobile(),
                        onTap: () {
                          context.pop();
                        },
                        height: 50,
                        width: double.infinity,
                        color: AutilabColor.bb,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        text: 'Appointment Booking',
                        textStyle: AutilabTextStyle.small18_400,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

//Widget for display texfield enter FullName & Age User
  Widget textFieldWidget({
    required bool isMobile,
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required FocusNode focusNode,
    int? lineCount,
    Color? backgroundColor,
    String? hintText,
    TextInputType? textInputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: AutilabTextStyle.small14_400.copyWith(
            fontSize: isMobile ? 14 : 20,
          ),
        ),
        TextField(
          keyboardType: textInputType,
          controller: controller,
          focusNode: focusNode,
          cursorColor: Colors.black,
          maxLines: lineCount ?? 1,
          style: AutilabTextStyle.small14_400.copyWith(
            fontSize: isMobile ? 14 : 20,
          ),
          inputFormatters: textInputType == TextInputType.number
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
              : [],
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AutilabTextStyle.small10_400.copyWith(
              color: AutilabColor.gray,
            ),
            fillColor: backgroundColor ?? const Color(0xffECF0FF),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: isMobile ? 0 : 20, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
              borderSide: const BorderSide(
                color: AutilabColor.bb,
                width: 0.5,
              ),
            ),
          ),
          onChanged: (value) {},
          onTapOutside: (event) {
            //Unfocus TextField
            focusNode.unfocus();
          },
        ),
      ],
    );
  }

//Display Available Or NotAvailable text
  Widget _displayIsAvailableWidget(
    BuildContext context,
    String title,
    Color color,
    bool isMobile,
  ) {
    return Row(
      children: [
        Container(
          width: isMobile ? 20 : 32,
          height: isMobile ? 20 : 32,
          margin: EdgeInsets.only(right: isMobile ? 4 : 8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          title,
          style: AutilabTextStyle.small14_400.copyWith(
            fontSize: isMobile ? 14 : 24,
          ),
        ),
      ],
    );
  }
}
