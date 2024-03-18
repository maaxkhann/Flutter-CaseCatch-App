import 'dart:io';

import 'package:catch_case/lawyer_panel/authentication/lawyer_login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LawyerProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController passwordController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>> allLawyers() {
    return FirebaseFirestore.instance.collection('lawyers').snapshots();
  }

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryimage() async {
    isLoading.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      //   uploadProfilePicture();

      isLoading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'No image selected');
    }
    isLoading.value = false;
  }

  Future pickCameraimage() async {
    isLoading.value = true;

    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      //  uploadProfilePicture();

      isLoading.value = false;
    } else {
      Fluttertoast.showToast(msg: 'No image selected');
    }
    isLoading.value = false;
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 100.h,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraimage();
                    Get.back();
                  },
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                  ),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryimage();

                    Get.back();
                  },
                  leading: const Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                  title: const Text('Gallery'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadProfilePicture() async {
    isLoading.value = true;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage
          .ref('profile_images/${FirebaseAuth.instance.currentUser!.uid}/');
      await ref.putFile(File(image!.path).absolute);
      String imageUrl = await ref.getDownloadURL();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'image': imageUrl.toString()}).then((value) {
        isLoading.value = false;
        _image = null;
      });
      isLoading.value = false;

      return imageUrl;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }

    return '';
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LawyerLoginView());
  }

  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    EasyLoading.show(status: 'Processing');
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);

      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'password': newPassword});
      Get.snackbar('Success', 'Password updated ');

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', e.toString());
    }
  }

  Future<String> uploadProfile(
    String email,
    String fileName,
    String filePath,
  ) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref('$email/').child(fileName);
      await ref.putFile(File(filePath));
      String imageUrl = await ref.getDownloadURL();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
      return imageUrl;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return '';
  }
}
