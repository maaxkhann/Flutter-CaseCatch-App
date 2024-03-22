import 'dart:io';

import 'package:catch_case/lawyer_panel/controllers/lawyer_auth_controller.dart';
import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constant-widgets/constant_textfield.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'lawyer_login_view.dart';

class LawyerSignUpView extends StatefulWidget {
  const LawyerSignUpView({super.key});

  @override
  State<LawyerSignUpView> createState() => _DataScreenState();
}

class _DataScreenState extends State<LawyerSignUpView> {
  String imageaddress = "";
  String imagetoUpload = "";
  String imageUploaded = "";

  final practices = <String>[
    'Family matters',
    'Corporate buisness',
    'Immigration case',
    'Tax case'
  ];
  final _categories = <String>[
    'Criminal',
    'Family',
    'Labour',
    'Divorce',
    'Civil',
    'Military',
  ];
  String loadingMessage = "Registring User";

  String? _category;
  String? _practice;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  LawyerAuthController authController = Get.put(LawyerAuthController());
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  LawyerProfileController profileController =
      Get.put(LawyerProfileController());

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactController.dispose();
    specialController.dispose();
    experienceController.dispose();
    bioController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04,
              vertical: Get.height * 0.02,
            ),
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
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Text(
                  'Sign Up As Lawyer',
                  style: kHead2Black,
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Center(
                  child: Obx(
                    () => authController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GestureDetector(
                            onTap: () async {
                              authController.pickImage(context);
                            },
                            child: authController.image == null
                                ? CircleAvatar(
                                    radius: 40.r,
                                    backgroundImage: const AssetImage(
                                        'assets/images/home/download.png'))
                                : CircleAvatar(
                                    radius: 40.r,
                                    backgroundImage: FileImage(
                                        File(authController.image!.path)),
                                  )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Name',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: nameController,
                  hintText: 'Enter Name',
                  prefixIcon: Icons.person,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Email',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: emailController,
                  hintText: 'Enter Email',
                  prefixIcon: Icons.email,
                ),
                SizedBox(
                  height: 10.h,
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
                        hintText: 'Enter Password',
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
                  height: 10.h,
                ),
                Text(
                  'Contact',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: contactController,
                  hintText: 'Enter Contact Number',
                  prefixIcon: Icons.call,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Address',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: addressController,
                  hintText: 'Enter Address',
                  prefixIcon: Icons.location_city,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Specialization',
                  style: kBody1Black,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.r),
                    filled: true,
                    fillColor: const Color(0xffEEEEEE),
                    prefixIcon: const Icon(Icons.category, color: Colors.black),
                    hintText: 'Select Specialization',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                    ),
                  ),
                  value: _category,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                  items: _categories
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Practice Area',
                  style: kBody1Black,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.r),
                    filled: true,
                    fillColor: const Color(0xffEEEEEE),
                    prefixIcon: const Icon(Icons.category, color: Colors.black),
                    hintText: 'Select Practice Area',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Get.width * 0.02),
                      borderSide: const BorderSide(color: Color(0xFFA7A7A7)),
                    ),
                  ),
                  value: _practice,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a practice area';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _practice = value;
                    });
                  },
                  items: practices
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text('Experience', style: kBody1Black),
                ConstantTextField(
                  controller: experienceController,
                  hintText: 'Enter Experience',
                  prefixIcon: Icons.numbers,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'About',
                  style: kBody1Black,
                ),
                ConstantTextField(
                  controller: bioController,
                  hintText: 'Enter Bio',
                  prefixIcon: Icons.person_pin,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ConstantButton(
                    buttonText: 'Create Account',
                    onTap: () async {
                      try {
                        String name = nameController.text.trim();
                        String email = emailController.text.trim();
                        String contact = contactController.text.trim();
                        String address = addressController.text.trim();
                        String password = passwordController.text.trim();
                        String bio = bioController.text.trim();
                        String experience = experienceController.text.trim();
                        if (authController.image == null) {
                          Fluttertoast.showToast(
                              msg: 'Please upload profile picture');
                          return;
                        }

                        if (name.isEmpty ||
                            email.isEmpty ||
                            address.isEmpty ||
                            contact.isEmpty ||
                            _category == null ||
                            _practice == null ||
                            experience.isEmpty ||
                            bio.isEmpty ||
                            password.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Please enter all details');
                        } else {
                          profileController
                              .uploadProfile(email, email, imagetoUpload)
                              .then((value) => imagetoUpload = value);

                          await authController.signUpMethod(
                            name: name,
                            email: email,
                            password: password,
                            contact: contact,
                            address: address,
                            category: _category.toString(),
                            practice: _practice.toString(),
                            experience: experience,
                            bio: bio,
                          );
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: 'Something went wrong');
                      }
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: kBody2DarkBlue,
                    ),
                    TextButton(
                        onPressed: () => Get.off(() => const LawyerLoginView()),
                        child: Text(
                          'Login',
                          style: kBody2MediumBlue,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
