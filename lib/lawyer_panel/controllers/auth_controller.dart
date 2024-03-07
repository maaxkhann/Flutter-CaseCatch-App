import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import '../authentication/signin_screen.dart';
import '../dashboard/dashboard.dart';
import '../models/account_model.dart';

class LawyerAuthController extends GetxController {
  //
  //
  RxBool isLoading = false.obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//

  Future<void> signUpMethod({
    required String name,
    required BuildContext context,
    required String contact,
    required String password,
    required String email,
    required String category,
    required String address,
    required String experience,
    required String date,
    required String price, required String practice,
  }) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Signing Up'), message: const Text('Please wait'));
    progressDialog.show();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uploadImage = await uploadProfilePicture();
      AccountModel accountModel = AccountModel(
          lawyerId: FirebaseAuth.instance.currentUser!.uid,
          name: name,
          contact: contact,
          password: password,
          email: email,
          category: category,
          address: address,
          experience: experience,
          image: uploadImage,
          date: date, price:price, practice: practice );

      if (userCredential.user != null) {
        await _firestore
            .collection('lawyers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(accountModel.toJson());
        progressDialog.dismiss();
        Fluttertoast.showToast(msg: 'Sign Up Successfully');
        Get.off(() => const Dashboard());
      }
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();
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
      progressDialog.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
//
//
//

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        title: const Text('Signing In'), message: const Text('Please wait'));
    progressDialog.show();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        progressDialog.dismiss();
        Fluttertoast.showToast(msg: 'Login Successfully');

        Get.off(() => const Dashboard());
      }
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();
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
      progressDialog.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  Future<void> resetmypassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Check your email for Password Reset Link');
      Get.to(() => const SigninScreen());
    } catch (e) {
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
        'profile_images/${FirebaseAuth.instance.currentUser!.uid}.png';
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
      uploadProfilePicture();
      isLoading.value = false;
    }
  }

  Future pickCameraimage() async {
    isLoading.value = true;

    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadProfilePicture();

      isLoading.value = false;
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 120,
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
  Future<void> setUserAlwaysAvailable() async {
    try {
      EasyLoading.show(status: 'Processing');
      await _firestore
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'available': 'All Time Available'}, SetOptions(merge: true));
      Fluttertoast.showToast(msg: 'Schedule saved successfully!');

      EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      EasyLoading.dismiss();
    }
  }
}
