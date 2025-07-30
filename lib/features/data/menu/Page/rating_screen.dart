import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/doctor/page/nearby_center_details_screen.dart';
import 'package:autilab_project/features/data/test/page/quiz_multiselect_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/responsive_widget.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/doctor_box_detail_appointment_widget.dart';

enum RadioCharacter { characterOne, secondeCharacter }

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  RadioCharacter? character;

  String rateDescription = '';

  @override
  void initState() {
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));
    character = RadioCharacter.characterOne;
    animationHelper.animationController.forward();
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RatingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<String> ratingTitleList = [
    'Terrible',
    'Poor',
    'Average',
    'Good',
    'Excellent',
  ];
  List<QuizClass> checkListTitle = [
    QuizClass('Excellent Communication', true),
    QuizClass('Professional Care', false),
    QuizClass('Clean And Calm Environment', false),
    QuizClass('On-Time Appointment', false),
    QuizClass('Other', false),
  ];

  List<String> rateDescriptionList = [
    "We're Sorry Your Experience Wasn't Good\nPlease Help Us Understand What Went Wrong.",
    "Thanks For Your Feedback.\nWe’d Like To Know Both The Good And The Bad.",
    "Thanks For Sharing. We'd Love To Know How We Can Do Better.",
    "Great To Hear You Had A Good Experience!\nTell Us What Could Make It Even Better.",
    "Amazing! We’re Glad You’re Fully Satisfied.",
  ];

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
                title: 'Leave a Rating',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    if (!isMobile()) ...[
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 32,
                        ),
                      ),
                    ],
                    SliverToBoxAdapter(
                      child: DoctorBoxDetialAppointmentWidget(
                        isMobile: isMobile(),
                        image: 'assets/images/doctor_image.jpg',
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: AutilabColor.gray,
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
                          'How Would You Rate Your Appointment?',
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile() ? 14 : 20,
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
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: RatingBar.builder(
                            initialRating: 0,
                            itemCount: 5,
                            minRating: 1,
                            maxRating: 5,
                            updateOnDrag: true,
                            itemSize: isMobile() ? 65 : 85,
                            itemPadding: const EdgeInsetsGeometry.symmetric(
                                horizontal: 4),
                            unratedColor: AutilabColor.gray,
                            glow: false,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                spacing: 4,
                                children: [
                                  const Icon(Icons.star_rounded,
                                      color: AutilabColor.yellow, size: 35),
                                  Text(
                                    ratingTitleList[index],
                                    style:
                                        AutilabTextStyle.small12_400.copyWith(
                                      fontSize: isMobile() ? 12 : 16,
                                    ),
                                  ),
                                ],
                              );
                            },
                            onRatingUpdate: (value) {
                              setState(() {
                                switch (value) {
                                  case 1.0:
                                    rateDescription = rateDescriptionList[0];
                                    break;
                                  case 2.0:
                                    rateDescription = rateDescriptionList[1];
                                    break;
                                  case 3.0:
                                    rateDescription = rateDescriptionList[2];
                                    break;
                                  case 4.0:
                                    rateDescription = rateDescriptionList[3];
                                    break;
                                  case 5.0:
                                    rateDescription = rateDescriptionList[4];
                                    break;
                                  default:
                                    rateDescription = rateDescriptionList[0];
                                }
                              });
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
                    const SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: AutilabColor.gray,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    SliverPadding(
                      padding: AutilabMargin.marginFullScreen,
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          rateDescription,
                          style: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile() ? 14 : 20,
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
                        child: Row(
                          spacing: 5,
                          children: [
                            Text(
                              'What Did You Love Most?',
                              style: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 18,
                              ),
                            ),
                            Text(
                              '(Required)',
                              style: AutilabTextStyle.small14_400.copyWith(
                                color: AutilabColor.bb,
                                fontSize: isMobile() ? 14 : 18,
                              ),
                            ),
                          ],
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
                      sliver: SliverList.builder(
                        itemCount: checkListTitle.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  checkListTitle[index].value =
                                      !checkListTitle[index].value;
                                });
                              },
                              child: Row(
                                spacing: 8,
                                children: [
                                  SizedBox(
                                    width: isMobile() ? 15 : 61,
                                    height: isMobile() ? 15 : 61,
                                    child: Checkbox(
                                      value: checkListTitle[index].value,
                                      activeColor: AutilabColor.blue,
                                      checkColor: AutilabColor.white,
                                      tristate: true,
                                      side: const BorderSide(width: 1),
                                      splashRadius: 0,
                                      onChanged: (value) {
                                        setState(() {
                                          checkListTitle[index].value =
                                              !checkListTitle[index].value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    checkListTitle[index].title,
                                    style:
                                        AutilabTextStyle.small14_400.copyWith(
                                      fontSize: isMobile() ? 14 : 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
                          title: 'How Should Your Feedback Be Sent?',
                          icon: 'assets/icons/information.svg',
                          textStyle: AutilabTextStyle.small14_400.copyWith(
                            fontSize: isMobile() ? 14 : 20,
                          ),
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
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RadioButtonWidget(
                              isMobile: isMobile(),
                              value: RadioCharacter.characterOne,
                              radioCharacter: character!,
                              onChanged: (value) {
                                setState(() {
                                  character = value;
                                });
                              },
                              title: 'With My Name',
                              textStyle: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 18,
                              ),
                            ),
                            RadioButtonWidget(
                              isMobile: isMobile(),
                              value: RadioCharacter.secondeCharacter,
                              radioCharacter: character!,
                              onChanged: (value) {
                                setState(() {
                                  character = value;
                                });
                              },
                              title: 'Anonymously',
                              textStyle: AutilabTextStyle.small14_400.copyWith(
                                fontSize: isMobile() ? 14 : 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomButtonWidget(
                        isMobile: isMobile(),
                        onTap: () {
                          context.pushNamed(
                              AutiLabRoutes.successfulSubmitRateScreen);
                        },
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 48),
                        color: AutilabColor.bb,
                        text: 'Submit Feedback',
                        textStyle: AutilabTextStyle.small18_400,
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
}

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget({
    super.key,
    this.isMobile = true,
    required this.radioCharacter,
    required this.value,
    required this.onChanged,
    required this.title,
    this.textStyle,
  });
  final bool isMobile;
  final RadioCharacter radioCharacter;
  final RadioCharacter value;
  final TextStyle? textStyle;
  final Function(RadioCharacter? value) onChanged;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: isMobile ? 20 : 43,
            height: isMobile ? 20 : 43,
            child: Radio<RadioCharacter>(
              activeColor: AutilabColor.bb,
              value: value,
              fillColor: WidgetStateProperty.all(AutilabColor.bb),
              groupValue: radioCharacter,
              onChanged: (RadioCharacter? value) {
                onChanged(value);
              },
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: textStyle ?? AutilabTextStyle.small14_400,
            ),
          ),
        ],
      ),
    );
  }
}
