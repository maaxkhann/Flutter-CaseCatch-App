import 'dart:io';

import 'package:catch_case/lawyer_panel/controllers/auth_controller.dart';
import 'package:catch_case/lawyer_panel/controllers/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/primary_textfield.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  LawyerAuthController authController = Get.put(LawyerAuthController());

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  LawyerProfileController profileController = Get.put(LawyerProfileController());

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
        emailController.text = userData['email'] ?? '';
        contactController.text = userData['contact'] ?? '';
        addressController.text = userData['address'] ?? '';
        experienceController.text = userData['experience'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => profileController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        14.heightBox,
                        Row(
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
                            SizedBox(width: Get.width * .19),
                            const Text(
                              'Account Setting',
                              style: TextStyle(
                                color: Color(0xFF1A1A1A),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            StreamBuilder(
                                stream: profileController.allLawyers(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return Column(
                                      children: snapshot.data?.docs.map((e) {
                                            return Column(
                                              children: [
                                                e["lawyerId"] ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                    ? Column(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: 70,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          111),
                                                              child: profileController
                                                                          .image ==
                                                                      null
                                                                  ? e["lawyerId"] ==
                                                                          ''
                                                                      ? const Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              35,
                                                                        )
                                                                      : Image.network(
                                                                          e['image'],
                                                                          fit: BoxFit.cover)
                                                                  : Image.file(
                                                                      File(profileController
                                                                              .image!
                                                                              .path)
                                                                          .absolute,
                                                                      fit: BoxFit
                                                                          .cover,
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
                            10.widthBox,
                            Container(
                              padding: const EdgeInsets.only(left: 11),
                              width: Get.width * .56,
                              height: 36,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
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
                                  const Text(
                                    'Change Profile Picture',
                                    style: TextStyle(
                                      color: Color(0xFF0C253F),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
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
                        Container(
                          width: Get.size.width,
                          height: 41,
                          padding: const EdgeInsets.only(left: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE6F7E6),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFE2E2E2)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              const Text(
                                'You passed the KYC test',
                                style: TextStyle(
                                  color: Color(0xFF05AE03),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.heightBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              ' Name',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryTextField(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                controller: nameController,
                                text: 'Enter your name'),
                            10.heightBox,
                            const Text(
                              'Email',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryTextField(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                controller: emailController,
                                text: 'Enter your email'),
                            10.heightBox,
                            const Text(
                              'Contact',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryTextField(
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                controller: contactController,
                                text: 'Enter your contact'),
                            10.heightBox,
                            const Text(
                              'Address',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryTextField(
                                prefixIcon: const Icon(
                                  Icons.location_pin,
                                  color: Colors.black,
                                ),
                                controller: addressController,
                                text: 'Enter your address'),
                            10.heightBox,
                            const Text(
                              'Practicing years',
                              style: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            PrimaryTextField(
                                prefixIcon: const Icon(
                                  Icons.numbers,
                                  color: Colors.black,
                                ),
                                controller: experienceController,
                                text: 'Enter your Experience'),
                          ],
                        ),
                        44.heightBox,
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              updateAccount();
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Save Changes',
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
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void updateAccount() async {
    EasyLoading.show(status: 'Processing');
    try {
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'email': emailController.text,
        'name': nameController.text,
        'contact': contactController.text,
        'address': addressController.text,
        'experience': experienceController.text,
      });
      EasyLoading.dismiss();
      Get.snackbar('Success', 'Your Information updated ');
    } catch (e) {
      EasyLoading.dismiss();

      Get.snackbar('Error', e.toString());
    }
  }
}
