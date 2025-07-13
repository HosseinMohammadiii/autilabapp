import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../utils/functions/animation_control.dart';
import '../../home/widgets/doctor_box_detail_appointment_widget.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen>
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
  void didUpdateWidget(covariant RatingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Leave a Rating', isIcon: true),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: DoctorBoxDetialAppointmentWidget(
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
              const SliverPadding(
                padding: AutilabMargin.marginFullScreen,
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'How would you rate your Appointment?',
                    style: AutilabTextStyle.small14_400,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    initialRating: 0,
                    itemCount: 5,
                    minRating: 1,
                    maxRating: 5,
                    updateOnDrag: true,
                    itemSize: 50,
                    itemPadding:
                        const EdgeInsetsGeometry.symmetric(horizontal: 4),
                    unratedColor: AutilabColor.gray,
                    glow: false,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star_rounded,
                        color: AutilabColor.yellow,
                        size: 24,
                      );
                    },
                    onRatingUpdate: (value) {
                      // selectedIndexrating.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
