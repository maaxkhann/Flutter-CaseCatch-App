import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/widgets/confirmbooking_appbar.dart';
import 'package:catch_case/view/notification-view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ConfirmBookingView extends StatelessWidget {
  const ConfirmBookingView({super.key});

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
                  height: Get.height * 0.08,
                ),
                SvgPicture.asset('assets/images/lawyer/payment_done.svg'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Congratulations',
                  style: kBody1Black2,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Your appointment booking is successful with ',
                        style: kBody4Blue2,
                        children: [
                          TextSpan(text: 'Rako Christian.', style: kBody4Black)
                        ])),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Your booking ID is',
                        style: kBody4Black,
                        children: [
                          TextSpan(text: '#98345.', style: kBody4Blue2)
                        ])),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: ConstantButton(
                      buttonText: 'Remind me',
                      onTap: () => Get.to(() => const NotificationView())),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Add to calender',
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
