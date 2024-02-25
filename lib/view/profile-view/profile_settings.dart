import 'package:catch_case/constant-widgets/constant_appbar.dart';
import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constant-widgets/constant_textfield.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ConstantAppBar(text: 'Profile Settings'),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.03, horizontal: Get.width * 0.04),
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 35.r,
                      backgroundImage:
                          const AssetImage('assets/images/home/person.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: kButtonColor, shape: BoxShape.circle),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20.r,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              ConstantTextField(
                controller: nameController,
                hintText: '',
                prefixIcon: Icons.person_pin,
                suffixIcon: Icons.edit,
                onTapSuffixIcon: () {},
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ConstantTextField(
                controller: emailController,
                hintText: '',
                prefixIcon: Icons.email,
                suffixIcon: Icons.edit,
                onTapSuffixIcon: () {},
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ConstantTextField(
                controller: passwordController,
                hintText: '',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.edit,
                onTapSuffixIcon: () {},
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              ConstantButton(buttonText: 'Update', onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
