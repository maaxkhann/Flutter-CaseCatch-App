import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constant-widgets/constant_textfield.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyer/lawyer_registration_view2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LawyerRegistrationView extends StatefulWidget {
  const LawyerRegistrationView({super.key});

  @override
  State<LawyerRegistrationView> createState() => _LawyerRegistrationViewState();
}

class _LawyerRegistrationViewState extends State<LawyerRegistrationView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final experianceController = TextEditingController();
  final priceController = TextEditingController();
  final bioController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    experianceController.dispose();
    priceController.dispose();
    bioController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: RichText(
                      text: TextSpan(
                          text: 'Catch',
                          style: kHead1DarkBlue,
                          children: [
                        TextSpan(text: 'Case', style: kHead1MediumBlue)
                      ])),
                ),
                Center(
                  child: Text(
                    'Register yourself as Lawyer',
                    style: kHead2Black,
                    maxLines: 2,
                  ),
                ),
                Center(
                  child: Text(
                    '1/2',
                    style: kBody1Black,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Text(
                  'Name',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: nameController,
                  hintText: 'Name*',
                  prefixIcon: Icons.email,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Email',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: emailController,
                  hintText: 'Email*',
                  prefixIcon: Icons.email,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Location',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: locationController,
                  hintText: 'Location*',
                  prefixIcon: Icons.location_city,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Experience',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: experianceController,
                  hintText: 'Experience in years*',
                  prefixIcon: Icons.percent,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Price',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: priceController,
                  hintText: 'Price per day',
                  prefixIcon: Icons.currency_rupee_sharp,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Biography',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: bioController,
                  hintText: 'Biography*',
                  prefixIcon: Icons.biotech,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Password',
                  style: kBody1Black,
                ),
                ValueListenableBuilder(
                    valueListenable: isPasswordVisible,
                    builder: (ctx, value, child) {
                      return ConstantTextField(
                        controller: passwordController,
                        hintText: 'Password*',
                        obscureText: !isPasswordVisible.value,
                        prefixIcon: Icons.lock,
                        suffixIcon: value == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onTapSuffixIcon: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      );
                    }),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ConstantButton(
                    buttonText: 'Next',
                    onTap: () => Get.to(() => const LawyerRegistrationView2()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
