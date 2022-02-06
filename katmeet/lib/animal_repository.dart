// ignore_for_file: avoid_classes_with_only_static_members

import 'package:amplify_flutter/amplify.dart';
import 'package:katmeet/models/AnimalModel.dart';
import 'package:katmeet/models/ModelProvider.dart';

class AnimalRepository {
  static Future<AnimalModel> getAnimalById(String animalId) async {
    try {
      final animals = await Amplify.DataStore.query(AnimalModel.classType,
          where: AnimalModel.ID.eq(animalId));
      return animals.isNotEmpty ? animals.first : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<AnimalModel> createAnimal(
      {TypeAnimal type,
      String race,
      String description,
      DateTime birthdate,
      UserModel animalOwner}) async {
    final newAnimal = new AnimalModel(
        type: type,
        race: race,
        description: description,
        birthdate: birthdate,
        animalOwner: animalOwner);
    try {
      await Amplify.DataStore.save(newAnimal);
      return newAnimal;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<List<AnimalModel>> getAnimalsByOwner(
      UserModel animalOwner) async {
    try {
      final animals = await Amplify.DataStore.query(AnimalModel.classType,
          where: AnimalModel.ANIMALOWNER.eq(animalOwner));
      return animals.isNotEmpty ? animals : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<AnimalModel> updateAnimal(AnimalModel updatedAnimal) async {
    try{
      await Amplify.DataStore.save(updatedAnimal);
      return updatedAnimal;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<bool> deleteAnimalById(String animalId) async {
    (await Amplify.DataStore.query(AnimalModel.classType, where: AnimalModel.ID.eq(animalId)))
        .forEach((element) async {
          try {
            await Amplify.DataStore.delete(element);
            print('Deleted animal');
            return true;
          } on Exception catch (e) {
            print('Delete failed: $e');
            return false;
          }
    });
    return false;
  }
}
