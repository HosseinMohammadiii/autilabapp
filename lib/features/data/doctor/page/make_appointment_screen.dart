import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/color_constant.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/calendar_box_widget.dart';
import '../widgets/display_title_section_widget.dart';
import '../widgets/doctor_container_box_widget.dart';
import '../widgets/select_time_widget.dart';

class MakeAppointmentScreen extends StatefulWidget {
  const MakeAppointmentScreen({super.key});

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
  String genderType = '';

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
                  height: 48,
                ),
              ),
              const SliverToBoxAdapter(
                child: DoctorBox(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              const SliverToBoxAdapter(
                child: DisplayTitleSection(
                  icon: 'assets/icons/calendar_tick_icon.svg',
                  title: 'Available Date',
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
                  child: Row(
                    children: [
                      Text(
                        _monthName,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: CalendarGrid(
                  onTap: (day) {
                    setState(() {
                      selectDate =
                          DateFormat('EEE d MMM').format(day ?? DateTime.now());
                    });
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _displayIsAvailableWidget(
                        context, 'Available', AutilabColor.bb),
                    const SizedBox(
                      height: 8,
                    ),
                    _displayIsAvailableWidget(
                        context, 'Not Available', const Color(0xffFBE4E4)),
                    const SizedBox(
                      height: 8,
                    ),
                    _displayIsAvailableWidget(
                        context, 'Non-working day', AutilabColor.lightGray),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: AutilabMargin.marginFullScreen,
                      child: Visibility(
                        visible: selectDate.isNotEmpty,
                        child: Row(
                          children: [
                            Text(
                              'You selected , ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Text(
                              selectDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AutilabColor.bb,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                  child: Visibility(
                    visible: selectTime.isNotEmpty,
                    child: Row(
                      children: [
                        Text(
                          'You selected , ',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        Text(
                          selectTime,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AutilabColor.bb,
                                  ),
                        ),
                      ],
                    ),
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
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
                    CustomButtonWidget(
                      onTap: () {
                        setState(() {
                          genderType = 'Male';
                        });
                      },
                      height: 40,
                      width: 100,
                      margin: const EdgeInsets.only(left: 12),
                      borderRadius: 12,
                      color: genderType == 'Male'
                          ? AutilabColor.blue
                          : const Color(0xff9C9595).withValues(alpha: 0.44),
                      text: 'Male',
                      textStyle: genderType == 'Male'
                          ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                color: AutilabColor.white,
                              )
                          : Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 16,
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
                          ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                color: AutilabColor.white,
                              )
                          : Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 16,
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
              SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Describe your problem',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
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
                      TextField(
                        controller: descriptionController,
                        focusNode: descriptionFocusNode,
                        cursorColor: Colors.black,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Enter your Problem here...',
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 4,
                                    color: AutilabColor.gray,
                                  ),
                          fillColor: AutilabColor.primary,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                              color: AutilabColor.gray,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(
                              color: AutilabColor.gray,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (value) {},
                        onTapOutside: (event) {
                          //Unfocus TextField
                          descriptionFocusNode.unfocus();
                        },
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
                  text: 'Appointment booking',
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
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
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
        ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: Colors.black,
          maxLines: lineCount ?? 1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
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
    return Padding(
      padding: AutilabMargin.marginFullScreen,
      child: Row(
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
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
