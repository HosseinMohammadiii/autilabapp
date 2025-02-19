import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/features/data/doctor/widgets/button_card.dart';
import 'package:autilab_project/features/data/doctor/widgets/doctor_box_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/cached_network_image_widget.dart';
import '../../../../common/widgets/custom_tabbar_widget.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../utils/tabbar_delegate.dart';
import '../widgets/custom_checkbox_widget.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  bool isChecked = false;

  List<String> titleCategory = [
    'Behaviorism',
    'Pediatrician',
    'Physiotherapy',
    'Consultant',
    'Psychologist',
    'Speech therapy',
  ];

  List<String> imageCategory = [
    'assets/images/behaviorism_image.png',
    'assets/images/pediatrician_image.png',
    'assets/images/physiotherapy_image.png',
    'assets/images/conversation_image.png',
    'assets/images/psychologist_image.png',
    'assets/images/speech_therapy_image.png',
  ];
  List<Color> colorBoxCategory = const [
    Color(0xffC772FF),
    Color.fromRGBO(83, 226, 255, 0.7),
    Color(0xffFF7272),
    Color(0xff8AEDCE),
    Color(0xff5669FF),
    Color(0xffFFB253),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomTabBarWidget(
          tabLength: 2,
          tabBar: [
            FittedBox(
              child: Text(
                'Find Doctor',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            FittedBox(
              child: Text(
                'Nearby centers',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ],
          tabBarView: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: searchFocusNode,
                            controller: searchController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              prefixIcon: SvgPicture.asset(
                                fit: BoxFit.none,
                                'assets/icons/search_icon.svg',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                            onTapOutside: (event) {
                              //Unfocus TextField
                              searchFocusNode.unfocus();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showCustomDialog(
                              context,
                              _buildDialogSortIcon(
                                context,
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            fit: BoxFit.none,
                            'assets/icons/sort_icon.svg',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Specialties',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showCustomDialog(
                              context,
                              _buildDialogContent(
                                context,
                                (index) {},
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AutilabColor.blue,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 113,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: titleCategory.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 113,
                            width: 132,
                            margin: const EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorBoxCategory[index],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(imageCategory[index]),
                                Text(
                                  titleCategory[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Expert Doctors',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const DoctorBoxWidget();
                      },
                    ),
                  ],
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 441,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23, vertical: 45),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffECF0FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/map_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Find Nearby centers',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Tap the map and select your location to see centers near you.',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Suggestions',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 445,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: AutilabColor.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Wrap(
                        // spacing: 32,
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        // alignment: WrapAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/autism_help_center.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Autism Help Center',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                ButtonCard(
                                  onTap: () {},
                                  margin: const EdgeInsets.only(right: 8),
                                  icon: 'assets/icons/heart.svg',
                                ),
                                ButtonCard(
                                  onTap: () {},
                                  margin: const EdgeInsets.all(0),
                                  icon: 'assets/icons/messages.svg',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 72,
                            child: Text(
                              'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    overflow: TextOverflow.fade,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          CustomButtonWidget(
                            onTap: () {},
                            height: 50,
                            margin: const EdgeInsets.only(bottom: 8, top: 8),
                            color: AutilabColor.bb,
                            text: 'See Details',
                            textStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context, Widget widget) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: Dialog(
            backgroundColor: AutilabColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  Widget _buildDialogContent(
    BuildContext context,
    Function(int index) onTap,
  ) {
    return Container(
      width: 320,
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                icon: const Icon(Icons.close_rounded),
              ),
              Text(
                'All Specialties',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 22,
                mainAxisExtent: 113,
              ),
              itemCount: titleCategory.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: colorBoxCategory[index],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          imageCategory[index],
                        ),
                        Text(
                          titleCategory[index],
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogSortIcon(
    BuildContext context,
  ) {
    final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);
    final ValueNotifier<int?> selectedIndexSpecialty =
        ValueNotifier<int?>(null);
    final ValueNotifier<double?> selectedIndexrating =
        ValueNotifier<double?>(null);
    return Container(
      width: 320,
      height: 559,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 24,
            automaticallyImplyLeading: false,
            flexibleSpace: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    selectedIndexSpecialty.value = null;
                    selectedIndexNotifier.value = null;
                    selectedIndexrating.value = null;
                  },
                  child: Text(
                    'Rest Filter',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "Doctor's specialty",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    // height: 4,
                  ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ValueListenableBuilder(
                valueListenable: selectedIndexSpecialty,
                builder: (context, value, child) => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 45,
                    mainAxisSpacing: 8,
                    childAspectRatio: 3.5,
                    mainAxisExtent: 37,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return CustomButtonWidget(
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      onTap: () {
                        selectedIndexSpecialty.value = index;
                      },
                      height: 37,
                      color: selectedIndexSpecialty.value == index
                          ? AutilabColor.bb
                          : AutilabColor.lightGray,
                      text: titleCategory[index],
                      textStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Gender',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
            ),
          ),
          SliverToBoxAdapter(
            child: CustomCheckbox(
              title: 'Male',
              index: 1,
              selectedIndexNotifier: selectedIndexNotifier,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomCheckbox(
              title: 'Female',
              index: 2,
              selectedIndexNotifier: selectedIndexNotifier,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: AutilabColor.gray,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Rating',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
              valueListenable: selectedIndexrating,
              builder: (context, value, child) => RatingBar.builder(
                initialRating: selectedIndexrating.value ?? 0,
                itemCount: 5,
                minRating: 1,
                maxRating: 5,
                updateOnDrag: true,
                itemSize: 24,
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
                  selectedIndexrating.value = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
