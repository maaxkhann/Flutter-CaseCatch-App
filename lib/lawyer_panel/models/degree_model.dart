import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class DegreeModel {
  final String id;
  final String clgName;
  final String degree;
  final String batch;
 
  final String documents;
  final String address;

  const DegreeModel( {
    required this.batch,
    required this.clgName,
    required this.id,
    required this.degree,
    required this.documents,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'degree': degree,
        'batch': batch,
        'clgName': clgName,
        'documents': documents,
        'address': address,
      };

  factory DegreeModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DegreeModel(
      id: data["id"],
      degree: data["degree"],
      batch: data["batch"],
      clgName: data["clgName"],
      documents: data["documents"],
      address: data["address"],
    );
  }
}
