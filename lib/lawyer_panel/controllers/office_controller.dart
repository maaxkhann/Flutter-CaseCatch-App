import 'package:catch_case/lawyer_panel/dashboard/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class OfficeController extends GetxController {
  RxString pdfUrl = "".obs;
  RxBool isPdfUploading = false.obs;

  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  Future<void> addOfficeAddress(
    String role,
    String name,
    String address,
  ) async {
    try {
      EasyLoading.show(status: "Please wait");

      // OfficeModel officeModel = OfficeModel(
      //     role: role,
      //     id: FirebaseAuth.instance.currentUser!.uid,
      //     name: name,
      //     address: address);

      await db
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('office')
          .add({
        'role': role,
        'id': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
        'address': address
      });
      Fluttertoast.showToast(msg: "Information Added successfully");
      Get.to(() => const Dashboard());
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
      );
    }
  }

  
}
