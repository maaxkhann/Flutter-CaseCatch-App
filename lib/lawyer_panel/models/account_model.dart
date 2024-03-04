import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  final String lawyerId;
  final String name;
  final String contact;
  final String password;
  final String bar;
  final String email;
  final String category;
  final String address;
  final String experience;
  final String image;
  final String date;

  const AccountModel({
    required this.lawyerId,
    required this.name,
    required this.contact,
    required this.password,
    required this.bar,
    required this.email,
    required this.category,
    required this.address,
    required this.experience,
    required this.image,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'lawyerId': lawyerId,
        'name': name,
        'contact': contact,
        'password': password,
        'bar': bar,
        'email': email,
        'category': category,
        'address': address,
        'experience': experience,
        'image': image,
        'date': date,
      };

  factory AccountModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AccountModel(
      lawyerId: data["lawyerId"],
      name: data["name"],
      contact: data["contact"],
      password: data["password"],
      bar: data["bar"],
      email: data["email"],
      category: data["category"],
      address: data["address"],
      experience: data["experience"],
      image: data["image"],
      date: data["date"],
    );
  }
}
