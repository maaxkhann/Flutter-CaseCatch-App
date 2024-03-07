// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../authentication/change_password_screen.dart';
import '../../controllers/profile_controller.dart';
import 'account_settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LawyerProfileController profileController = Get.put(LawyerProfileController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Obx(
            () => profileController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Navigator.pop(context);
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
                              SizedBox(width: Get.width * .3),
                              const Text(
                                'Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          22.heightBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              children: [
                                StreamBuilder(
                                    stream: profileController.allLawyers(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return Column(
                                          children:
                                              snapshot.data?.docs.map((e) {
                                                    return Column(
                                                      children: [
                                                        e["lawyerId"] ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid
                                                            ? Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            33,
                                                                        backgroundImage:
                                                                            NetworkImage(e['image']),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            12,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            e['name'],
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color(0xFF494949),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            e['email'],
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color(0xFF494949),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    );
                                                  }).toList() ??
                                                  []);
                                    }),
                                26.heightBox,
                                DecorateContainer(
                                  icon: Icons.settings,
                                  text: 'Account Settings',
                                  onTap: () {
                                    Get.to(() => const AccountSettings());
                                  },
                                ),
                               
                                10.heightBox,
                                DecorateContainer(
                                  icon: Icons.wallet,
                                  text: 'Change Password',
                                  onTap: () {
                                    Get.to(() => const ChanePasswordScreen());
                                  },
                                ),
                                10.heightBox,
                                DecorateContainer(
                                  icon: Icons.support,
                                  text: 'About',
                                  onTap: () {
                                    // Get.to(() => const AboutScreen());
                                  },
                                ),
                                55.heightBox,
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title:
                                                  const Text("Are you sure ?"),
                                              content: const Text(
                                                  "Click Confirm if you want to Log out of the app"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                                TextButton(
                                                    onPressed: () {
                                                      profileController
                                                          .logOut();

                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ))
                                              ],
                                            ));
                                  },
                                  child: Container(
                                    height: 49,
                                    width: Get.width * .86,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class DecorateContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const DecorateContainer({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.grey,
                ),
                20.widthBox,
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF0C253F),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
