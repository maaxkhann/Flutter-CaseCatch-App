import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/auth-view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroView3 extends StatelessWidget {
  const IntroView3({super.key});

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.16,
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
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.072,
                  ),
                  Text(
                    'Pay and proceed',
                    style: kHead2White,
                  ),
                  Text(
                    'After booking the date of appointment with the lawyer, the final step of this process is to  pay with any comfortable mode of payment and get confirmation.',
                    style: kBody4White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * 0.18,
                  ),
                  ConstantButton(
                    buttonText: 'Get Started',
                    onTap: () => Get.offAll(() => const LoginView()),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height * 0.09),
              child: Image.asset(
                'assets/images/intro-auth/intro3.png',
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
