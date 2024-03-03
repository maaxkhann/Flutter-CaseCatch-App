import 'package:catch_case/view/home-view/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantTextField2 extends StatelessWidget {
  final IconData prefixIcon;
  final IconData suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const ConstantTextField2({
    Key? key,
    required this.prefixIcon,
    required this.suffixIcon,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: const Color(0xFFCFCFCF)),
        suffixIcon: InkWell(
          onTap: () => Get.to(() => const FilterScreen()),
          child: Icon(
            suffixIcon,
            color: const Color(0xFFCFCFCF),
          ),
        ),
        hintText: 'Search for lawyers',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.02),
          borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.02),
          borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
        ),
      ),
    );
  }
}
