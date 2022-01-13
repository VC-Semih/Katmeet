// ignore_for_file: avoid_classes_with_only_static_members
import 'package:amplify_flutter/amplify.dart';

import 'models/UserModel.dart';

class UserRepository {
  static Future<UserModel> getUserById(String userId) async {
    try {
      final users = await Amplify.DataStore.query(
        UserModel.classType,
        where: UserModel.ID.eq(userId),
      );
      return users.isNotEmpty ? users.first : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<UserModel> getUserByUsername(String username) async {
    try {
      final users = await Amplify.DataStore.query(
        UserModel.classType,
        where: UserModel.USERNAME.eq(username),
      );
      return users.isNotEmpty ? users.first : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<UserModel> getUserByEmail(String email) async{
    try {
      final users = await Amplify.DataStore.query(
        UserModel.classType,
        where: UserModel.EMAIL.eq(email),
      );
      return users.isNotEmpty ? users.first : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<UserModel> createUser(
      {String userId, String username, String email}) async {
    final newUser = UserModel(id: userId, username: username, email: email);
    try {
      await Amplify.DataStore.save(newUser);
      return newUser;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<UserModel> updateUser(UserModel updatedUser) async {
    try {
      await Amplify.DataStore.save(updatedUser);
      return updatedUser;
    } on Exception catch (e) {
      throw e;
    }
  }
}
