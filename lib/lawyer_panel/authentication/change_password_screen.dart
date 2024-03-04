import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/primary_textfield.dart';

class ChanePasswordScreen extends StatefulWidget {
  const ChanePasswordScreen({super.key});

  @override
  State<ChanePasswordScreen> createState() => _ChanePasswordScreenState();
}

class _ChanePasswordScreenState extends State<ChanePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  LawyerProfileController profileController = Get.put(LawyerProfileController());
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // const Color defaultButtonColor = Colors.amber;
    // const Color loadingButtonColor = Colors.grey;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
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
                36.heightBox,
                const Text(
                  'Welcome to Lawyer',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'Change password',
                  style: TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                36.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Old Password',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                      controller: oldPasswordController,
                      text: 'Enter old password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        // color: Colors.black,
                      ),
                    ),
                    10.heightBox,
                    const Text(
                      'New Password',
                      style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryTextField(
                      controller: newPasswordController,
                      text: 'Enter new password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        // color: Colors.black,
                      ),
                    ),
                    77.heightBox,
                    Center(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: ()async {
                        //  await     profileController.updatePassword(
                        //           oldPassword: oldPasswordController.text,
                        //           newPassword: newPasswordController.text);
                            },
                            child: Container(
                              height: 50,
                              width: Get.size.width,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: const Center(
                                child: Text(
                                  'Set Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
