// ignore_for_file: avoid_classes_with_only_static_members
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:katmeet/models/ModelProvider.dart';

class PhotoRepository{
  static Future<PhotosModel> getPhotosById(String photoId) async {
    try {
      final photos = await Amplify.DataStore.query(
        PhotosModel.classType,
        where: PhotosModel.ID.eq(photoId),
      );
      return photos.isNotEmpty ? photos.first : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<List<PhotosModel>> getPhotosByAnimalID(String animalID) async {
    try {
      final photos = await Amplify.DataStore.query(
        PhotosModel.classType,
        where: PhotosModel.ANIMALMODELID.eq(animalID),
      );
      return photos.isNotEmpty ? photos : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<List<PhotosModel>> getPhotosByS3Key(String s3Key) async {
    try {
      final photos = await Amplify.DataStore.query(
        PhotosModel.classType,
        where: PhotosModel.S3KEY.eq(s3Key),
      );
      return photos.isNotEmpty ? photos : null;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<PhotosModel> createPhoto(
      {String s3Key, String animalID}) async {
    final newPhoto = PhotosModel(s3key: s3Key, animalmodelID: animalID);
    try {
      await Amplify.DataStore.save(newPhoto);
      return newPhoto;
    } on Exception catch (e) {
      throw e;
    }
  }

  static Future<bool> deletePhotoByS3({String s3Key}) async {
    (await Amplify.DataStore.query(PhotosModel.classType, where: PhotosModel.S3KEY.eq(s3Key)))
        .forEach((element) async {
      try {
        await Amplify.DataStore.delete(element);
        print('Deleted a photo');
        return true;
      } on DataStoreException catch (e) {
        print('Delete failed: $e');
        return false;
      }
    });
    return false;
  }
}