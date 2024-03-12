import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/auth_controller.dart';
import '../widgets/primary_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  LawyerAuthController authController = Get.put(LawyerAuthController());
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const Color defaultButtonColor = Colors.amber;
    const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * .2),
                  const Text(
                    'Forgot Password ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: Get.height * .12,
                ),
                const Text(
                  'Reset your password',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 32,
                    fontFamily: 'Switzer',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.heightBox,
                const Padding(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    "Don't worry if you forgot your Password, we have a solution for you, Just enter your assosiated email here to get a password reset link",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF828A89),
                      fontSize: 16,
                      fontFamily: 'Switzer',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                20.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontFamily: 'Switzer',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                      controller: emailController,
                      text: 'Enter your email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    40.heightBox,
                    Center(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              if (emailController.text.isEmpty) {
                                Get.snackbar('Error', 'Enter your email');
                              } else {
                                await authController
                                    .resetmypassword(emailController.text);
                              }
                            },
                            child: Container(
                              height: 50,
                              width: 349 * 12,
                              decoration: BoxDecoration(
                                color: loading
                                    ? loadingButtonColor
                                    : defaultButtonColor,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Visibility(
                                  visible: !loading,
                                  child: Text(
                                    'Reset',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (loading)
                            const Positioned.fill(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
