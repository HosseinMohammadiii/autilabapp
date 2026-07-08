import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:autilab_project/features/data/home/data/model/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/responsive_widget.dart';
import '../../../../core/network/locator.dart';
import '../../../../utils/functions/animation_control.dart';
import '../../auth/presentetion/bloc/auth_bloc.dart';
import '../../auth/presentetion/bloc/auth_event.dart';
import '../../auth/presentetion/bloc/auth_state.dart';
import '../widgets/cart_item_widget.dart';

class PersonalDetailPaymentScreen extends StatefulWidget {
  const PersonalDetailPaymentScreen({
    super.key,
    required this.planModel,
  });

  final PlanModel planModel;

  @override
  State<PersonalDetailPaymentScreen> createState() =>
      _PersonalDetailPaymentScreenState();
}

class _PersonalDetailPaymentScreenState
    extends State<PersonalDetailPaymentScreen> with TickerProviderStateMixin {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
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
  void didUpdateWidget(covariant PersonalDetailPaymentScreen oldWidget) {
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
              appBar: appBarWidget(
                context: context,
                title: 'Pesonal Detail',
                isIcon: true,
                isMobile: isMobile(),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Text(
                          'Your Package',
                          style: AutilabTextStyle.medium20_500.copyWith(
                            fontSize: isMobile() ? 20 : 32,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: EdgeInsets.all(isMobile() ? 8 : 12),
                        margin: AutilabMargin.marginFullScreen,
                        decoration: BoxDecoration(
                          color: const Color(0xffECF0FF),
                          border: Border.all(color: AutilabColor.bb),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          spacing: 16,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AutilabColor.yellow,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/crown_icon.svg',
                                fit: BoxFit.contain,
                                height: isMobile() ? 40 : 68,
                                width: isMobile() ? 40 : 68,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.planModel.name,
                                    style:
                                        AutilabTextStyle.medium16_500.copyWith(
                                      fontSize: isMobile() ? 16 : 28,
                                    ),
                                  ),
                                  Text(
                                    widget.planModel.description,
                                    style:
                                        AutilabTextStyle.small14_400.copyWith(
                                      fontSize: isMobile() ? 14 : 18,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Divider(
                          thickness: 1,
                          color: AutilabColor.gray,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: AutilabMargin.marginFullScreen,
                        child: Text(
                          'Your Cart',
                          style: AutilabTextStyle.small20_400.copyWith(
                            fontSize: isMobile() ? 20 : 28,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      BlocProvider(
                        create: (context) => AuthenticationBloc(locator.get())
                          ..add(DisplayInformationUser()),
                        child: BlocBuilder<AuthenticationBloc,
                            AuthenticationState>(
                          builder: (context, state) {
                            // if (state is AuthenticationLoading) {
                            //   return const Center(
                            //     child: CircularProgressIndicator(
                            //       color: AutilabColor.bb,
                            //     ),
                            //   );
                            // }
                            // if (state is FetchUserDataResponse) {
                            // return state.response.fold(
                            //   (l) {
                            //     return Center(
                            //       child: Text(l),
                            //     );
                            //   },
                            // (userDetail) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              margin: AutilabMargin.marginFullScreen,
                              decoration: BoxDecoration(
                                color: const Color(0xffECF0FF),
                                border: Border.all(color: AutilabColor.bb),
                                borderRadius:
                                    BorderRadius.circular(isMobile() ? 16 : 24),
                              ),
                              child: Column(
                                spacing: 16,
                                children: [
                                  CartItemWidget(
                                    isMobile: isMobile(),
                                    title: 'Name',
                                    // subTitle: userDetail.firstName,
                                    subTitle: 'Lila',
                                  ),
                                  CartItemWidget(
                                    isMobile: isMobile(),
                                    title: 'Last Name',
                                    // subTitle: userDetail.lastName,
                                    subTitle: 'Rose',
                                  ),
                                  // CartItemWidget(
                                  //   isMobile: isMobile(),
                                  //   title: 'Phone Namber',
                                  //   subTitle: '(+1) 289 2658558',
                                  // ),
                                  CartItemWidget(
                                    isMobile: isMobile(),
                                    title: 'Email',
                                    // subTitle: userDetail.email,
                                    subTitle: 'lilarose@email.com',
                                  ),
                                  CartItemWidget(
                                    isMobile: isMobile(),
                                    title: 'Invoice Number',
                                    subTitle: '1020',
                                  ),
                                ],
                              ),
                            );
                          },
                          // );
                          // }
                          // return const SizedBox();
                          // },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: isMobile() ? 50 : 70,
                        child: Padding(
                          padding: AutilabMargin.marginFullScreen,
                          child: TextField(
                            focusNode: focusNode,
                            controller: textEditingController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              hintText: 'Discount Code',
                              hintStyle: AutilabTextStyle.small12_400.copyWith(
                                fontSize: isMobile() ? 12 : 16,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: isMobile() ? 71 : 177,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AutilabColor.yellow,
                                    borderRadius: BorderRadius.circular(
                                        isMobile() ? 8 : 24),
                                  ),
                                  child: Text(
                                    'Check',
                                    style:
                                        AutilabTextStyle.small14_400.copyWith(
                                      fontSize: isMobile() ? 14 : 18,
                                    ),
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 0.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
                                  width: 0.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AutilabColor.black,
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
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: AutilabMargin.marginFullScreen,
                        decoration: BoxDecoration(
                          color: const Color(0xffECF0FF),
                          border: Border.all(color: AutilabColor.bb),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          spacing: 16,
                          children: [
                            CartItemWidget(
                              isMobile: isMobile(),
                              title: 'Price',
                              subTitle: '\$${widget.planModel.price.toInt()}',
                            ),
                            CartItemWidget(
                              isMobile: isMobile(),
                              title: 'Tax',
                              subTitle: '\$12',
                            ),
                            CartItemWidget(
                              isMobile: isMobile(),
                              title: 'Discount',
                              subTitle:
                                  '\$${widget.planModel.price.toInt() - 3}',
                            ),
                            CartItemWidget(
                              isMobile: isMobile(),
                              title: 'Total',
                              subTitle:
                                  '\$${widget.planModel.price.toInt() + 9}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      CustomButtonWidget(
                        onTap: () {
                          context.pushNamed(AutiLabRoutes.paymentMethodScreen);
                        },
                        height: 50,
                        isMobile: isMobile(),
                        margin: AutilabMargin.marginFullScreen,
                        color: AutilabColor.bb,
                        text: 'Checkout',
                        textStyle: AutilabTextStyle.small18_400,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButtonWidget(
                        onTap: () {
                          context.pop();
                        },
                        height: 50,
                        isMobile: isMobile(),
                        margin: AutilabMargin.marginFullScreen,
                        color: const Color(0xffECF0FF),
                        bordeColor: AutilabColor.bb,
                        text: 'Back',
                        textStyle: AutilabTextStyle.small18_400,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
