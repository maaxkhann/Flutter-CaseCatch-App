import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyersCategory extends StatelessWidget {
  final String text;
  const LawyersCategory({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.02),
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      width: Get.width * 0.24,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
          color: const Color.fromARGB(137, 233, 225, 225),
          borderRadius: BorderRadius.circular(Get.width * 0.02)),
      child: Center(
        child: Text(
          text,
          style: kBody5Grey,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
