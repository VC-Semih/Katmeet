// ignore_for_file: avoid_classes_with_only_static_members

import 'package:amplify_flutter/amplify.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/ModelProvider.dart';
import 'package:katmeet/models/UserModelAnimalModel.dart';

class LikeRepository {
  static Future<List<AnimalModel>> getUserLikedAnimals(UserModel user) async {
    try {
      List<AnimalModel> animals;
      Amplify.DataStore.query(UserModelAnimalModel.classType,
              where: UserModelAnimalModel.USERMODEL.eq(user))
          .then((value) => {
                value.forEach((element) => {animals.add(element.animalmodel)})
              });
      return animals.isNotEmpty ? animals : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<List<UserModel>> getAnimalLikedUsers(AnimalModel animal) async {
    try {
      List<UserModel> users;
      Amplify.DataStore.query(UserModelAnimalModel.classType,
              where: UserModelAnimalModel.ANIMALMODEL.eq(animal))
          .then((value) => {
                value.forEach((element) => {users.add(element.usermodel)})
              });
      return users.isNotEmpty ? users : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<UserModelAnimalModel> createAnimalUserLink(
      UserModel user, AnimalModel animal) async {
    final UMAM = new UserModelAnimalModel(usermodel: user, animalmodel: animal);
    try {
      Amplify.DataStore.save(UMAM);
      return UMAM;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<bool> deleteAnimalUserLinkById(String UMAMid) async {
    (await Amplify.DataStore.query(UserModelAnimalModel.classType, where: UserModelAnimalModel.ID.eq(UMAMid)))
        .forEach((element) async {
          try {
            await Amplify.DataStore.delete(element);
            print('Deleted U-A_Link');
            return true;
          } on Exception catch (e) {
            print('Delete failed: $e');
            return false;
          }
    });
    return false;
  }
}
