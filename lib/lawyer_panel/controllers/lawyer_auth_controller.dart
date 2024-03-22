import 'dart:io';

import 'package:catch_case/constant-widgets/lawyer_bottom_var_bar.dart';
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

import '../authentication/lawyer_login_view.dart';

class LawyerAuthController extends GetxController {
  RxBool isLoading = false.obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpMethod({
    required String name,
    required String email,
    required String password,
    required String contact,
    required String address,
    required String category,
    required String practice,
    required String experience,
    required String bio,
  }) async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    String? token = await FirebaseMessaging.instance.getToken();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uploadImage = await uploadProfilePicture();

      if (userCredential.user != null) {
        await _firestore
            .collection('lawyers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'lawyerId': FirebaseAuth.instance.currentUser!.uid,
          'name': name,
          'contact': contact,
          'email': email,
          'category': category,
          'address': address,
          'experience': experience,
          'bio': bio,
          'image': uploadImage,
          'practice': practice,
          'fcmToken': token
        });
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Sign Up Successfully');
        Get.off(() => const LawyerLoginView());
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

  Future<void> loginUser(String email, String password) async {
    EasyLoading.show(status: 'loading..', dismissOnTap: true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Login Successfully');

        Get.to(() => const LawyerBottomNavigationBarWidget());
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
      Get.to(() => const LawyerLoginView());
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Failed', 'Something went wrong');
      Get.snackbar('Error', e.toString());
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

  Future<String> uploadProfilePicture() async {
    String imagePath =
        'profile_images/${FirebaseAuth.instance.currentUser!.uid}/';
    Reference storageReference = _storage.ref().child(imagePath);
    await storageReference.putFile(File(image!.path).absolute);

    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }

  Future pickGalleryimage() async {
    isLoading.value = true;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
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
}
