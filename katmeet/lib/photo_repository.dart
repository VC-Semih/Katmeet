// ignore_for_file: avoid_classes_with_only_static_members
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

  static Future<List<PhotosModel>> getPhotosByUserId(String userId) async {
    try {
      final photos = await Amplify.DataStore.query(
        PhotosModel.classType,
        where: PhotosModel.USERMODELID.eq(userId),
      );
      return photos.isNotEmpty ? photos : null;
    } on Exception catch (e) {
      throw e;
    }
  }
}