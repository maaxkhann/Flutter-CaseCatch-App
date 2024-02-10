import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const ChatAppBar({
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
        text,
        style: kBody1White,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Get.width * 0.02),
          child: CircleAvatar(
            radius: 18.r,
            backgroundImage: const AssetImage(
              'assets/images/lawyer/lawyer.png',
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Get.height * 0.08);
}
