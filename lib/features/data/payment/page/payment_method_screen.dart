import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/constant_routes.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/functions/animation_control.dart';
import '../widgets/selectmethodpaymentbox_widget.dart';
import '../widgets/text_field_card_info_widget.dart';

//TextInputFormatter for enter bank card number
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      if (i % 4 == 3 && i != digitsOnly.length - 1) {
        buffer.write(' ');
      }
    }

    final newText = buffer.toString();
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

//TextInputFormatter for enter expire date bank card
class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with TickerProviderStateMixin {
  late AnimationHelper animationHelper;
  final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);
  final bankCardNumberController = TextEditingController();
  final bankCardNameController = TextEditingController();
  final bankCardCVVController = TextEditingController();
  final bankCardExpireDateController = TextEditingController();

  final bankCardNumberFocusNode = FocusNode();
  final bankCardNameFocusNode = FocusNode();
  final bankCardCVVFocusNode = FocusNode();
  final bankCardExpireDateFocusNode = FocusNode();
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
  void didUpdateWidget(covariant PaymentMethodScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationHelper.restartAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationHelper.fadeAnimation,
      child: Scaffold(
        appBar: appBarWidget(context: context, title: 'Payment', isIcon: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                const SizedBox(
                  height: 4,
                ),
                const Padding(
                  padding: AutilabMargin.marginFullScreen,
                  child: Text(
                    'Select Your Payment Method ',
                    style: AutilabTextStyle.medium20_500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SelectMethodPayBoxWidget(
                  selectedIndexNotifier: selectedIndexNotifier,
                  title: 'Paypal',
                  logo: 'assets/icons/paypal_logo.svg',
                  index: 0,
                ),
                SelectMethodPayBoxWidget(
                  selectedIndexNotifier: selectedIndexNotifier,
                  title: 'Google pay',
                  logo: 'assets/icons/googlepay_logo.svg',
                  index: 1,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: AutilabMargin.marginFullScreen,
                  decoration: BoxDecoration(
                    border: Border.all(color: AutilabColor.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SelectMethodPayBoxWidget(
                        selectedIndexNotifier: selectedIndexNotifier,
                        title: 'Credit Card',
                        logo: 'assets/icons/googlepay_logo.svg',
                        index: 2,
                        isBorder: false,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFieldCardInfo(
                        textEditingController: bankCardNumberController,
                        focusNode: bankCardNumberFocusNode,
                        title: 'Card Number',
                        width: double.infinity,
                        maxLength: 19,
                        hint: '1415 1415 1415 1415',
                        keyboardType: TextInputType.number,
                        textInputFormat: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldCardInfo(
                        textEditingController: bankCardNameController,
                        focusNode: bankCardNameFocusNode,
                        title: 'Name On Card',
                        width: double.infinity,
                        hint: 'Name On Card',
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldCardInfo(
                            textEditingController: bankCardCVVController,
                            focusNode: bankCardCVVFocusNode,
                            title: 'CVV',
                            width: 130,
                            hint: 'CVV',
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                          ),
                          TextFieldCardInfo(
                            textEditingController: bankCardExpireDateController,
                            focusNode: bankCardExpireDateFocusNode,
                            title: 'Expire Date',
                            width: 130,
                            hint: 'MM/YY',
                            keyboardType: TextInputType.datetime,
                            maxLength: 5,
                            textInputFormat: [
                              FilteringTextInputFormatter.digitsOnly,
                              CardExpirationFormatter(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomButtonWidget(
                  onTap: () {
                    context.pushNamed(AutiLabRoutes.notSuccessfulPaymentScreen);
                  },
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  color: AutilabColor.bb,
                  text: 'Pay',
                  textStyle: AutilabTextStyle.small18_400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
