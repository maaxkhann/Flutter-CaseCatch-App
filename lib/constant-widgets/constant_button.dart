import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const ConstantButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Get.height * 0.065,
        decoration: BoxDecoration(
            color: kButtonColor,
            borderRadius: BorderRadius.circular(Get.width * 0.02)),
        child: Center(
          child: Text(
            buttonText,
            style: kBody22LightBlue,
          ),
        ),
      ),
    );
  }
}
