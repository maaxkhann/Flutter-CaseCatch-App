import 'dart:io';

import 'package:catch_case/user_panel/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/constant-widgets/constant_textfield.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/controllers/auth_controller.dart';
import 'package:catch_case/user_panel/view/auth-view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04,
            vertical: Get.height * 0.02,
          ),
          child: ListView(
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
                height: Get.height * 0.02,
              ),
              Text(
                'Sign Up As User',
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
                                )
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(60),
                          //       border: Border.all(color: Colors.black12),
                          //       color: const Color.fromARGB(255, 231, 231, 231),
                          //       image: authController.image == null
                          //           ? const DecorationImage(
                          //               image: AssetImage(
                          //                   'assets/images/home/download.png'))
                          //           : DecorationImage(
                          //               image: FileImage(
                          //                 File(authController.image!.path)
                          //                     .absolute,
                          //               ),
                          //               fit: BoxFit.cover)),
                          // ),
                          ),
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
                hintText: 'Enter Email',
                prefixIcon: Icons.email,
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
                height: Get.height * 0.02,
              ),
              Text(
                'Confirm Password',
                style: kBody1Black,
              ),
              ValueListenableBuilder(
                  valueListenable: isConfirmPasswordVisible,
                  builder: (ctx, value, child) {
                    return ConstantTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: !isConfirmPasswordVisible.value,
                      prefixIcon: Icons.lock,
                      suffixIcon: value == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onTapSuffixIcon: () {
                        isConfirmPasswordVisible.value =
                            !isConfirmPasswordVisible.value;
                      },
                    );
                  }),
              // Row(
              //   children: [
              //     ValueListenableBuilder(
              //         valueListenable: isChecked,
              //         builder: ((context, value, child) {
              //           return Checkbox(
              //               value: isChecked.value,
              //               onChanged: (value) {
              //                 isChecked.value = value!;
              //               });
              //         })),
              //     Text(
              //       'Remember me',
              //       style: kBody4Dark,
              //     ),
              //   ],
              // ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              ConstantButton(
                  buttonText: 'Sign Up',
                  onTap: () {
                    String name = nameController.text.trim();
                    String email = emailController.text.trim();

                    String password = passwordController.text.trim();
                    authController.createUser(
                        email: email,
                        name: name,
                        password: password,
                        context: context);
                  }),
              // SizedBox(
              //   height: Get.height * 0.01,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: Divider(
              //         endIndent: Get.width * 0.02,
              //         thickness: 0.5,
              //         color: kBlack,
              //       ),
              //     ),
              //     Text(
              //       'OR',
              //       style: kBody4Dark,
              //     ),
              //     Expanded(
              //       child: Divider(
              //         indent: Get.width * 0.02,
              //         thickness: 0.5,
              //         color: kBlack,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              // Center(
              //   child: Text(
              //     'Sign In using',
              //     style: kBody4DarkBlue,
              //   ),
              // ),
              // SizedBox(
              //   height: Get.height * 0.01,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset('assets/images/intro-auth/google.png'),
              //     SizedBox(
              //       width: Get.width * 0.02,
              //     ),
              //     Image.asset('assets/images/intro-auth/facebook.png')
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: kBody2DarkBlue,
                  ),
                  TextButton(
                      onPressed: () => Get.off(() => const LoginView()),
                      child: Text(
                        'Login',
                        style: kBody2MediumBlue,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
