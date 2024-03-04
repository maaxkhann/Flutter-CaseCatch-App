import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class OfficeModel {
  final String id;
  final String name;
  final String role;
  final String address;

  const OfficeModel({
    required this.role,
    required this.id,
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'address': address,
      };

  factory OfficeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return OfficeModel(
      id: data["id"],
      name: data["name"],
      role: data["role"],
      address: data["address"],
    );
  }
}
