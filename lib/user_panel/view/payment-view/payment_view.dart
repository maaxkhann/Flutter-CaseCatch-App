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



// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   CreditCardController cardController = CreditCardController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const ConstantAppBar(
//           text: 'Payment',
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: Get.height * 0.02),
//                 Text(
//                   'Choose a payment',
//                   style: kBody1Black,
//                 ),
//                 SizedBox(height: Get.height * 0.01),
//                 FittedBox(
//                   child: Row(
//                     children: [
//                       circularPaymentAvatar('assets/images/payment/paypal.png'),
//                       circularPaymentAvatar('assets/images/payment/visa.png'),
//                       circularPaymentAvatar(
//                           'assets/images/payment/mastercard.png'),
//                       circularPaymentAvatar('assets/images/payment/paypal.png'),
//                       circularPaymentAvatar('assets/images/payment/paypal.png'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Get.height * 0.02),
//                 Text(
//                   'Card Number',
//                   style: kBody1Black,
//                 ),
//                 SizedBox(height: Get.height * 0.01),
//                 creditCardForm(),
//                 SizedBox(height: Get.height * 0.02),
//                 ConstantButton(
//                     buttonText: 'Proceed to pay \$ _ _ _',
//                     onTap: () => Get.to(() => const PaymentVerifiedScreen())),
//                 Center(
//                   child: TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Cancel',
//                         style: kBody1MediumBlue,
//                       )),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget circularPaymentAvatar(String image) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       height: Get.height * 0.07,
//       width: Get.height * 0.07,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Center(
//         child: Image.asset(image),
//       ),
//     );
//   }

//   Widget creditCardForm() {
//     return CreditCardForm(
//       controller: cardController,
//       theme: CreditCardLightTheme(),
//       onChanged: (CreditCardResult result) {
//         //  print(result.cardNumber);
//         //  print(result.cardHolderName);
//         //  print(result.expirationMonth);
//         //  print(result.expirationYear);
//         //  print(result.cardType);
//         //  print(result.cvc);
//       },
//     );
//   }
// }

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   bool isPaying = false;

//   Future<void> payWithCard({required double amount}) async {
//     setState(() {
//       isPaying = true;
//     });

//     try {
//       // Create Payment Intent on your server
//       final paymentIntentData = await createPaymentIntent(amount, 'USD');
//       // Confirm Payment Intent
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: paymentIntentData['client_secret'],
//         merchantDisplayName: 'Your Company Name',
//       ));
//       await Stripe.instance.presentPaymentSheet();

//       setState(() {
//         isPaying = false;
//       });
//       // Handle payment success
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment successful")));
//     } catch (e) {
//       setState(() {
//         isPaying = false;
//       });
//       // Handle payment failure
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment failed: $e")));
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
//     final url = Uri.parse('https://your-server.com/create-payment-intent');
//     final response = await http.post(url, body: {
//       'amount': amount.toString(),
//       'currency': currency,
//     });
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//       ),
//       body: Center(
//         child: isPaying
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 child: const Text('Pay'),
//                 onPressed: () => payWithCard(amount: 10.0), // Example amount
//               ),));
//   }
// }