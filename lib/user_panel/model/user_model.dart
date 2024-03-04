import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String userId;
  final String image;
  final String username;
  final String password;

  const UserModel({
    required this.email,
    required this.userId,
    required this.image,
    required this.username,
    required this.password,
  });

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final snapshot = document.data()!;

    return UserModel(
      email: snapshot["email"],
      userId: snapshot["userId"],
      image: snapshot["image"],
      username: snapshot["username"],
      password: snapshot["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'userId': userId,
        'image': image,
        'username': username,
        'password': password,
      };
}
