import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LawyerCOntroller extends GetxController {
  //

  Stream<QuerySnapshot<Map<String, dynamic>>> allLawyers() {
    return FirebaseFirestore.instance.collection('lawyers').limit(4)
    .snapshots();
  }
}
