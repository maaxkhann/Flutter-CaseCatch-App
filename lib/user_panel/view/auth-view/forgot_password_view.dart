import 'package:catch_case/user_panel/constant-widgets/constant_button.dart';
import 'package:catch_case/user_panel/constant-widgets/constant_textfield.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/auth-view/verify_otp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                height: Get.height * 0.03,
              ),
              Center(
                  child: Text(
                'Forgot password',
                style: kBody1DarkBlue,
              )),
              Text(
                'Type your email and we shall send you a verification code to your account to reset password.',
                style: kBody4Blue2,
                textAlign: TextAlign.center,
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
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              ConstantButton(
                  buttonText: 'Get OTP',
                  onTap: () {
                    Get.to(() => const VerifyOtpView());
                  })
            ],
          ),
        ),
      ),
    );
  }
}