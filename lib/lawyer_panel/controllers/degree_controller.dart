import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../authentication/office_address.dart';

class DegreeController extends GetxController {
  RxString pdfUrl = "".obs;
  RxBool isPdfUploading = false.obs;

  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  Future<void> addDegreeData(
    String batch,
    String name,
    String degree,
    String address,
  ) async {
    try {
      EasyLoading.show(status: "Please wait");

      // DegreeModel degreeModel = DegreeModel(
      //     batch: batch,
      //     clgName: name,
      //     degree: degree,
      //     documents: pdfUrl.value,
      //     address: address,
      //     id: FirebaseAuth.instance.currentUser!.uid

      //     );

      await db
          .collection('lawyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('degree')
          .add({
        'batch': batch,
        'clgName': name,
        'degree': degree,
        'documents': pdfUrl.value,
        'address': address,
        'id': FirebaseAuth.instance.currentUser!.uid
      });
      Get.to(() => const OfficeAddress());
      Fluttertoast.showToast(msg: "Information Added successfully");

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "$e",
      );
    }
  }

  void pickPDF() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        print("File Bytes: $fileBytes");

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final downloadURL = await response.ref.getDownloadURL();
        pdfUrl.value = downloadURL;
        print(downloadURL);
      } else {
        Fluttertoast.showToast(msg: 'File does not exis');
        print("File does not exist");
      }
    } else {
      print("No file selected");
      Fluttertoast.showToast(msg: 'No file selected');
    }
    isPdfUploading.value = false;
  }
  //
  //
  //  Future<void> uploadPdfs() async {
  //   isPdfUploading.value = true;

  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //       String fileName = result.files.first.name;

  //     // Upload the PDF to Firebase Storage
  //     Reference storageReference = FirebaseStorage.instance.ref().child(
  //         'user_pdfs/${FirebaseAuth.instance.currentUser!.uid}/${result.files.single.name}');
  //     UploadTask uploadTask = storageReference.putFile(file);

  //     await uploadTask.whenComplete(() async {
  //       String url = await storageReference.getDownloadURL();

  //      await FirebaseFirestore.instance.collection('documents').add({
  //         'pdfname': fileName,
  //         'pdfid': FirebaseAuth.instance.currentUser!.uid,
  //         'pdf': url,
  //         'timestamp': FieldValue.serverTimestamp(),
  //       });

  //       // Show a success message
  //     Get.snackbar('Success', 'PDF uploaded successfully');
  //   isPdfUploading.value = false;

  //     });
  //   }
  //  }
  //

  void uploadpdf() async {
    isPdfUploading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File file = File(result.files.first.path!);

      if (file.existsSync()) {
        Uint8List fileBytes = await file.readAsBytes();
        String fileName = result.files.first.name;
        print("File Bytes: $fileBytes");

        final response =
            await storage.ref().child("Pdf/$fileName").putData(fileBytes);

        final url = await response.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('documents')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'pdfname': fileName,
          'pdfid': FirebaseAuth.instance.currentUser!.uid,
          'pdf': url,
          'timestamp': FieldValue.serverTimestamp(),
        });
        print(url);
      } else {
        Fluttertoast.showToast(msg: 'File does not exis');
      }
    } else {
      Fluttertoast.showToast(msg: 'No file selected');
    }
    isPdfUploading.value = false;
  }

//
//
  Future<void> deletePdf(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('documents')
          .doc(id)
          .delete()
          .then((value) {});
      Get.snackbar('Success', 'Document successfully deleted!');
    } catch (e) {
      Get.snackbar('Error', 'Error deleting document: $e');
    }
  }
}
