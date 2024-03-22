import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const BookingAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kWhite,
          ),
        ),
        backgroundColor: kButtonColor,
        centerTitle: true,
        title: Text(
          'Lawyers',
          style: kBody1White,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Get.height * 0.08);
}
