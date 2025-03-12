import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;

  final ScrollController _scrollController = ScrollController();

  final typeMessageController = TextEditingController();

  final typeMessageFocusNode = FocusNode();
  @override
  void initState() {
    typeMessageFocusNode.addListener(_scrollToEnd);
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();

//Scroll to the last item after the page is created.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

//Method for scroll to latest item
  void _scrollToEnd() {
    if (_scrollController.hasClients || typeMessageFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    animationHelper.dispose();
    typeMessageFocusNode.removeListener(_scrollToEnd);
    typeMessageFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MessageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 118),
          child: AppBar(
            backgroundColor: AutilabColor.primary,
            automaticallyImplyLeading: false,
            elevation: 0,
            scrolledUnderElevation: 0,
            toolbarHeight: 150,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: SvgPicture.asset(
                      AutilabIcon.backIconRounded,
                      alignment: AlignmentDirectional.centerStart,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/doctor_image.png',
                      height: 46,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            'Dr. Sophia Martinez',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        FittedBox(
                          child: Text(
                            'Psychotherapy',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  displayIconButton(
                    AutilabIcon.videoCall,
                    () {},
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  displayIconButton(
                    AutilabIcon.voiceCall,
                    () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 80,
            width: double.infinity,
            color: AutilabColor.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                displayIconButton(
                  AutilabIcon.selectDocumentIcon,
                  () {},
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      focusNode: typeMessageFocusNode,
                      controller: typeMessageController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: AutilabColor.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            fit: BoxFit.none,
                            AutilabIcon.recordSoundIcon,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {},
                      onTapOutside: (event) {
                        //Unfocus TextField
                        typeMessageFocusNode.unfocus();
                      },
                    ),
                  ),
                ),
                displayIconButton(
                  AutilabIcon.sendMessageIcon,
                  () {},
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                ),
              ),
              SliverList.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    margin:
                        const EdgeInsets.only(left: 14, bottom: 48, right: 70),
                    decoration: BoxDecoration(
                      color: const Color(0xffECF0FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "I don't know why people are so anti pineapple pizza. I kind of like it.",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  );
                },
              ),
              SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 10,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    margin:
                        const EdgeInsets.only(left: 70, bottom: 48, right: 14),
                    decoration: BoxDecoration(
                      color: AutilabColor.bb,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "That's perfect. There's a new place on Main St I've been wanting to check out. I hear their hawaiian pizza is awesome!",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget for display icon button example: video_call_icon
  Widget displayIconButton(
    String icon,
    Function() ontap,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 35,
        height: 35,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AutilabColor.bb,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
