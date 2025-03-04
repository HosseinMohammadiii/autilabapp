import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constant_routes.dart';
import '../../../../utils/functions/animation_control.dart';
import '../widgets/button_card.dart';

class DoctorWorkScheduleScreen extends StatefulWidget {
  const DoctorWorkScheduleScreen({super.key});

  @override
  State<DoctorWorkScheduleScreen> createState() =>
      _DoctorWorkScheduleScreenState();
}

class _DoctorWorkScheduleScreenState extends State<DoctorWorkScheduleScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  String _monthName = '';

  final List<String> weekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

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
  void didUpdateWidget(covariant DoctorWorkScheduleScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> getDaysInMonth(int year, int month) {
      int daysInMonth = DateTime(year, month + 1, 0).day;
      return List.generate(
          daysInMonth, (index) => DateTime(year, month, index + 1));
    }

    List<DateTime> days =
        getDaysInMonth(DateTime.now().year, DateTime.now().month);
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Work Schedule', isIcon: true),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 136,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AutilabColor.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/doctor_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      'Dr. Sophia Martinez',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      'Psychotherapy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: CustomButtonWidget(
                                      onTap: () {
                                        context.pushNamed(AutiLabRoutes
                                            .doctorInformationScreen);
                                      },
                                      height: 30,
                                      width: 80,
                                      margin: const EdgeInsets.all(0),
                                      color: AutilabColor.yellow,
                                      text: 'Info',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                  const Spacer(),
                                  ButtonCard(
                                    icon: 'assets/icons/messages.svg',
                                    onTap: () {
                                      context.pushNamed(
                                          AutiLabRoutes.doctorMessageScreen);
                                    },
                                  ),
                                  ButtonCard(
                                    icon: 'assets/icons/heart.svg',
                                    onTap: () {},
                                  ),
                                ],
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
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/calendar_tick_icon.svg'),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Available Date',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
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
                // SliverToBoxAdapter(
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Text(
                //             _monthName,
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodyMedium!
                //                 .copyWith(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //           ),
                //           Icon(Icons.keyboard_arrow_down_rounded),
                //         ],
                //       ),
                //       // SizedBox(
                //       //   height: 150,
                //       //   child: GridView.builder(
                //       //     gridDelegate:
                //       //         const SliverGridDelegateWithFixedCrossAxisCount(
                //       //       crossAxisCount: 7,
                //       //       mainAxisExtent: 40,
                //       //       mainAxisSpacing: 10,
                //       //       crossAxisSpacing: 10,
                //       //     ),
                //       //     itemCount: days.length,
                //       //     itemBuilder: (context, index) {
                //       //       return Container(
                //       //         alignment: Alignment.center,
                //       //         decoration: BoxDecoration(
                //       //           color: AutilabColor.bb,
                //       //           borderRadius: BorderRadius.circular(8),
                //       //         ),
                //       //         child: Text(
                //       //           days[index].day.toString(),
                //       //         ),
                //       //       );
                //       //     },
                //       //   ),
                //       // ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: weekDays.map((day) {
                //           return Container(
                //             width: 45,
                //             height: 45,
                //             alignment: Alignment.center,
                //             child: Text(
                //               day,
                //               style: TextStyle(
                //                   fontSize: 16, fontWeight: FontWeight.bold),
                //             ),
                //           );
                //         }).toList(),
                //       ),

                //       Wrap(
                //         spacing: 10,
                //         runSpacing: 10,
                //         children: days.map((day) {
                //           return Container(
                //             width: 40,
                //             height: 39,
                //             decoration: BoxDecoration(
                //               color: AutilabColor.bb,
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             child: Center(
                //               child: Text(
                //                 day.day.toString(),
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .bodySmall!
                //                     .copyWith(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.w400,
                //                     ),
                //               ),
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           for (var element in days) {
                //             print(element.day);
                //           }
                //         },
                //         child: Container(
                //           width: 100,
                //           height: 100,
                //           color: AutilabColor.yellow,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
