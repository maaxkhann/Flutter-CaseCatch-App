import 'package:catch_case/view/home-view/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantTextField2 extends StatelessWidget {
  final IconData prefixIcon;
  final IconData suffixIcon;
  final VoidCallback? onTapSuffixIcon;

  const ConstantTextField2({
    super.key,
    required this.prefixIcon,
    required this.suffixIcon,
    this.onTapSuffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: const Color(0xFFCFCFCF)),
          suffixIcon: InkWell(
            onTap: onTapSuffixIcon ?? () => Get.to(() => const FilterScreen()),
            child: Icon(
              suffixIcon,
              color: const Color(0xFFCFCFCF),
            ),
          ),
          hintText: 'Search for lawyers',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width * 0.02),
              borderSide: const BorderSide(color: Color(0xFFA7A7A7))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width * 0.02),
              borderSide: const BorderSide(color: Color(0xFFA7A7A7)))),
    );
  }
}
