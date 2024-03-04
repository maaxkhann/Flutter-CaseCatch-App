import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final String text2;
  const HomeAppBar({
    super.key,
    required this.text,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kButtonColor,
      centerTitle: true,
      title: RichText(
          text: TextSpan(
              text: text,
              style: kHead1DarkBlue,
              children: [TextSpan(text: text2, style: kHead1White)])),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Get.height * 0.08);
}
