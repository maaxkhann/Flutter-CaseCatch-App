import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:catch_case/view/lawyers-view/widgets/lawyers_button.dart';
import 'package:catch_case/view/profile-view/profile_settings.dart';
import 'package:catch_case/view/profile-view/reminders_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
            padding:
                EdgeInsets.only(left: Get.width * 0.06, top: Get.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adithi Nagaraj',
                      style: kBody1MediumBlue,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      Icons.edit,
                      color: kMediumBlue,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                ReUsableRow(
                  text: 'Profile settings',
                  icon: Icons.person_pin,
                  onTap: () => Get.to(() => const ProfileSettings()),
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
                        onTap: () {}))
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
