import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/cart_item_widget.dart';

class PersonalDetailPaymentScreen extends StatefulWidget {
  const PersonalDetailPaymentScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });
  final String title;
  final String? description;
  final int price;

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
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(
            context: context, title: 'Pesonal Detail', isIcon: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Text(
                    'Your Package',
                    style: AutilabTextStyle.medium20_500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
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
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AutilabColor.yellow,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/crown_icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: AutilabTextStyle.medium16_500,
                            ),
                            Text(
                              widget.description ??
                                  'An Initial Test To Determine How Much You Are At Risk Of Cancer Based.',
                              style: AutilabTextStyle.small14_400,
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
                    style: AutilabTextStyle.small20_400,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: AutilabMargin.marginFullScreen,
                  decoration: BoxDecoration(
                    color: const Color(0xffECF0FF),
                    border: Border.all(color: AutilabColor.bb),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    spacing: 16,
                    children: [
                      CartItemWidget(
                        title: 'Name',
                        subTitle: 'Alexi',
                      ),
                      CartItemWidget(
                        title: 'Last Name',
                        subTitle: 'Opaana',
                      ),
                      CartItemWidget(
                        title: 'Phone Namber',
                        subTitle: '(+1) 289 2658558',
                      ),
                      CartItemWidget(
                        title: 'Email',
                        subTitle: 'Alexii@gmail.com',
                      ),
                      CartItemWidget(
                        title: 'Invoice Number',
                        subTitle: '1020',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
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
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 71,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AutilabColor.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Check',
                              style: AutilabTextStyle.small14_400,
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
                        title: 'Price',
                        subTitle: '\$${widget.price}',
                      ),
                      const CartItemWidget(
                        title: 'Tax',
                        subTitle: '\$12',
                      ),
                      CartItemWidget(
                        title: 'Discount',
                        subTitle: '\$${widget.price - 3}',
                      ),
                      CartItemWidget(
                        title: 'Total',
                        subTitle: '\$${widget.price + 9}',
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
    );
  }
}
