import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
// import 'package:autilab_project/common/widgets/custom_textfield.dart';
// import 'package:autilab_project/common/widgets/loading_indicator_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_bloc.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_event.dart';
import 'package:autilab_project/features/data/test/presentation/bloc/test_state.dart';
// import 'package:autilab_project/features/data/test/widgets/multiselectanswer_widget.dart';
// import 'package:autilab_project/features/data/test/widgets/singleselctedanswer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/widgets/responsive_widget.dart';
import '../../../../../core/network/locator.dart';
import '../../../../../utils/functions/animation_control.dart';
import '../../data/model/intelligence_model.dart';
import '../../data/model/testanswer_param.dart';
import '../../widgets/exit_page_dialog_widget.dart';

class QuizClass {
  String title;
  bool value;
  QuizClass(this.title, this.value);
}

class TestClass {
  int questionId;
  int awnserId;
  String title;
  bool value;
  TestClass(this.awnserId, this.questionId, this.title, this.value);
}

class QuizAndSelectAnswerScreen extends StatefulWidget {
  const QuizAndSelectAnswerScreen({super.key});

  @override
  State<QuizAndSelectAnswerScreen> createState() =>
      _QuizAndSelectAnswerScreenState();
}

class _QuizAndSelectAnswerScreenState extends State<QuizAndSelectAnswerScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  late List<bool> selectedItemsList;

  final pageController = PageController();

  final textEditingController = TextEditingController();
  final textFocusNode = FocusNode();
  bool isClosePage = false;
  bool isSelected = false;

  int currentPage = 0;
  int answerId = 0;
  int questionId = 0;
  int intelligenceId = 1;
  String questionTitle = '';
  @override
  void initState() {
    BlocProvider.of<TestBloc>(context).add(DisplayAllIntelligence());
    super.initState();
    animationHelper = AnimationHelper(
        vsync: this, begin: 0.5, duration: const Duration(seconds: 1));

    animationHelper.animationController.forward();
    selectedItemsList = List<bool>.generate(3, (_) => false);
  }

  @override
  void dispose() {
    animationHelper.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuizAndSelectAnswerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  List<TestClass> quizList = [];
  List<IntelligenceModel> intelligenceQuizList = [];
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
            child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (didPop) return;

                final bool? shouldPop = await showDialog(
                  context: context,
                  builder: (context) =>
                      ExitPageDialogWidget(isMobile: isMobile()),
                );
                if (shouldPop ?? false) {
                  context.pop();
                }
              },
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        TestBloc(locator.get())..add(DisplayAllIntelligence()),
                  ),
                  BlocProvider(
                    create: (context) => TestBloc(locator.get())
                      ..add(
                          DisplayIntelligence(intelligenceId: intelligenceId)),
                  ),
                ],
                child: BlocConsumer<TestBloc, TestState>(
                  listener: (context, state) {
                    if (state is IntelligenceAnswerState) {
                      setState(() {
                        if (intelligenceId != 24) {
                          intelligenceId += 1;
                        }
                        selectedItemsList.fillRange(
                            0, selectedItemsList.length, false);
                        isSelected = false;
                      });

                      //Next page
                      pageController.animateToPage(
                        pageController.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );

                      BlocProvider.of<TestBloc>(context).add(
                          DisplayIntelligence(intelligenceId: intelligenceId));
                    }
                    if (state is DisplayIntelligenceState) {
                      intelligenceQuizList = state.displayIntelligenceList;

                      for (var element in state.displayIntelligence) {
                        questionTitle = element.question;
                        quizList = [
                          TestClass(
                            element.answer![0].answerId,
                            element.answer![0].questionId,
                            element.answer![0].answer,
                            false,
                          ),
                          TestClass(
                            element.answer![1].answerId,
                            element.answer![1].questionId,
                            element.answer![1].answer,
                            false,
                          ),
                          TestClass(
                            element.answer![2].answerId,
                            element.answer![2].questionId,
                            element.answer![2].answer,
                            false,
                          ),
                        ];
                      }
                    }
                  },
                  builder: (context, state) {
                    return Scaffold(
                      appBar: appBarWidget(
                        context: context,
                        title: 'Quiz',
                        isIcon: true,
                        isQuizScreen: true,
                        isMobile: isMobile(),
                      ),
                      body: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is! TestLoading) ...[
                              Padding(
                                padding: AutilabMargin.marginFullScreen,
                                child: Text(
                                  questionTitle,
                                  textAlign: TextAlign.center,
                                  style: AutilabTextStyle.small14_400.copyWith(
                                    fontSize: isMobile() ? 18 : 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 400,
                                child: PageView.builder(
                                  onPageChanged: (value) {
                                    setState(() {
                                      currentPage = value;
                                    });
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageController,
                                  itemCount: intelligenceQuizList.length,
                                  itemBuilder: (context, index) {
                                    // selectedItemsList = List.generate(
                                    //     quizList[index].title.length,
                                    //     (_) => false);

                                    // if (index == 0) {
                                    //   return MultiSelectAnswerWidget(
                                    //     isMobile: isMobile(),
                                    //     quizList: quizList,
                                    //   );
                                    // } else if (index == 1) {
                                    // return SingleSelctedAnswerWidget(
                                    //   isMobile: isMobile(),
                                    //   quizList: quizList,
                                    //   selectedItems: selectedItems,
                                    //   onTap: (questionId, awnserId) {
                                    //     // if (selectedItems.contains(true)) {
                                    //     //   setState(() {
                                    //     //     isSelected = true;
                                    //     //   });
                                    //     // }

                                    //     print(
                                    //         " Qestion ID: $questionId -- Awnser Id:$awnserId");
                                    //   },
                                    // );

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: quizList.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              for (int i = 0;
                                                  i < quizList.length;
                                                  i++) {
                                                selectedItemsList[i] =
                                                    i == index;
                                              }

                                              if (selectedItemsList
                                                  .contains(true)) {
                                                isSelected = true;
                                              }
                                            });
                                            answerId = quizList[index].awnserId;
                                            questionId =
                                                quizList[index].questionId;
                                          },
                                          child: Container(
                                            height: isMobile() ? 50 : 72,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: selectedItemsList[index]
                                                  ? AutilabColor.bb
                                                  : const Color(0xffECF0FF),
                                              border: Border.all(
                                                  color: AutilabColor.bb,
                                                  width: isMobile() ? 0.5 : 2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      isMobile() ? 16 : 24),
                                            ),
                                            child: Text(
                                              quizList[index].title,
                                              style: AutilabTextStyle
                                                  .small18_400
                                                  .copyWith(
                                                fontSize: isMobile() ? 18 : 24,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    // } else {
                                    //   return Padding(
                                    //     padding: const EdgeInsets.only(top: 15),
                                    //     child: CustomTextfield(
                                    //       isMobile: isMobile(),
                                    //       label: 'Type Here',
                                    //       controller: textEditingController,
                                    //       focusNode: textFocusNode,
                                    //       maxLines: 12,
                                    //       borderWidth: isMobile() ? 0.5 : 2,
                                    //       borderRaduis: isMobile() ? 16 : 24,
                                    //       textStyle: AutilabTextStyle.small18_400
                                    //           .copyWith(
                                    //         fontSize: isMobile() ? 18 : 24,
                                    //       ),
                                    //       lblColor: AutilabColor.gray,
                                    //       backgroundColor:
                                    //           const Color(0xffECF0FF),
                                    //       borderColor: AutilabColor.bb,
                                    //       textInputAction: TextInputAction.done,
                                    //       textInputType: TextInputType.text,
                                    //     ),
                                    //   );
                                    // }
                                  },
                                ),
                              ),
                            ] else ...[
                              const Spacer(),
                              const Center(
                                child: CircularProgressIndicator(
                                  color: AutilabColor.bb,
                                ),
                              ),
                            ],
                            const Spacer(),
                            CustomButtonWidget(
                              onTap: () {
                                if (!isSelected) {
                                  return;
                                }

                                BlocProvider.of<TestBloc>(context).add(
                                  SendIntelligenceAnswer(
                                    testanswerParam: TestanswerParam(
                                      questionId: questionId,
                                      answerId: answerId,
                                    ),
                                  ),
                                );
                                if (currentPage == 23) {
                                  context.pop();
                                  context.pop();
                                }
                              },
                              width: isMobile() ? 166 : 350,
                              height: 50,
                              isLoading: state is TestLoading,
                              isMobile: isMobile(),
                              margin: const EdgeInsets.only(
                                  bottom: 40, right: 20, left: 20),
                              color: isSelected
                                  ? AutilabColor.bb
                                  : AutilabColor.bb.withValues(alpha: 0.4),
                              text: currentPage != 23 ? 'Next' : 'Submit',
                              textStyle: AutilabTextStyle.small18_400.copyWith(
                                fontSize: isMobile() ? 18 : 24,
                              ),
                            ),
                            // Padding(
                            //   padding: AutilabMargin.marginFullScreen,
                            //   child: Row(
                            //     spacing: 18,
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Visibility(
                            //         visible: intelligenceId != 1,
                            //         child: CustomButtonWidget(
                            //           onTap: () {
                            //             setState(() {
                            //               if (intelligenceId != 1) {
                            //                 intelligenceId -= 1;
                            //               }
                            //             });
                            //             //Previous page
                            //             pageController.animateToPage(
                            //               pageController.page!.toInt() - 1,
                            //               duration:
                            //                   const Duration(milliseconds: 300),
                            //               curve: Curves.easeInOut,
                            //             );
                            //             BlocProvider.of<TestBloc>(context).add(
                            //                 DisplayIntelligence(
                            //                     intelligenceId:
                            //                         intelligenceId));
                            //           },
                            //           width: isMobile() ? 166 : 350,
                            //           height: 50,
                            //           isMobile: isMobile(),
                            //           bordeColor: AutilabColor.bb,
                            //           margin: const EdgeInsets.only(bottom: 40),
                            //           color: const Color(0xffECF0FF),
                            //           text: 'Back',
                            //           textStyle:
                            //               AutilabTextStyle.small18_400.copyWith(
                            //             fontSize: isMobile() ? 18 : 24,
                            //           ),
                            //         ),
                            //       ),
                            //       CustomButtonWidget(
                            //         onTap: () {
                            //           if (!isSelected) {
                            //             return;
                            //           }
                            //           setState(() {
                            //             if (intelligenceId != 24) {
                            //               intelligenceId += 1;
                            //             }
                            //             selectedItemsList.fillRange(
                            //                 0, selectedItemsList.length, false);
                            //             isSelected = false;
                            //           });

                            //           //Next page
                            //           pageController.animateToPage(
                            //             pageController.page!.toInt() + 1,
                            //             duration:
                            //                 const Duration(milliseconds: 300),
                            //             curve: Curves.easeInOut,
                            //           );
                            //           BlocProvider.of<TestBloc>(context).add(
                            //               DisplayIntelligence(
                            //                   intelligenceId: intelligenceId));
                            //           if (currentPage == 23) {
                            //             context.pop();
                            //             context.pop();
                            //           }
                            //         },
                            //         width: isMobile() ? 166 : 350,
                            //         height: 50,
                            //         isLoading: state is TestLoading,
                            //         isMobile: isMobile(),
                            //         margin: const EdgeInsets.only(bottom: 40),
                            //         color: isSelected
                            //             ? AutilabColor.bb
                            //             : AutilabColor.bb
                            //                 .withValues(alpha: 0.4),
                            //         text: currentPage != 23 ? 'Next' : 'Submit',
                            //         textStyle:
                            //             AutilabTextStyle.small18_400.copyWith(
                            //           fontSize: isMobile() ? 18 : 24,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
