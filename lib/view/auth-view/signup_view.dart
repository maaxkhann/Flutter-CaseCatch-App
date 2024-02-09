import 'package:catch_case/constant-widgets/constant_button.dart';
import 'package:catch_case/constant-widgets/constant_textfield.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/auth-view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
    ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
    ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          child: ListView(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
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
                'Sign Up',
                style: kHead2Black,
              ),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Text(
                'Name',
                style: kBody1Black,
              ),
              const ConstantTextField(
                hintText: 'Name',
                prefixIcon: Icons.email,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'Email',
                style: kBody1Black,
              ),
              const ConstantTextField(
                hintText: 'Email',
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
                      hintText: 'Password',
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
              Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: isChecked,
                      builder: ((context, value, child) {
                        return Checkbox(
                            value: isChecked.value,
                            onChanged: (value) {
                              isChecked.value = value!;
                            });
                      })),
                  Text(
                    'Remember me',
                    style: kBody4Dark,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ConstantButton(buttonText: 'Sign Up', onTap: () {}),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: Get.width * 0.02,
                      thickness: 0.5,
                      color: kBlack,
                    ),
                  ),
                  Text(
                    'OR',
                    style: kBody4Dark,
                  ),
                  Expanded(
                    child: Divider(
                      indent: Get.width * 0.02,
                      thickness: 0.5,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: Text(
                  'Sign In using',
                  style: kBody4DarkBlue,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/intro-auth/google.png'),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Image.asset('assets/images/intro-auth/facebook.png')
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
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
