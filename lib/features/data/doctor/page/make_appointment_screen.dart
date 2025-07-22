import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/textfiledbox_description.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/Lists/time_date_list.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/calendar_box_widget.dart';
import '../widgets/display_title_section_widget.dart';
import '../widgets/doctor_container_box_widget.dart';
import '../widgets/select_time_widget.dart';

// ignore: must_be_immutable
class MakeAppointmentScreen extends StatefulWidget {
  MakeAppointmentScreen({
    super.key,
    this.isLike = false,
  });
  bool? isLike;
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

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, isIcon: true, title: 'Make Appointment'),
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
                  isLike: widget.isLike,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              const SliverToBoxAdapter(
                child: DisplayTitleSection(
                  icon: 'assets/icons/calendar_tick_icon.svg',
                  title: 'Available Dates',
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
                          style: AutilabTextStyle.small18_400,
                        ),
                        isOpen
                            ? SvgPicture.asset(
                                'assets/icons/arrow_up.svg',
                                width: 16,
                                height: 16,
                              )
                            : SvgPicture.asset(
                                'assets/icons/arrow_down.svg',
                                width: 16,
                                height: 16,
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
                      date: montNumber,
                      onTap: (day) {
                        setState(() {
                          selectDate =
                              DateFormat('EEE d').format(day ?? DateTime.now());
                        });
                      },
                    ),
                    Visibility(
                      visible: isOpen,
                      child: Container(
                        width: 130,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F6F6),
                          border: Border.all(color: AutilabColor.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: montNameList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    style: AutilabTextStyle.small16_400,
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
                          context, 'Open For Booking', AutilabColor.bb),
                      _displayIsAvailableWidget(
                          context, 'Already Booked', const Color(0xffFBE4E4)),
                      _displayIsAvailableWidget(context,
                          'This Is A Non-Working Day', AutilabColor.lightGray),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: selectDate.isNotEmpty,
                        child: Row(
                          children: [
                            Text(
                              'You selected , ',
                              style: AutilabTextStyle.small16_400,
                            ),
                            Text(
                              '$selectDate $_monthName',
                              style: AutilabTextStyle.medium16_500.copyWith(
                                color: AutilabColor.bb,
                              ),
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
              const SliverToBoxAdapter(
                child: DisplayTitleSection(
                  icon: 'assets/icons/clock_icon.svg',
                  title: 'Available Times',
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
                          context, 'Open For Booking', AutilabColor.bb),
                      _displayIsAvailableWidget(
                          context, 'Already Booked', const Color(0xffFBE4E4)),
                      Visibility(
                        visible: selectTime.isNotEmpty,
                        child: Row(
                          children: [
                            Text(
                              'You selected , ',
                              style: AutilabTextStyle.small16_400,
                            ),
                            Text(
                              selectTime,
                              style: AutilabTextStyle.medium16_500.copyWith(
                                color: AutilabColor.bb,
                              ),
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
              const SliverToBoxAdapter(
                child: DisplayTitleSection(
                  icon: 'assets/icons/profile_icon.svg',
                  title: 'Patient Details',
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
                    context: context,
                    title: 'Age',
                    controller: ageController,
                    focusNode: ageFocusNode,
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
                    style: AutilabTextStyle.small14_400,
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
                    CustomButtonWidget(
                      onTap: () {
                        setState(() {
                          genderType = 'Male';
                        });
                      },
                      height: 40,
                      width: 100,
                      margin: const EdgeInsets.only(left: 20),
                      borderRadius: 12,
                      color: genderType == 'Male'
                          ? AutilabColor.blue
                          : const Color(0xff9C9595).withValues(alpha: 0.44),
                      text: 'Male',
                      textStyle: genderType == 'Male'
                          ? AutilabTextStyle.medium16_500.copyWith(
                              color: AutilabColor.white,
                            )
                          : AutilabTextStyle.small16_400.copyWith(
                              color: AutilabColor.black,
                            ),
                    ),
                    CustomButtonWidget(
                      onTap: () {
                        setState(() {
                          genderType = 'Female';
                        });
                      },
                      height: 40,
                      width: 100,
                      margin: const EdgeInsets.only(left: 12),
                      borderRadius: 12,
                      color: genderType == 'Female'
                          ? AutilabColor.blue
                          : const Color(0xff9C9595).withValues(alpha: 0.44),
                      text: 'Female',
                      textStyle: genderType == 'Female'
                          ? AutilabTextStyle.medium16_500.copyWith(
                              color: AutilabColor.white,
                            )
                          : AutilabTextStyle.small16_400.copyWith(
                              color: AutilabColor.black,
                            ),
                    ),
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
              const SliverToBoxAdapter(
                child: DisplayTitleSection(
                  icon: 'assets/icons/info-circle.svg',
                  title: 'Describe your problem',
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
                        borderRadius: 24,
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
                  onTap: () {},
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
    );
  }

//Widget for display texfield enter FullName & Age User
  Widget textFieldWidget({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required FocusNode focusNode,
    int? lineCount,
    Color? backgroundColor,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: AutilabTextStyle.small14_400,
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: Colors.black,
          maxLines: lineCount ?? 1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AutilabTextStyle.small10_400.copyWith(
              color: AutilabColor.gray,
            ),
            fillColor: backgroundColor ?? const Color(0xffECF0FF),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
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
  ) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          title,
          style: AutilabTextStyle.small14_400,
        ),
      ],
    );
  }
}
