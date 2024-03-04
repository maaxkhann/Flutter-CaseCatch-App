import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyersButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? buttonColor;
  const LawyersButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        width: Get.width * 0.23,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
            color: buttonColor ?? kDarkBlue,
            borderRadius: BorderRadius.circular(Get.width * 0.02)),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Center(
            child: Text(
              buttonText,
              style: kBody22LightBlue,
            ),
          ),
        ),
      ),
    );
  }
}
