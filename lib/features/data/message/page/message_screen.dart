import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/responsive_widget.dart';
import '../../../../core/constants/theme_constant.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../../../utils/functions/cacheimahe_function.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
    required this.image,
    required this.name,
    required this.expertise,
  });
  final String image;
  final String name;
  final String expertise;

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

//Scroll to the last message after the textfield focus.
    typeMessageFocusNode.addListener(() {
      if (typeMessageFocusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToEnd();
        });
      }
    });

//Scroll to the last item after the page is created.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

//Method for scroll to latest item
  void _scrollToEnd() {
    if (_scrollController.hasClients) {
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
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, isMobile() ? 118 : 134),
                child: AppBar(
                  backgroundColor: AutilabColor.primary,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  toolbarHeight: 160,
                  flexibleSpace: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: SvgPicture.asset(
                            AutilabIcon.backIconRounded,
                            width: isMobile() ? 24 : 32,
                            height: isMobile() ? 24 : 32,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            widget.image,
                            height: isMobile() ? 46 : 76,
                            width: isMobile() ? 46 : 76,
                            cacheWidth: cacheImageFunction(
                                isMobile() ? 46 : 76, context),
                            cacheHeight: cacheImageFunction(
                                isMobile() ? 46 : 76, context),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  widget.name,
                                  style: AutilabTextStyle.medium14_500.copyWith(
                                    fontSize: isMobile() ? 14 : 24,
                                  ),
                                ),
                              ),
                              if (widget.expertise.isNotEmpty) ...[
                                const SizedBox(
                                  height: 8,
                                ),
                                FittedBox(
                                  child: Text(
                                    widget.expertise,
                                    style:
                                        AutilabTextStyle.small14_400.copyWith(
                                      fontSize: isMobile() ? 14 : 18,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    height: isMobile() ? 80 : 132,
                    width: double.infinity,
                    color: AutilabColor.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      spacing: 16,
                      children: [
                        displayIconButton(
                          AutilabIcon.selectDocumentIcon,
                          () {},
                          isMobile(),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: typeMessageFocusNode,
                            controller: typeMessageController,
                            cursorColor: Colors.black,
                            style: AutilabTextStyle.small12_400.copyWith(
                              fontSize: isMobile() ? 12 : 18,
                            ),
                            decoration: InputDecoration(
                              fillColor: AutilabColor.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: isMobile() ? 22 : 34),
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  fit: BoxFit.none,
                                  width: isMobile() ? 24 : 40,
                                  height: isMobile() ? 24 : 40,
                                  AutilabIcon.recordSoundIcon,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
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
                        displayIconButton(
                          AutilabIcon.sendMessageIcon,
                          () {},
                          isMobile(),
                        ),
                      ],
                    ),
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          margin: const EdgeInsets.only(
                              left: 14, bottom: 16, right: 70),
                          decoration: BoxDecoration(
                            color: const Color(0xffECF0FF),
                            borderRadius:
                                BorderRadius.circular(isMobile() ? 16 : 24),
                          ),
                          child: Text(
                            "I don't know why people are so anti pineapple pizza. I kind of like it.",
                            style: AutilabTextStyle.small12_400.copyWith(
                              fontSize: isMobile() ? 12 : 18,
                            ),
                          ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverList.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 10,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          margin: const EdgeInsets.only(
                              left: 70, bottom: 16, right: 14),
                          decoration: BoxDecoration(
                            color: AutilabColor.bb,
                            borderRadius:
                                BorderRadius.circular(isMobile() ? 16 : 24),
                          ),
                          child: Text(
                            "That's perfect. There's a new place on Main St I've been wanting to check out. I hear their hawaiian pizza is awesome!",
                            style: AutilabTextStyle.small12_400.copyWith(
                              fontSize: isMobile() ? 12 : 18,
                            ),
                          ),
                        );
                      },
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

//Widget for display icon button example: video_call_icon
  Widget displayIconButton(
    String icon,
    Function() ontap,
    final bool isMobile,
  ) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: isMobile ? 35 : 68,
        height: isMobile ? 35 : 68,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AutilabColor.bb,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
