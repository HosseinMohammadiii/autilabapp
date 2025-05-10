import 'package:autilab_project/common/widgets/appbar_back_screen.dart';
import 'package:autilab_project/common/widgets/custom_button_widget.dart';
import 'package:autilab_project/core/constants/color_constant.dart';
import 'package:autilab_project/core/constants/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/functions/animation_control.dart';

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
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      TextFieldCardnfo(
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
                      TextFieldCardnfo(
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
                          TextFieldCardnfo(
                            textEditingController: bankCardCVVController,
                            focusNode: bankCardCVVFocusNode,
                            title: 'CVV',
                            width: 130,
                            hint: 'CVV',
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                          ),
                          TextFieldCardnfo(
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
                  onTap: () {},
                  height: 50,
                  margin: AutilabMargin.marginFullScreen,
                  color: AutilabColor.bb,
                  text: 'Pay 1235',
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

class TextFieldCardnfo extends StatelessWidget {
  const TextFieldCardnfo({
    super.key,
    required this.title,
    required this.width,
    required this.textEditingController,
    required this.focusNode,
    this.maxLength,
    required this.hint,
    required this.keyboardType,
    this.textInputFormat,
  });
  final String title;

  final double width;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final int? maxLength;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? textInputFormat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AutilabTextStyle.small16_400,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 55,
          width: width,
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            cursorColor: Colors.black,
            keyboardType: keyboardType,
            inputFormatters: textInputFormat,
            maxLength: maxLength,
            buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) {
              return const SizedBox();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              hintText: hint,
              hintStyle: AutilabTextStyle.small12_400
                  .copyWith(color: AutilabColor.gray),
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
            onChanged: (value) {
              value.replaceAll(" ", "");
            },
            onTapOutside: (event) {
              //Unfocus TextField
              focusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }
}

class SelectMethodPayBoxWidget extends StatelessWidget {
  const SelectMethodPayBoxWidget({
    super.key,
    required this.selectedIndexNotifier,
    this.isBorder = true,
    required this.title,
    required this.logo,
    required this.index,
  });

  final ValueNotifier<int?> selectedIndexNotifier;
  final bool isBorder;
  final String title;
  final String logo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.all(isBorder ? 16 : 0),
      margin: isBorder ? AutilabMargin.marginFullScreen : null,
      decoration: BoxDecoration(
        border: Border.all(
            color: isBorder ? AutilabColor.black : Colors.transparent),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          ValueListenableBuilder<int?>(
            valueListenable: selectedIndexNotifier,
            builder: (context, selectedIndex, child) {
              return GestureDetector(
                onTap: () {
                  selectedIndexNotifier.value = index;
                },
                child: Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AutilabColor.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedIndex == index
                      ? const Icon(
                          Icons.done_rounded,
                          size: 16,
                        )
                      : const SizedBox(),
                ),
              );
            },
          ),
          Text(
            title,
            style: AutilabTextStyle.medium16_500,
          ),
          const Spacer(),
          isBorder
              ? SvgPicture.asset(logo)
              : Row(
                  spacing: 8,
                  children: [
                    SvgPicture.asset('assets/icons/discover_logo.svg'),
                    SvgPicture.asset('assets/icons/visa_logo.svg'),
                    SvgPicture.asset('assets/icons/mastercard_logo.svg'),
                  ],
                ),
        ],
      ),
    );
  }
}
