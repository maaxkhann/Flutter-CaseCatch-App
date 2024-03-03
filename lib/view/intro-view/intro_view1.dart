import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/intro-view/intro_view2.dart';
import 'package:catch_case/view/select_user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroView1 extends StatelessWidget {
  const IntroView1({super.key});

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
                  'search for a lawyer',
                  style: kHead2White,
                ),
                Text(
                  'Search for a lawyer, know more about his work experience and his area of practice.',
                  style: kBody4White,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.18,
                ),
                ConstantButton(
                  buttonText: 'Next',
                  onTap: () => Get.to(() => const IntroView2()),
                ),
                TextButton(
                    onPressed: () => Get.offAll(() => const SelectUserView()),
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
                'assets/images/intro-auth/intro1.png',
                width: Get.width * 0.6,
                height: Get.height * 0.35,
              ),
            ),
          )
        ],
      )),
    );
  }
}
