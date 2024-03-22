import 'dart:io';

import 'package:catch_case/user_panel/view/auth-view/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant-widgets/bottom_nav_bar.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  RxBool isLoading = false.obs;
  String updateImage = '';
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryimage() async {
    isLoading.value = true;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      //  uploadProfilePicture();
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
      //   uploadProfilePicture();

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

  //
  //
  Future<void> createUser({
    required String email,
    required String name,
    required String password,
  }) async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    String? token = await FirebaseMessaging.instance.getToken();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uploadImage = await uploadProfilePicture();

      if (userCredential.user != null) {
        await firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'email': email,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'image': uploadImage,
          'username': name,
          'fcmToken': token
        });
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Sign Up Successfully');
        Get.off(() => const LoginView());
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email already in use');
        return;
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password is weak');
        return;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Invalid Password');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Invalid Email');
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Login Successfully');
        Get.off(() => const BottomNavigationBarWidget());
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Email already in use');
        return;
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password is weak');
        return;
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Invalid Password');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Invalid Email');
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future<void> resetmypassword(String email) async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
      Get.snackbar('Success', 'Check your email for Password Reset Link');
      Get.back();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Failed', 'Something went wrong');
    }
  }

  // void loginWithEmail() async {
  //   isLoading.value = true;
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     await auth.signInWithCredential(credential);
  //     Get.snackbar('Success', 'Login Success');
  //     Get.to(() => const Dashboard());
  //   } catch (ex) {
  //     print(ex);
  //     Get.snackbar('Error', 'Please try again');
  //   }
  //   isLoading.value = false;
  // }

  //
  //
  //

  Future<void> updateAccount({
    required String email,
    required String name,
    required String contact,
    required String address,
    required String specialization,
    required String experience,
  }) async {
    isLoading.value = true;

    try {
      await FirebaseFirestore.instance
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'email': email,
        'name': name,
        'contact': contact,
        'category': specialization,
        'address': address,
        'experience': experience,
        'lawyerId': FirebaseAuth.instance.currentUser!.uid,
      });
      Get.snackbar('Success', 'Information updated');

      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Failed', 'Something went wrong');
      isLoading.value = false;

      Get.snackbar('Error', e.toString());
    }
  }

  Future<String> uploadProfilePicture() async {
    String imagePath =
        'profile_images/${FirebaseAuth.instance.currentUser!.uid}/';
    Reference storageReference = _storage.ref().child(imagePath);
    await storageReference.putFile(File(image!.path).absolute);

    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }
}
