import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool? isExpand;
  final VoidCallback? onTapSuffixIcon;
  final bool? obscureText;

  const ConstantTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.isExpand,
    this.onTapSuffixIcon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      expands: isExpand ?? false,
      maxLines: isExpand == true ? null : 1,
      obscureText: obscureText ?? false,
      keyboardType: hintText == 'Enter Email'
          ? TextInputType.emailAddress
          : hintText == 'Enter Contact Number'
              ? TextInputType.phone
              : hintText == 'Enter Experience'
                  ? TextInputType.number
                  : TextInputType.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
          ),
          prefixIcon: Icon(prefixIcon, color: const Color(0xFFCFCFCF)),
          suffixIcon: InkWell(
            onTap: onTapSuffixIcon,
            child: Icon(
              suffixIcon,
              color: const Color(0xFFCFCFCF),
            ),
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width * 0.02),
              borderSide: const BorderSide(color: Color(0xFFA7A7A7))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width * 0.02),
              borderSide: const BorderSide(color: Color(0xFFA7A7A7)))),
    );
  }
}
