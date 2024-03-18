import 'dart:io';

import 'package:catch_case/constant-widgets/constant_textfield.dart';
import 'package:catch_case/user_panel/constants/colors.dart';
import 'package:catch_case/user_panel/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant-widgets/constant_button.dart';
import '../../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();

  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        nameController.text = userData['username'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Update Profile',
          style: kHead2White,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kWhite,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            children: [
              StreamBuilder(
                  stream: profileController.allUsers(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return Column(
                        children: snapshot.data?.docs.map((e) {
                              return Column(
                                children: [
                                  e["userId"] ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                Container(
                                                  height: 60.h,
                                                  width: 70.w,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            111.r),
                                                    child: profileController
                                                                .image ==
                                                            null
                                                        ? e["userId"] == ''
                                                            ? const Icon(
                                                                Icons.person,
                                                                size: 35,
                                                              )
                                                            : Image.network(
                                                                e['image'],
                                                                fit: BoxFit
                                                                    .cover)
                                                        : Image.file(
                                                            File(profileController
                                                                    .image!
                                                                    .path)
                                                                .absolute,
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 2,
                                                  bottom: 1,
                                                  child: CircleAvatar(
                                                    radius: 15.r,
                                                    backgroundColor:
                                                        Colors.blue.shade300,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          profileController
                                                              .pickImage(
                                                                  context);
                                                        },
                                                        icon: const Icon(
                                                          Icons.camera_alt,
                                                          color: kWhite,
                                                          size: 16,
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(e['username'],
                                                style: kBody1DarkBlue),
                                            Text(e['email'], style: kBody3Grey),
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              );
                            }).toList() ??
                            []);
                  }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Name', style: kBody1Black),
                  const SizedBox(
                    height: 4,
                  ),
                  ConstantTextField(
                      controller: nameController,
                      hintText: 'Enter Name',
                      prefixIcon: Icons.person),
                ],
              ),
              SizedBox(
                height: Get.height * .1,
              ),
              ConstantButton(
                  buttonText: 'Update',
                  onTap: () {
                    updateUserInfo();
                  })
            ],
          ),
        ),
      ),
    );
  }

  void updateUserInfo() async {
    try {
      EasyLoading.show(status: 'Processing');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'username': nameController.text,
      });
      profileController.uploadProfilePicture();
      Get.snackbar('Success', 'User information updated successfully');
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();

      Get.snackbar('Error', error.toString());
    }
  }
}
