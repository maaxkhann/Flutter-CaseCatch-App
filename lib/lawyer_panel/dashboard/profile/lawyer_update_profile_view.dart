import 'dart:io';

import 'package:catch_case/constant-widgets/constant_textfield.dart';
import 'package:catch_case/lawyer_panel/controllers/lawyer_auth_controller.dart';
import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:catch_case/constants/colors.dart';
import 'package:catch_case/constants/textstyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LawyerUpdateProfile extends StatefulWidget {
  const LawyerUpdateProfile({super.key});

  @override
  State<LawyerUpdateProfile> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<LawyerUpdateProfile> {
  LawyerAuthController authController = Get.put(LawyerAuthController());

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController experienceController = TextEditingController();
  LawyerProfileController profileController =
      Get.put(LawyerProfileController());

  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('lawyers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        nameController.text = userData['name'] ?? '';
        contactController.text = userData['contact'] ?? '';
        addressController.text = userData['address'] ?? '';
        experienceController.text = userData['experience'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StreamBuilder(
                        stream: profileController.allLawyers(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return Column(
                              children: snapshot.data?.docs.map((e) {
                                    return Column(
                                      children: [
                                        e["lawyerId"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                            ? Column(
                                                children: [
                                                  Container(
                                                    height: 60.h,
                                                    width: 70.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              111.r),
                                                      child: profileController
                                                                  .image ==
                                                              null
                                                          ? e["lawyerId"] == ''
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
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }).toList() ??
                                  []);
                        }),
                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.all(8.r),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: kWhite,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFE2E2E2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                profileController.pickImage(context);
                              },
                              child: const Icon(Icons.camera_alt)),
                          const SizedBox(width: 6),
                          Text('Change Profile Picture', style: kBody2DarkBlue),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Name', style: kBody1Black),
                    const SizedBox(
                      height: 4,
                    ),
                    ConstantTextField(
                        controller: nameController,
                        hintText: 'Enter Name',
                        prefixIcon: Icons.person),
                    SizedBox(height: 11.h),
                    Text('Contact', style: kBody1Black),
                    const SizedBox(
                      height: 4,
                    ),
                    ConstantTextField(
                        controller: contactController,
                        hintText: 'Enter Contact Number',
                        prefixIcon: Icons.call),
                    SizedBox(height: 11.h),
                    Text('Address', style: kBody1Black),
                    const SizedBox(
                      height: 4,
                    ),
                    ConstantTextField(
                        controller: addressController,
                        hintText: 'Enter Address',
                        prefixIcon: Icons.location_pin),
                    SizedBox(height: 11.h),
                    Text('Practicing years', style: kBody1Black),
                    const SizedBox(
                      height: 4,
                    ),
                    ConstantTextField(
                        controller: experienceController,
                        hintText: 'Enter Experience',
                        prefixIcon: Icons.numbers),
                    SizedBox(height: Get.height * 0.07),
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      updateAccount();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text('Save Changes',
                            textAlign: TextAlign.center, style: kBody1White),
                      ),
                    ),
                  ),
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

  void updateAccount() async {
    EasyLoading.show(status: 'Processing');
    try {
      profileController.uploadProfilePicture();
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'name': nameController.text,
        'contact': contactController.text,
        'address': addressController.text,
        'experience': experienceController.text,
      });
      profileController.uploadProfilePicture();
      EasyLoading.dismiss();
      Get.snackbar('Success', 'Your Information updated');
    } catch (e) {
      EasyLoading.dismiss();

      Get.snackbar('Error', e.toString());
    }
  }
}
