import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/intro-view/intro_view3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroView2 extends StatelessWidget {
  const IntroView2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            width: double.infinity,
            height: Get.height * 0.7,
            decoration: BoxDecoration(
                color: const Color(0xFF0C253F),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Get.width * 0.08),
                    topRight: Radius.circular(Get.width * 0.08))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width * 0.04,
                      height: Get.height * 0.02,
                      decoration: const BoxDecoration(
                          color: kWhite, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      width: Get.width * 0.08,
                      height: Get.height * 0.015,
                      decoration: BoxDecoration(
                          color: const Color(0xFF75B1CE),
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.02)),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      width: Get.width * 0.04,
                      height: Get.height * 0.02,
                      decoration: const BoxDecoration(
                          color: kWhite, shape: BoxShape.circle),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.072,
                ),
                Text(
                  'Book an appointment',
                  style: kHead2White,
                ),
                Text(
                  'After knowing about lawyer’s work now it’s time to book an appointment with the lawyer and select the date and time as per your convenience, and enable the notification to set the reminder.',
                  style: kBody4White,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.18,
                ),
                ConstantButton(
                  buttonText: 'Next',
                  onTap: () => Get.to(() => const IntroView3()),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Skip',
                      style: kBody1MediumBlue,
                    ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.09),
              child: Image.asset(
                'assets/images/intro-auth/intro2.png',
              ),
            ),
          )
        ],
      )),
    );
  }
}
