import 'package:catch_case/lawyer_panel/authentication/lawyer_login_view.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/auth-view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectUserView extends StatelessWidget {
  const SelectUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Select Category',
                    style: kHead2Black,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const LawyerLoginView()),
                  child: Container(
                    width: Get.width * 0.5,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Center(
                        child: Text(
                      'Lawyer',
                      style: kBody1White,
                    )),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const LoginView()),
                  child: Container(
                    width: Get.width * 0.5,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Center(
                        child: Text(
                      'Customer',
                      style: kBody1White,
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
