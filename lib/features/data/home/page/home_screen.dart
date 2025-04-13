import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/color_constant.dart';
import '../../doctor/widgets/specialty_list_widget.dart';

class StatusClass {
  Color statusColor;
  String statusIcon;
  String title;
  //StatusClass constructor
  StatusClass(this.statusColor, this.statusIcon, this.title);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StatusClass> statusList = [
    StatusClass(
      const Color(0xffFF6363),
      'assets/icons/close_icon.svg',
      'Cancelled',
    ),
    StatusClass(
      const Color(0xff50DD81),
      'assets/icons/done_icon.svg',
      'Approved',
    ),
    StatusClass(
      AutilabColor.gray,
      'assets/icons/minimize_icon.svg',
      'Pending',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'New Appointments',
                      style: AutilabTextStyle.small20_400,
                    ),
                    GestureDetector(
                      child: Text(
                        'See All',
                        style: AutilabTextStyle.medium14_500.copyWith(
                          color: AutilabColor.blue,
                        ),
                      ),
                      onTap: () {},
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
              child: SizedBox(
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return NewAppointmentsCardWidget(
                      color: statusList[index].statusColor,
                      title: statusList[index].title,
                      statusIcon: statusList[index].statusIcon,
                    );
                  },
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
                child: Text(
                  'Recent Visited',
                  style: AutilabTextStyle.small20_400,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            const SliverPadding(
              padding: AutilabMargin.marginFullScreen,
              sliver: SliverToBoxAdapter(
                child: SpecialtiesListWidget(),
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
                child: Text(
                  'Test Result',
                  style: AutilabTextStyle.small20_400,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewAppointmentsCardWidget extends StatelessWidget {
  const NewAppointmentsCardWidget({
    super.key,
    required this.color,
    required this.title,
    required this.statusIcon,
  });
  final Color color;
  final String title;
  final String statusIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      margin: AutilabMargin.marginFullScreen,
      decoration: BoxDecoration(
        color: AutilabColor.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 16,
        children: [
          Row(
            spacing: 4,
            children: [
              Container(
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  statusIcon,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const Text(
                'Status :',
                style: AutilabTextStyle.medium14_500,
              ),
              Text(
                title,
                style: AutilabTextStyle.medium14_500,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AutilabColor.black,
          ),
          Row(
            spacing: 12,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/doctor_image.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  const Text(
                    'Dr. Sophia Martinez',
                    style: AutilabTextStyle.medium18_500,
                  ),
                  Row(
                    children: [
                      Text(
                        'Psychotherapy',
                        style: AutilabTextStyle.small14_400.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xffEDC757),
                      ),
                      const Text(
                        '5.0',
                        style: AutilabTextStyle.small14_400,
                      ),
                    ],
                  ),
                  Container(
                    height: 32,
                    width: 186,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: AutilabColor.bb),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          colorFilter: const ColorFilter.mode(
                            AutilabColor.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Text(
                          ' Tues 03 March ',
                          style: AutilabTextStyle.medium12_500,
                        ),
                        Container(
                          height: 16,
                          width: 2,
                          decoration: const BoxDecoration(
                            color: AutilabColor.bb,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/clock_icon.svg',
                          colorFilter: const ColorFilter.mode(
                            AutilabColor.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Text(
                          '13:30',
                          style: AutilabTextStyle.medium12_500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomButtonWidget(
            onTap: () {},
            height: 50,
            margin: const EdgeInsets.all(0),
            color: AutilabColor.bb,
            text: 'Detail Appointment',
            textStyle: AutilabTextStyle.small18_400,
          ),
        ],
      ),
    );
  }
}
