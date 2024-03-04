import 'package:catch_case/user_panel/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/view/lawyers-view/widgets/confirmbooking_appbar.dart';
import 'package:catch_case/user_panel/view/notification-view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/textstyles.dart';

class PaymentVerifiedScreen extends StatefulWidget {
  const PaymentVerifiedScreen({super.key});

  @override
  State<PaymentVerifiedScreen> createState() => _PaymentVerifiedScreenState();
}

class _PaymentVerifiedScreenState extends State<PaymentVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConfirmBookingAppBar(text: 'Catch', text2: 'Case'),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                SvgPicture.asset('assets/images/lawyer/payment_done.svg'),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Payment Successful',
                  style: kBody1Black2,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'Your payment is successful check your notifications to know more about appointment ',
                      style: kBody4Blue2,
                    )),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: ConstantButton(
                      buttonText: 'Go to Notifications',
                      onTap: () => Get.to(() => const NotificationView())),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Back to search',
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
}
