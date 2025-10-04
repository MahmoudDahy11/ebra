import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/user_entity.dart';

/*
 * UserModel class
 * represents a user model with email, name, and uid
 * includes methods for conversion between Firebase User, UserEntity, and JSON
 */
class UserModel {
  final String email;
  final String name;
  final String uId;

  UserModel({required this.email, required this.name, required this.uId});

  /* 
   * Factory constructor to create UserModel from Firebase User
   * maps Firebase User properties to UserModel properties
   */
  factory UserModel.fromFireBase(User user) {
    return UserModel(
      email: user.email ?? '',
      name: user.displayName ?? '',
      uId: user.uid,
    );
  }

  /* 
   * Factory constructor to create UserModel from UserEntity
   * maps UserEntity properties to UserModel properties
   */
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(email: user.email, name: user.name, uId: user.uId);
  }

  /*
   * Method to convert UserModel to UserEntity
   * maps UserModel properties to UserEntity properties
   */
  UserEntity toEntity() {
    return UserEntity(name: name, email: email, uId: uId);
  }

  /*
   * Factory constructor to create UserModel from JSON
   * maps JSON properties to UserModel properties
   */
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uid'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }
  /*
   * Method to convert UserModel to JSON
   * maps UserModel properties to JSON properties
   */
  Map<String, String> toJson() {
    return {'uid': uId, 'name': name, 'email': email};
  }
}
