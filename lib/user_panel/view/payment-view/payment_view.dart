import 'package:catch_case/user_panel/constant-widgets/constant_appbar.dart';
import 'package:catch_case/user_panel/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/view/payment-view/payment_verified_view.dart';
import 'package:credit_card_form/credit_card_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/textstyles.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CreditCardController cardController = CreditCardController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(
          text: 'Payment',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02),
                Text(
                  'Choose a payment',
                  style: kBody1Black,
                ),
                SizedBox(height: Get.height * 0.01),
                FittedBox(
                  child: Row(
                    children: [
                      circularPaymentAvatar('assets/images/payment/paypal.png'),
                      circularPaymentAvatar('assets/images/payment/visa.png'),
                      circularPaymentAvatar(
                          'assets/images/payment/mastercard.png'),
                      circularPaymentAvatar('assets/images/payment/paypal.png'),
                      circularPaymentAvatar('assets/images/payment/paypal.png'),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  'Card Number',
                  style: kBody1Black,
                ),
                SizedBox(height: Get.height * 0.01),
                creditCardForm(),
                SizedBox(height: Get.height * 0.02),
                ConstantButton(
                    buttonText: 'Proceed to pay \$ _ _ _',
                    onTap: () => Get.to(() => const PaymentVerifiedScreen())),
                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: kBody1MediumBlue,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circularPaymentAvatar(String image) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: Get.height * 0.07,
      width: Get.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Image.asset(image),
      ),
    );
  }

  Widget creditCardForm() {
    return CreditCardForm(
      controller: cardController,
      theme: CreditCardLightTheme(),
      onChanged: (CreditCardResult result) {
        //  print(result.cardNumber);
        //  print(result.cardHolderName);
        //  print(result.expirationMonth);
        //  print(result.expirationYear);
        //  print(result.cardType);
        //  print(result.cvc);
      },
    );
  }
}
