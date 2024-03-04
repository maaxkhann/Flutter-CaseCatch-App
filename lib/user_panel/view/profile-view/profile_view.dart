import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:catch_case/user_panel/view/lawyers-view/widgets/lawyers_button.dart';
import 'package:catch_case/user_panel/view/profile-view/edit_profile_screen.dart';
import 'package:catch_case/user_panel/view/profile-view/reminders_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

ProfileController profileController = Get.put(ProfileController());

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kButtonColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Profile',
            style: kBody1White,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .03,
                ),
                Center(
                  child: StreamBuilder(
                      stream: profileController.allUsers(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return Column(
                            children: snapshot.data?.docs.map((e) {
                                  return Column(
                                    children: [
                                      e["userId"] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? Column(
                                              children: [
                                                Container(
                                                  height: 99,
                                                  width: 99,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              111),
                                                      child: e["userId"] == ''
                                                          ? const Icon(
                                                              Icons.person,
                                                              size: 35,
                                                            )
                                                          : Image.network(
                                                              e['image'],
                                                              fit: BoxFit
                                                                  .cover)),
                                                ),
                                                Text(
                                                  e['username'],
                                                  style: const TextStyle(
                                                    color: Color(0xFF494949),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  e['email'],
                                                  style: const TextStyle(
                                                    color: Color(0xFF494949),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  );
                                }).toList() ??
                                []);
                      }),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Divider(),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'Profile settings',
                  icon: Icons.person_pin,
                  onTap: () => Get.to(() => const UpdateUserInfoScreen()),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'Reminders',
                  icon: Icons.notification_add,
                  onTap: () => Get.to(() => const RemindersView()),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'Bank details',
                  icon: Icons.food_bank,
                  onTap: () {},
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'Rate a lawyer',
                  icon: Icons.star,
                  onTap: () {},
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'History',
                  icon: Icons.history,
                  onTap: () {},
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'Help',
                  icon: Icons.help,
                  onTap: () {},
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                ReUsableRow(
                  text: 'About',
                  icon: Icons.report,
                  onTap: () {},
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Center(
                    child: LawyersButton(
                        buttonText: 'Logout',
                        buttonColor: kButtonColor,
                        onTap: () { showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: const Text(
                                                            "Are you sure ?"),
                                                        content: const Text(
                                                            "Click Confirm if you want to Log out of the app"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Cancel")),
                                                          TextButton(
                                                              onPressed: () {
                                                                profileController
                                                                    .logOut();

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                "Confirm",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ))
                                                        ],
                                                      ));}))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  final String text;

  final IconData icon;
  final VoidCallback onTap;
  const ReUsableRow(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          DecoratedIcon(
            icon: Icon(
              icon,
              color: kWhite,
            ),
            decoration: IconDecoration(
                border: IconBorder(color: kButtonColor, width: 3.r)),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Text(
            text,
            style: kBody2DarkBlue,
          )
        ],
      ),
    );
  }
}
